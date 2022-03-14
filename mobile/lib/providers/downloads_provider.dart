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
import 'package:shared_preferences/shared_preferences.dart';

class DownloadsProvider extends ChangeNotifier {
  List<String> downloadingMovies = [];
  Map<String, dynamic> data = {};

  void getDownloads() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getStringList("downloads") == null) {
      return;
    }
    List<String> prefsData = prefs.getStringList("downloads")!;
    for (var movieData in prefsData) {
      List<String> attributes = movieData.split("%%");
      var downloadData = {
        "movieId": attributes[0],
        "percentage": int.parse(attributes[1]),
        "file": attributes[2],
        "totalSize": int.parse(attributes[3]),
        "poster": attributes[4],
        "title": attributes[5]
      };
      data[attributes[0]] = downloadData;
    }
    notifyListeners();
  }

  void downloadMovie(String movieId) async {
    if (downloadingMovies.contains(movieId)) {
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

    SharedPreferences prefs = await SharedPreferences.getInstance();

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
        "totalSize": total,
        "poster": poster,
        "title": title
      };
      data[movieId] = downloadData;
      if (percentage >= 100) {
        print("setting");
        downloadingMovies.remove(movieId);
        if (prefs.getStringList("downloads") == null) {
          List<String> prefsData = [];
          prefsData.add(movieId +
              "%%" +
              percentage.toString() +
              "%%" +
              filePath +
              "%%" +
              total.toString() +
              "%%" +
              poster +
              "%%" +
              title);
          prefs.setStringList("downloads", prefsData);
        } else {
          List<String> prefsData = prefs.getStringList("downloads")!;
          if (!prefsData.contains(movieId +
              "%%" +
              percentage.toString() +
              "%%" +
              filePath +
              "%%" +
              total.toString() +
              "%%" +
              poster +
              "%%" +
              title)) {
            prefsData.add(movieId +
                "%%" +
                percentage.toString() +
                "%%" +
                filePath +
                "%%" +
                total.toString() +
                "%%" +
                poster +
                "%%" +
                title);
            prefs.setStringList("downloads", prefsData);
          }
        }
      }
      notifyListeners();
    });
  }
}
