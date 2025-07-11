import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final int? qtd;
  const BadgeWidget({super.key, this.qtd});
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 9,
      child: Container(
        height: 17,
        width: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFFffce1a),
        ),
        padding: EdgeInsets.all(3),
        child: Text(
          qtd?.toString() ?? "",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
