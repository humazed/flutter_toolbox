import 'package:flutter/material.dart';

extension ImageUtil on String {
  String getSizedFormattedUrl(BuildContext context, {int width, int height}) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    if (width != null) width = (width * devicePixelRatio).toInt();
    if (height != null) height = (height * devicePixelRatio).toInt();

    var uri = Uri.tryParse(this);
    if (uri != null) {
      Map<String, String> queryParams =
          Map<String, String>.from(uri.queryParameters);
      if (width != null) {
        queryParams['w'] = width.toString();
      }
      if (height != null) {
        queryParams['h'] = height.toString();
      }
      uri = uri.replace(queryParameters: queryParams);
    }
    return uri?.toString() ?? "";
  }
}
