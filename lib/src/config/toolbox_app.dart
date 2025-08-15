import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:flutter_toolbox/src/config/toolbox_config.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

LinkedHashMap<_ToolboxAppState, BuildContext> _contextMap = LinkedHashMap();

class ToolboxApp extends StatefulWidget {
  const ToolboxApp({
    super.key,
    required this.child,
    this.toolboxConfig,
  });

  /// Usually should be [MaterialApp] or [CupertinoApp].
  final Widget child;

  final ToolboxConfig? toolboxConfig;

  @override
  createState() => _ToolboxAppState();
}

class _ToolboxAppState extends State<ToolboxApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _contextMap.remove(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _contextMap[this] = context;

    return OKToast(
      textPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      position: ToastPosition.bottom,
      radius: 50,
      child: Provider.value(
        value: widget.toolboxConfig,
        child: widget.child,
      ),
    );
  }
}
