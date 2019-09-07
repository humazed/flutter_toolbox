import 'package:flutter/material.dart';

Future push(BuildContext context, Widget widget, {bool setName = true}) =>
    Navigator.of(context).push(materialRoute(widget, setName: setName));

Future pushReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(context, materialRoute(widget));

MaterialPageRoute materialRoute(Widget widget, {bool setName = true}) =>
    MaterialPageRoute(
      builder: (context) => widget,
      settings: setName ? RouteSettings(name: widget.toString()) : null,
    );

/// you can pass null to [untilPage] and it will clear the stack
Future pushAndRemoveUntil(
        BuildContext context, Widget widget, Widget untilPage) =>
    Navigator.of(context).pushAndRemoveUntil(
      materialRoute(widget),
      (Route<dynamic> route) => route.settings.name == untilPage?.toString(),
    );
