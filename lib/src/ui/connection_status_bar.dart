import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_toolbox/generated/l10n.dart';
import 'package:http/http.dart' as http;

class ConnectionStatusBar extends StatefulWidget {
  final Widget? title;
  final Color? color;
  final bool periodicCheck;
  final Duration periodicCheckInterval;

  const ConnectionStatusBar({
    this.title,
    this.color,
    required this.periodicCheck,
    required this.periodicCheckInterval,
    super.key,
  });

  @override
  State<ConnectionStatusBar> createState() => _ConnectionStatusBarState();

  static void init(
    BuildContext context, {
    bool periodicCheck = true,
    Duration periodicCheckInterval = const Duration(seconds: 10),
  }) async {
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
                  child: ConnectionStatusBar(
                    periodicCheck: periodicCheck,
                    periodicCheckInterval: periodicCheckInterval,
                  ),
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
  late StreamSubscription _connectionChangeStream;
  bool _hasConnection = true;
  late AnimationController controller;
  late Animation<Offset> offset;

  @override
  void initState() {
    _ConnectionStatusSingleton connectionStatus =
        _ConnectionStatusSingleton.getInstance();
    connectionStatus.initialize(
      enablePeriodicCheck: widget.periodicCheck,
      periodicCheckInterval: widget.periodicCheckInterval,
    );
    _connectionChangeStream =
        connectionStatus.connectionChange.listen(_connectionChanged);
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    offset = Tween<Offset>(
            begin: const Offset(0.0, -1.0), end: const Offset(0.0, 0.0))
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
      child: SafeArea(
        bottom: false,
        child: Container(
          color: widget.color ?? Colors.redAccent,
          width: double.maxFinite,
          height: 25,
          child: Center(
            child: widget.title ??
                Text(
                  S.of(context)?.please_check_your_internet_connection ??
                      'Please check your internet connection',
                  style: const TextStyle(color: Colors.white, fontSize: 14),
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

class _ConnectionStatusSingleton with WidgetsBindingObserver {
  static final _ConnectionStatusSingleton _singleton =
      _ConnectionStatusSingleton._internal();

  _ConnectionStatusSingleton._internal();

  static _ConnectionStatusSingleton getInstance() => _singleton;

  bool _hasConnection = true;
  bool _isAppInForeground = true;
  Timer? _periodicTimer;

  StreamController<bool> connectionChangeController =
      StreamController.broadcast();

  final Connectivity _connectivity = Connectivity();

  void initialize({
    required bool enablePeriodicCheck,
    required Duration periodicCheckInterval,
  }) {
    WidgetsBinding.instance.addObserver(this);

    _connectivity.onConnectivityChanged.listen(_connectionChange);
    checkConnection();

    if (enablePeriodicCheck) {
      _periodicTimer = Timer.periodic(
        periodicCheckInterval,
        (_) => checkConnection(),
      );
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        _isAppInForeground = true;
        // Immediately check connection when app resumes from background
        checkConnection();
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        _isAppInForeground = false;
        break;
      case AppLifecycleState.hidden:
        _isAppInForeground = false;
        break;
    }
  }

  Stream<bool> get connectionChange => connectionChangeController.stream;

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    connectionChangeController.close();
    _periodicTimer?.cancel();
  }

  void _connectionChange(List result) {
    checkConnection();
  }

  Future<bool> checkConnection() async {
    // Skip network checks when app is in background.
    if (!_isAppInForeground) {
      return _hasConnection;
    }

    bool previousConnection = _hasConnection;

    try {
      if (kIsWeb) {
        // For web platform, use real HTTP requests to CORS-enabled endpoints
        _hasConnection = await _performRealNetworkCheck();
      } else {
        // For mobile platforms, use InternetAddress lookup
        final result = await InternetAddress.lookup('google.com');
        _hasConnection = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      }
    } catch (e) {
      _hasConnection = false;
    }

    if (previousConnection != _hasConnection) {
      connectionChangeController.add(_hasConnection);
    }

    return _hasConnection;
  }

  /// Performs a real network connectivity check using CORS-enabled endpoints
  /// This provides actual internet connectivity verification, not just network interface status
  Future<bool> _performRealNetworkCheck() async {
    // First, check basic network connectivity - no point in HTTP requests without network
    try {
      final connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false; // No network interface available
      }
    } catch (e) {
      return false; // Connectivity check failed
    }

    // Now that we have network connectivity, test actual internet access
    final List<String> testEndpoints = [
      // Google DNS over HTTPS - supports CORS with "access-control-allow-origin: *"
      'https://dns.google/resolve?name=google.com&type=A',

      // JSONPlaceholder - popular CORS-enabled testing API
      'https://jsonplaceholder.typicode.com/posts/1',

      // httpbin.org - CORS-enabled HTTP testing service
      'https://httpbin.org/status/200',
    ];

    for (final endpoint in testEndpoints) {
      try {
        final response = await http.get(
          Uri.parse(endpoint),
          headers: {
            'Accept': 'application/json',
            'User-Agent': 'Flutter-Web-App',
          },
        ).timeout(const Duration(seconds: 8));

        // Check for successful response
        if (response.statusCode >= 200 && response.statusCode < 300) {
          return true;
        }
      } catch (e) {
        // Continue to next endpoint on error
        continue;
      }
    }

    // All HTTP requests failed - we have network but no internet access
    // (e.g., connected to WiFi but no internet, captive portal, etc.)
    return false;
  }
}
