import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iva_app/app/core/utils/external-browser.dart';

class FooterWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color foregroundColor;
  final Color iconColor;

  const FooterWidget(
      {required this.backgroundColor,
      required this.foregroundColor,
      required this.iconColor,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: backgroundColor,
      child: footer(),
    );
  }

  Stack footer() {
    return Stack(
      children: [
        Container(
          height: 70.0,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(40.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: FaIcon(FontAwesomeIcons.facebook),
                color: iconColor,
                onPressed: () {
                  launchURL("https://www.facebook.com/METALURGICOSSP");
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.twitter),
                color: iconColor,
                onPressed: () {
                  launchURL("https://twitter.com/spmetalurgicos");
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.youtube),
                color: iconColor,
                onPressed: () {
                  launchURL(
                      "https://www.youtube.com/channel/UCXXT6eaYqaBITGgpWX1WilQ");
                },
              ),
              IconButton(
                icon: FaIcon(FontAwesomeIcons.instagram),
                color: iconColor,
                onPressed: () {
                  launchURL(
                      "https://instagram.com/sindicatometalsp?igshid=MzRlODBiNWFlZA==");
                },
              ),
            ],
          ),
        ),
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          child: CustomPaint(
            size: Size.infinite,
          ),
        ),
      ],
    );
  }
}
