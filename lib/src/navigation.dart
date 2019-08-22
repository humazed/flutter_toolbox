import 'package:flutter/material.dart';

Future push(BuildContext context, Widget widget) =>
    Navigator.push(context, materialRoute(widget));

Future pushReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(context, materialRoute(widget));

MaterialPageRoute materialRoute(Widget widget) =>
    MaterialPageRoute(builder: (context) => widget);
