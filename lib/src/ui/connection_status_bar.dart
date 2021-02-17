import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_toolbox/generated/l10n.dart';

class ConnectionStatusBar extends StatefulWidget {
  final Widget title;
  final Color color;

  ConnectionStatusBar({this.title, this.color, Key key}) : super(key: key);

  _ConnectionStatusBarState createState() => _ConnectionStatusBarState();

  static void init(BuildContext context) async {
    if (kIsWeb) return;

    final overlayEntry = OverlayEntry(
      builder: (BuildContext context) => IgnorePointer(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: ConnectionStatusBar(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    SchedulerBinding.instance.addPostFrameCallback((_) {
      Overlay.of(context).insert(overlayEntry);
    });
  }
}

class _ConnectionStatusBarState extends State<ConnectionStatusBar>
    with SingleTickerProviderStateMixin {
  StreamSubscription _connectionChangeStream;
  bool _hasConnection = true;
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    _ConnectionStatusSingleton connectionStatus =
        _ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize();
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));

    offset = Tween<Offset>(begin: Offset(0.0, -1.0), end: Offset(0.0, 0.0))
        .animate(controller);
    super.initState();
  }

  void _connectionChanged(bool hasConnection) {
    if (_hasConnection == hasConnection) return;
    hasConnection == false ? controller.forward() : controller.reverse();
    _hasConnection = hasConnection;
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: offset,
      child: Container(
        child: SafeArea(
          bottom: false,
          child: Container(
            color: widget.color != null ? widget.color : Colors.redAccent,
            width: double.maxFinite,
            height: 25,
            child: Center(
              child: widget.title != null
                  ? widget.title
                  : Text(
                      S.of(context)?.please_check_your_internet_connection ??
                          'Please check your internet connection',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _connectionChangeStream.cancel();

    super.dispose();
  }
}

class _ConnectionStatusSingleton {
  static final _ConnectionStatusSingleton _singleton =
      _ConnectionStatusSingleton._internal();

  _ConnectionStatusSingleton._internal();

  static _ConnectionStatusSingleton getInstance() => _singleton;

  bool hasConnection = true;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize() {
    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  void dispose() {
    connectionChangeController.close();
  }

  void _connectionChange(ConnectivityResult result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (previousConnection != hasConnection) {
      connectionChangeController.add(hasConnection);
    }

    return hasConnection;
  }
}
