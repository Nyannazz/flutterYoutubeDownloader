import 'package:flutter/material.dart';
import './sqlLite/video_model.dart';

import './videos.dart';

class VideoManager extends StatefulWidget {
  final List initialData;
  VideoManager({this.initialData});
  @override
  State<StatefulWidget> createState() {
    return _VideoManagerState();
  }
}

class _VideoManagerState extends State<VideoManager> {
  List _videos = [];

  @override
  void initState() {
    super.initState();
    _videos = widget.initialData;
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
        Videos(_videos)
      ],
    );
  }
}
