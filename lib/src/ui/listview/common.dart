import 'package:flutter/material.dart';
import 'package:flutter_toolbox/src/ui/listview/pagewise/flutter_pagewise.dart';

NoItemsFoundBuilder noItemsFoundBuilder(
  NoItemsFoundBuilder noItemsFoundBuilder,
  Widget noItemsFoundWidget,
) {
  final defaultNoItemsFoundBuilder = noItemsFoundWidget == null
      ? null
      : (BuildContext context) {
          final height = MediaQuery.of(context).size.height - 124;
          return SizedBox(
            height: height,
            child: Center(
              child: noItemsFoundWidget,
            ),
          );
        };

  return noItemsFoundBuilder ?? defaultNoItemsFoundBuilder;
}
