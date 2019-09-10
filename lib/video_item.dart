import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  final dynamic video;
  const VideoItem({Key key, this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 4,
              child: Container(
                  constraints: BoxConstraints.expand(height: 50.0),
                  color: Colors.red)),
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
