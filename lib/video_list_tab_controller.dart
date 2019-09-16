import 'package:flutter/material.dart';
import './video_list_tab.dart';

class VideoListTabController extends StatefulWidget {
  final List videoList;
  VideoListTabController({Key key, this.videoList}) : super(key: key);

  _VideoListTabControllerState createState() => _VideoListTabControllerState();
}

class _VideoListTabControllerState extends State<VideoListTabController> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Card(
            child: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.ondemand_video, color: Colors.deepPurple),
                ),
                Tab(
                  icon: Icon(Icons.audiotrack, color: Colors.deepPurple),
                ),
              ],
            ),
          ),
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: TabBarView(
                children: [
                  VideoListTab(videoList: widget.videoList),
                  VideoListTab(videoList: widget.videoList),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
