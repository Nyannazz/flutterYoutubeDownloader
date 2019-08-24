import 'package:flutter/material.dart';
import './image_tab.dart';
import './format_select.dart';

class VideoView extends StatelessWidget {
  final Map data;
  VideoView(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: Text(
              ((data.containsKey("title")) ? data["title"] : "waiting"),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
            ),
          ),
          ImageTab(data["thumbnail"]),
          Expanded(
            child: FormatSelect(data["formats"]),
          ),
        ],
      ),
    );
  }
}
