import 'dart:io' show Platform;

import 'package:flutter_toolbox/generated/l10n.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../flutter_toolbox.dart';

Future<void> launchMaps(double latitude, double longitude) async {
  if (Platform.isIOS) {
    String appleMapsUrl = 'https://maps.apple.com/?q=$latitude,$longitude';
    if (await canLaunchUrlString(appleMapsUrl)) {
      await launchUrlString(appleMapsUrl);
      return;
    }
  } else {
    await launchGoogleMaps(latitude, longitude);
  }
}

Future<void> launchGoogleMaps(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  if (await canLaunchUrlString(googleUrl)) {
    await launchUrlString(googleUrl);
  } else {
    errorToast(S.current.could_not_launch_google_maps);
  }
}

Future<void> safeLaunch(String urlString) async {
  if (await canLaunchUrlString(urlString)) {
    await launchUrlString(urlString);
  } else {
    errorToast(S.current.couldnt_open_this_url);
  }
}

Future<void> sendMail({
  required String email,
  String subject = '',
  String body = '',
}) async {
  var url = 'mailto:$email?subject=$subject&body=$body';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    errorToast(S.current.couldnt_open_the_mail_app);
  }
}

Future<void> call(String phone) async {
  var url = 'tel:$phone';
  if (await canLaunchUrlString(url)) {
    await launchUrlString(url);
  } else {
    errorToast(S.current.couldnt_open_the_phone_app);
  }
}
