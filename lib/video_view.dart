import 'package:flutter/material.dart';
import './image_tab.dart';
import './format_tabs.dart';

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
            margin: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 8.0),
            child: Text(
              data["title"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: ImageTab(data["thumbnail"])),
          Expanded(
            child: FormatTabs(data["formats"], data["title"]),
          ),
        ],
      ),
    );
  }
}
