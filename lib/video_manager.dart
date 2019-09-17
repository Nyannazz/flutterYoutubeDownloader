import 'package:flutter/material.dart';
import './video_list_tab_controller.dart';
/* import './sqlLite/video_model.dart';
import './video_list_tab.dart';
import './videos.dart'; */
import './sqlLite/database.dart';
import './sqlLite/video_model.dart';

class VideoManager extends StatefulWidget {
  VideoManager();
  @override
  State<StatefulWidget> createState() {
    return _VideoManagerState();
  }
}

class _VideoManagerState extends State<VideoManager> {
  List _videos = [];

  @override
  void initState() {
    DBProvider.db.getAllVideos().then(
          (e) => e.forEach(
            (item) {
              String videoJson = videoToJson(item);
              setState(() {
                _videos.add(videoJson);
              });
            },
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* _videos.forEach((e) => print("\n\n\n"+e)); */
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10.0),
          child: Text("YOUR VIDEOS"),
        ),
        VideoListTabController(videoList: _videos)
      ],
    );
  }
}
