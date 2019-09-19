import 'package:flutter/material.dart';
import 'package:youtube_dl/state_provider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
        child: Column(children: [
      Text(
        "Welcome! :)",
        textAlign: TextAlign.center,
      ),
      Text(
        "Search for Videos in the top bar",
        textAlign: TextAlign.center,
      )
    ]));
  }
}
