import 'package:flutter/material.dart';
import './format_select.dart';

bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

class FormatTabs extends StatelessWidget {
  final List formats;
  final String videoTitle;
  final String thumbnail;
  FormatTabs(
      {Key key,
      String this.thumbnail,
      String this.videoTitle,
      List this.formats = const []})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List audioFormats =
        formats.where((item) => filterFormat(item["type"], "audio")).toList();
    final List videoFormats =
        formats.where((item) => filterFormat(item["type"], "video")).toList();
    return Card(
      child: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Card(
              child: TabBar(
                tabs: [
                  Tab(
                      icon:
                          Icon(Icons.ondemand_video, color: Colors.deepPurple)),
                  Tab(icon: Icon(Icons.audiotrack, color: Colors.deepPurple)),
                ],
              ),
            ),
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: TabBarView(
                  children: [
                    FormatSelect(videoFormats, videoTitle),
                    FormatSelect(audioFormats, videoTitle),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
