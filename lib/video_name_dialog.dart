import 'package:flutter/material.dart';

class VideoNameDialog extends StatefulWidget {
  final Function submitForm;
  final String initialContent;
  VideoNameDialog(
      {Key key, String this.initialContent, Function this.submitForm})
      : super(key: key);

  _VideoNameDialogState createState() => _VideoNameDialogState();
}

class _VideoNameDialogState extends State<VideoNameDialog> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _textController = new TextEditingController(text: widget.initialContent);
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "change filename",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _textController,
                          onSubmitted: (value) {
                            widget.submitForm(value);
                            /* close dialog after submit */
                            Navigator.of(context, rootNavigator: true)
                                .pop('dialog');
                          },
                        ),
                      ),
                      Center(
                          child: ButtonBar(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("DOWNLOAD"),
                            onPressed: () {
                              widget.submitForm(_textController.text);
                              Navigator.of(context, rootNavigator: true)
                                  .pop('dialog');
                            },
                          ),
                          RaisedButton(
                            child: Text("CLOSE"),
                            onPressed: () =>
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog'),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              );
            });
      },
      child: Text("DOWNLOAD"),
    );
  }
}
