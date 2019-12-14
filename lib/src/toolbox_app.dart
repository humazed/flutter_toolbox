import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';

LinkedHashMap<_ToolboxAppState, BuildContext> contextMap = LinkedHashMap();

class ToolboxApp extends StatefulWidget {
  /// Usually should be [MaterialApp] or [CupertinoApp].
  final Widget child;

  const ToolboxApp({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  _ToolboxAppState createState() => _ToolboxAppState();
}

class _ToolboxAppState extends State<ToolboxApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    contextMap.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    contextMap[this] = context;

    return OKToast(
      textPadding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      position: ToastPosition.bottom,
      radius: 50,
      child: widget.child,
    );
  }
}
