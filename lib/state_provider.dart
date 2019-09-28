import 'package:flutter/material.dart';

class StateProvider extends InheritedWidget {
  final Map videoData;
  final Function refreshVideo;
  final String videoUrl;
  final Widget child;
  StateProvider({
    Key key,
    @required this.child,
    this.videoData,
    this.refreshVideo,
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
