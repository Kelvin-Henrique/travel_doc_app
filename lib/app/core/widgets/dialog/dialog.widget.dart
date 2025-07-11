import 'package:flutter/material.dart';

class DialogWidget extends StatefulWidget {
  final String? title;
  final String? content;
  final String yes;
  final String no;
  final Function? yesOnPressed;
  final Function? noOnPressed;

  const DialogWidget(
      {super.key,
      this.title,
      this.content,
      this.yesOnPressed,
      this.noOnPressed,
      this.yes = "Yes",
      this.no = "No"});

  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title ?? "",
        style: TextStyle(
          fontSize: 21,
          color: Colors.white,
        ),
      ),
      content: Text(
        widget.content ?? "",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      actions: <Widget>[
        widget.noOnPressed != null
            ? TextButton(
                child: Text(widget.no),
                onPressed: () {
                  widget.noOnPressed!();
                },
              )
            : SizedBox(),
        TextButton(
          child: Text(widget.yes),
          onPressed: () {
            widget.yesOnPressed!();
          },
        ),
      ],
    );
  }
}
