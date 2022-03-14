import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:netflixclone/providers/user.dart';
import 'package:netflixclone/utils/api.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DownloadsProvider extends ChangeNotifier {
  List<String> downloadingMovies = [];
  Map<String, dynamic> data = {};

  void downloadMovie(String movieId) async {
    if(downloadingMovies.contains(movieId)){
      return;
    }
    downloadingMovies.add(movieId);
    notifyListeners();

    String token = Provider.of<UserProvider>(Get.context!, listen: false).token;
    Map<String, String> headers = {
      "Authorization": "JWT $token",
      "Content-Type": "application/json"
    };

    Map<String, dynamic> body = {"movieId": movieId};

    var response = await http.post(
      Uri.parse("$serverURL/movies/get-download-url"),
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 404 || response.body == "File not found") {
      Fluttertoast.showToast(
          msg: "File not available", backgroundColor: primaryColor);
      downloadingMovies.remove(movieId);
      notifyListeners();

      return;
    }

    print(response.body);

    String downloadUrl = jsonDecode(response.body)["url"];
    String title = jsonDecode(response.body)["title"];
    String poster = jsonDecode(response.body)["poster"];

    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = directory.path + jsonDecode(response.body)["fileName"];
    Dio dio = Dio();
    dio.download(downloadUrl, filePath, onReceiveProgress: (received, total) {
      int percentage = ((received / total) * 100).floor();
      var downloadData = {
        "movieId": movieId,
        "percentage": percentage,
        "file": filePath,
        "totalSize" : total,
        "poster" : poster,
        "title" : title
      };
      data[movieId] = downloadData;
      if (percentage >= 100) {
        downloadingMovies.remove(movieId);
      }
      notifyListeners();
    });
  }
}
