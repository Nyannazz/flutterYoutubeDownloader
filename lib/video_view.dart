import 'package:flutter/material.dart';
import './image_tab.dart';
import './format_select.dart';


class VideoView extends StatelessWidget{
  final Map data;
  VideoView(this.data);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            ((data.containsKey("title"))
                                ? data["title"]
                                : "waiting"),
                            textAlign: TextAlign.center),
                      ),
                      ImageTab(data["thumbnail"]),
                      FormatSelect(data["formats"]),
                    ],
                  ),
                ),
    );
  }
}