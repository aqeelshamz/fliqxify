import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netflixclone/providers/downloads_provider.dart';
import 'package:netflixclone/utils/colors.dart';
import 'package:netflixclone/utils/size.dart';
import 'package:provider/provider.dart';

List downloads = [];

class Downloads extends StatefulWidget {
  const Downloads({Key? key}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Downloads",
          style: TextStyle(
            color: white,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: height * 0.04,
        ),
        Expanded(
          child: Provider.of<DownloadsProvider>(context).data.keys.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        FeatherIcons.download,
                        color: grey2,
                        size: width * 0.2,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text(
                        "No Downloads",
                        style: TextStyle(
                          color: grey2,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: Provider.of<DownloadsProvider>(context).data.keys.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(borderRadius * 2),
                      child: Container(
                        padding: EdgeInsets.all(width * 0.04),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(borderRadius * 2),
                              child: Image.network(
                                  "https://image.tmdb.org/t/p/w200" + Provider.of<DownloadsProvider>(context).data[Provider.of<DownloadsProvider>(context).data.keys.toList()[index]]["poster"],
                                  width: width * 0.3,
                                  height: height * 0.1,
                                  fit: BoxFit.cover),
                            ),
                            SizedBox(width: width * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Provider.of<DownloadsProvider>(context).data[Provider.of<DownloadsProvider>(context).data.keys.toList()[index]]["title"],
                                    style: TextStyle(
                                        color: white, fontSize: 15.sp),
                                  ),
                                  Text(
                                    (int.parse(Provider.of<DownloadsProvider>(context).data[Provider.of<DownloadsProvider>(context).data.keys.toList()[index]]["totalSize"].toString()) / 1000000).floor().toString() + " MB",
                                    style: TextStyle(
                                        color: white, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            Column(
                              children: [
                                Icon(FeatherIcons.checkCircle, color: white)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
