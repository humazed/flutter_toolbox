import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';

Future push(BuildContext context, Widget widget, {bool setName = true}) =>
    _safeNav(
      context,
      widget,
      () => Navigator.push(context, materialRoute(widget, setName: setName)),
    );

Future pushReplacement(BuildContext context, Widget widget) => _safeNav(
      context,
      widget,
      () => Navigator.pushReplacement(context, materialRoute(widget)),
    );

/// you can pass null to [untilPage] and it will clear the stack
Future pushAndRemoveUntil(
  BuildContext context,
  Widget widget,
  Widget untilPage,
) {
  return _safeNav(
    context,
    widget,
    () {
      return Navigator.pushAndRemoveUntil(
        context,
        materialRoute(widget),
        (Route<dynamic> route) => route.settings.name == untilPage?.toString(),
      );
    },
  );
}

MaterialPageRoute materialRoute(Widget widget, {bool setName = true}) =>
    MaterialPageRoute(
      builder: (context) => widget,
      settings: setName ? RouteSettings(name: widget.toString()) : null,
    );

// only navigate if the page in [isUnAuthenticatedPage] or the user [isAuthenticated]
// also navigate if [isUnAuthenticatedPage] or [isAuthenticated] is unset
Future _safeNav(BuildContext context, Widget widget, Function() onCanNavigate) {
  final config = ToolboxConfig.of(context, listen: false);

  final isUnAuthenticatedPage =
      config.unAuthenticatedPages?.contains(widget.runtimeType) ?? true;

  if (isUnAuthenticatedPage || config.isAuthenticated() != false) {
    return onCanNavigate();
  } else {
    return config.onAuthorizedNavigation(context, widget.runtimeType);
  }
}
