import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';

/// Provides a stable route name for navigation.
///
/// In Flutter web release builds, class names are minified (e.g., "PaginatedListViewPage"
/// becomes "ah7"), which results in URLs like `http://localhost:56917/#ah7` instead of
/// readable URLs like `http://localhost:57425/#PaginatedListViewPage`.
///
/// Implement this mixin on your page widgets to provide explicit, stable route names
/// that will appear in the URL hash on web platforms.
///
/// Example:
/// ```dart
/// class MyPage extends StatelessWidget with RouteNameProvider {
///   const MyPage({super.key});
///
///   @override
///   String get routeName => 'MyPage';
///
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: const Text('My Page')),
///     );
///   }
/// }
/// ```
///
/// If a widget doesn't implement this mixin, the navigation helpers will fall back
/// to using `runtimeType.toString()`, which will be minified in release builds.
mixin RouteNameProvider on Widget {
  String get routeName;
}

Future push(
  BuildContext context,
  Widget widget, {
  bool setName = true,
  bool authCheck = true,
}) =>
    _safeNav(
      context,
      widget,
      () => Navigator.push(
        context,
        materialRoute(widget, setName: setName),
      ),
      authCheck: authCheck,
    );

Future pushReplacement(
  BuildContext context,
  Widget widget, {
  bool authCheck = true,
}) =>
    _safeNav(
      context,
      widget,
      () => Navigator.pushReplacement(context, materialRoute(widget)),
      authCheck: authCheck,
    );

/// you can pass null to [untilPage] and it will clear the stack
Future pushAndRemoveUntil(
  BuildContext context,
  Widget widget,
  Widget? untilPage, {
  bool authCheck = true,
}) {
  return _safeNav(
    context,
    widget,
    () {
      return Navigator.pushAndRemoveUntil(
        context,
        materialRoute(widget),
        (Route<dynamic> route) {
          if (untilPage == null) return false;
          return route.settings.name == _resolveName(untilPage);
        },
      );
    },
    authCheck: authCheck,
  );
}

MaterialPageRoute materialRoute(Widget widget, {bool setName = true}) =>
    MaterialPageRoute(
      builder: (context) => widget,
      settings: setName ? RouteSettings(name: _resolveName(widget)) : null,
    );

String _resolveName(Widget widget) {
  if (widget is RouteNameProvider) {
    return widget.routeName;
  }
  return widget.runtimeType.toString();
}

// only navigate if the page in [isUnAuthenticatedPage] or the user [isAuthenticated]
// also navigate if [isUnAuthenticatedPage] or [isAuthenticated] is unset
Future _safeNav(
  BuildContext context,
  Widget widget,
  Function() onCanNavigate, {
  bool authCheck = true,
}) {
  final config = ToolboxConfig.of(context, listen: false);

  final isUnAuthenticatedPage =
      config.unAuthenticatedPages?.contains(widget.runtimeType) ?? true;

  if (isUnAuthenticatedPage ||
      config.isAuthenticated!() != false ||
      authCheck == false) {
    return onCanNavigate();
  } else {
    return config.onAuthorizedNavigation!(context, widget.runtimeType);
  }
}
