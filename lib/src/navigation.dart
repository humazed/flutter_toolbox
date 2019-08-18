import 'package:flutter/material.dart';

Future<T> push<T extends Object>(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
