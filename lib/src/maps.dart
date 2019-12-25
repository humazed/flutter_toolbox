import 'package:flutter_toolbox/generated/i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../flutter_toolbox.dart';

Future<void> launchGoogleMaps(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunch(googleUrl)) {
    await launch(googleUrl);
  } else {
    errorToast(S.current.could_not_launch_google_maps);
  }
}
