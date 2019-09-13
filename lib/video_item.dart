import 'dart:convert';

import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final dynamic video;
  const VideoItem({Key key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map videoJson=jsonDecode(video);
    return Card(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Image.network(videoJson["thumbnailPath"]),
          ),
          Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "asd",
                      textAlign: TextAlign.left,
                    ),
                    Text("sadsadad", textAlign: TextAlign.left),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
