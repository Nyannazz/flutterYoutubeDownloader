import 'package:flutter/material.dart';

bool filterFormat(str, val) {
  List strParts = str.split("/");
  return strParts[0] == val;
}

List<Widget> createFormatList(arr) {
  List<Widget> formatList = [];
  for (Map item in arr) {
    formatList.add(Align(alignment: Alignment.centerLeft ,child: Text(item["type"])));
    formatList.add(Align(alignment: Alignment.centerLeft ,child: Text(item["quality"])));
    formatList.add(Center(child: Container(height: 30.0, child: RaisedButton(child: Text("DOWNLOAD")))));
  }

  return formatList;
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        children: createFormatList(videoFormats)),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: GridView.count(
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        children: createFormatList(audioFormats)),
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
