import 'package:flutter/material.dart';

bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

class FormatSelect extends StatelessWidget {
  final List formats;
  FormatSelect([this.formats = const []]);

  @override
  Widget build(BuildContext context) {
    final List audioFormats =
        formats.where((item) => filterFormat(item["type"], "audio")).toList();
    final List videoFormats =
        formats.where((item) => filterFormat(item["type"], "video")).toList();
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.ondemand_video, color: Colors.deepPurple)),
                Tab(icon: Icon(Icons.audiotrack, color: Colors.deepPurple)),
              ],
            ),
          ),
          Expanded(
              child: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: TabBarView(
              children: [
                Card(
                    child: ListView(
                  children: videoFormats
                      .map((item) =>
                          Text(item["type"], textAlign: TextAlign.center))
                      .toList(),
                )),
                Card(
                  child: ListView(
                    children: audioFormats
                        .map((item) =>
                            Text(item["type"], textAlign: TextAlign.center))
                        .toList(),
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
