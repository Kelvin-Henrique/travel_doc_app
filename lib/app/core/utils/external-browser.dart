import 'package:url_launcher/url_launcher.dart';

launchURL(String url) async {
  await launch(url);
  if (await canLaunch(url)) {
  } else {
    throw 'Could not launch $url';
  }
}
