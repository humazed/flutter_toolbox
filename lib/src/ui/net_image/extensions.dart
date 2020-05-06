import 'dart:math';

import 'package:flutter/material.dart';

extension ImageUtil on String {
  String getSizedFormattedUrl(BuildContext context, {int width, int height}) {
    // this doesn't work in init state and using it inside the build method causes rebuilds.
    // so setting the ratio to 1 for now.
    var devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
//    final pixelRatio = 1;
    final pixelRatio = max(devicePixelRatio, 1.5);

    String widthPram = '';
    String heightPram = '';
    if (width != null) {
      width = (width * pixelRatio).toInt();
      widthPram = '&w=$width';
    }
    if (height != null) {
      height = (height * pixelRatio).toInt();
      heightPram = '&h=$height';
    }

    return '${this}$widthPram$heightPram';
  }
}
