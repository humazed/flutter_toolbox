import 'package:flutter/material.dart';
import 'package:flutter_toolbox/src/ui/listview/pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';

class ToolboxConfig {
  ToolboxConfig({
    this.noItemsFoundBuilder,
    this.noItemsFoundWidget,
    this.useWeservResizer = false,
    this.logLoadedImageUrl = false,
    this.unAuthenticatedPages,
    this.isAuthenticated,
    this.onAuthorizedNavigation,
  });

  final NoItemsFoundBuilder noItemsFoundBuilder;
  final Widget noItemsFoundWidget;
  final bool useWeservResizer;
  final bool logLoadedImageUrl;

  final List<Type> unAuthenticatedPages;
  final bool Function() isAuthenticated;
  final Future Function(BuildContext context, Type pageType)
      onAuthorizedNavigation;

  static ToolboxConfig of(BuildContext context, {bool listen = true}) =>
      Provider.of<ToolboxConfig>(context, listen: listen);
}
