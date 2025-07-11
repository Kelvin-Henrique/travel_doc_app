import 'package:flutter/material.dart';
import 'package:iva_app/themes/flavors.dart';

class FlavorBanner extends StatelessWidget {
  final Widget child;
  BannerConfig? bannerConfig;
  FlavorBanner({super.key, required this.child, this.bannerConfig});

  @override
  Widget build(BuildContext context) {
    if (F.appFlavor == Flavor.PROD) return child;
    bannerConfig ??= _getDefaultBanner();
    return Stack(
      children: <Widget>[child, _buildBanner(context)],
    );
  }

  BannerConfig _getDefaultBanner() {
    return BannerConfig(
      bannerName: "Homologação",
      bannerColor: Colors.green,
    );
  }

  Widget _buildBanner(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CustomPaint(
        painter: BannerPainter(
          message: bannerConfig?.bannerName ?? "",
          textDirection: Directionality.of(context),
          layoutDirection: Directionality.of(context),
          location: BannerLocation.topStart,
          color: bannerConfig?.bannerColor ?? Colors.red,
        ),
      ),
    );
  }
}

class BannerConfig {
  final String bannerName;
  final Color bannerColor;
  BannerConfig({required this.bannerName, required this.bannerColor});
}
