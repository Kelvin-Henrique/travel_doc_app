import 'package:flutter/material.dart';

class CardScaffold extends StatelessWidget {
  final Function? onTap;
  final double? height;
  final List<Widget>? listItem;
  final Color color;
  final double width;
  final MainAxisAlignment mainAxisAlignment;

  const CardScaffold(
      {super.key,
      this.onTap,
      this.height,
      this.listItem,
      this.color = Colors.white,
      this.width = double.infinity,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Card(
        elevation: 1,
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listItem ?? <Widget>[],
        ),
      ),
    );
  }
}
