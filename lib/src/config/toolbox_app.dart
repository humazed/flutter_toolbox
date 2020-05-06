import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_toolbox/src/config/toolbox_config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

LinkedHashMap<_ToolboxAppState, BuildContext> contextMap = LinkedHashMap();

class ToolboxApp extends StatefulWidget {
  const ToolboxApp({
    Key key,
    @required this.child,
    this.toolboxConfig,
  }) : super(key: key);

  /// Usually should be [MaterialApp] or [CupertinoApp].
  final Widget child;

  final ToolboxConfig toolboxConfig;

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
      child: Provider.value(
        value: widget.toolboxConfig,
        child: widget.child,
      ),
    );
  }
}
