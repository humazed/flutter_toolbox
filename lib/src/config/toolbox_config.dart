import 'package:flutter/material.dart';
import 'package:flutter_toolbox/src/ui/listview/pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';

class ToolboxConfig {
  ToolboxConfig({
    this.noItemsFoundBuilder,
    this.noItemsFoundWidget,
    this.useWeservResizer = false,
  });

  final NoItemsFoundBuilder noItemsFoundBuilder;
  final Widget noItemsFoundWidget;
  final bool useWeservResizer;

  static ToolboxConfig of(BuildContext context) =>
      Provider.of<ToolboxConfig>(context);
}
