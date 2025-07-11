import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onTap;
  final String description;
  final Color color;
  final Color? textColor;
  final double? left;
  final double? right;

  const ButtonWidget(
      {super.key,
      required this.onTap,
      required this.description,
      required this.color,
      this.left = 30,
      this.right = 30,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          left: left ?? 30,
          right: right ?? 30,
        ),
        child: Container(
          height: 50.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20.0, // has the effect of softening the shadow
                spreadRadius: 5.0, // has the effect of extending the shadow
                offset: Offset(
                  5.0, // horizontal, move right 10
                  5.0, // vertical, move down 10
                ),
              ),
            ],
            color: color,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: OutlinedButton(
            onPressed: () {
              onTap();
            },
            child: Text(
              description,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
