import 'package:flutter/material.dart';

class StateProvider extends InheritedWidget {
  final Map videoData;
  final Function getVideo;
  final String videoUrl;
  final Widget child;
  StateProvider({
    Key key,
    @required this.child,
    this.videoData,
    this.getVideo,
    this.videoUrl,
  }) : super(key: key, child: child);

  static StateProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(StateProvider);
  }

  @override
  bool updateShouldNotify(StateProvider oldWidget) {
    return videoUrl != oldWidget.videoUrl;
  }
}
