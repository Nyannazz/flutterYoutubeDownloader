import 'package:flutter/material.dart';

import './videos.dart';

class VideoManager extends StatefulWidget {
  final initialData;
  VideoManager({this.initialData});
  @override
  State<StatefulWidget> createState() {
    return _VideoManagerState();
  }
}

class _VideoManagerState extends State<VideoManager> {
  List<String> _videos = ['Red Panda'];

  @override
  void initState(){
    /* _videos.add(widget.initialData); */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
      margin: EdgeInsets.all(10.0),
      child: RaisedButton(
          onPressed: () {
            setState(() {
              _videos.add('cat video');
            });
          },
          child: Text('Add Product')),
    ),
    Videos(_videos)
    ],) ;
  }
}
