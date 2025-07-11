import 'package:flutter/material.dart';

class BadgeTextWidget extends StatelessWidget {
  final String? text;
  final bool topRight;
  const BadgeTextWidget({super.key, this.text, this.topRight = true});

  badge() => Container(
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          shape: BoxShape.rectangle,
          color: Colors.red,
        ),
        padding: EdgeInsets.all(7),
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: topRight
          ? Positioned(
              right: 0,
              child: badge(),
            )
          : Positioned(
              right: 0,
              bottom: 0,
              child: badge(),
            ),
    );
  }
}
