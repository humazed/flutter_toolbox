import 'dart:io';

import 'package:chopper2/chopper2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toolbox/generated/i18n.dart';
import 'package:flutter_toolbox/src/model/error/error_response.dart';

import '../../flutter_toolbox.dart';

typedef WidgetBuilder<T> = Widget Function(BuildContext context, T snapshot);
typedef LoadingWidgetBuilder<T> = Widget Function(BuildContext context);

class LoadingBuilder<T> extends StatefulWidget {
  const LoadingBuilder({
    Key key,
    @required this.future,
    @required this.builder,
    this.initialData,
    this.mutable = false,
    this.loadingBuilder,
    this.loadingWidget,
  })  : assert(builder != null),
        super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  ///
  /// If no future has yet completed, including in the case where [future] is
  /// null, the data provided to the [builder] will be set to [initialData].
  final Future<Response<T>> future;

  final WidgetBuilder<T> builder;

  /// The data that will be used to create the snapshots provided until a
  /// non-null [future] has completed.
  ///
  /// If the future completes with an error, the data in the [AsyncSnapshot]
  /// provided to the [builder] will become null, regardless of [initialData].
  /// (The error itself will be available in [AsyncSnapshot.error], and
  /// [AsyncSnapshot.hasError] will be true.)
  final T initialData;

  /// default is false
  ///
  /// set to true if the future will change.
  ///
  /// when `mutable` is set to true then false the last data is returned.
  final bool mutable;

  /// set only if loadingWidget if null
  final LoadingWidgetBuilder loadingBuilder;

  /// set only if loadingBuilder if null
  final Widget loadingWidget;

  @override
  _LoadingBuilderState<T> createState() => _LoadingBuilderState<T>();
}

class _LoadingBuilderState<T> extends State<LoadingBuilder<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureLoadingBuilder<Response<T>>(
      future: widget.future,
      //        initialData: widget.initialData,
      mutable: widget.mutable,
      builder: (context, response) {
        return widget.builder(context, response.body);
      },
      loadingBuilder: widget.loadingBuilder,
      loadingWidget: widget.loadingWidget,
    );
  }
}

class FutureLoadingBuilder<T> extends StatefulWidget {
  const FutureLoadingBuilder({
    Key key,
    @required this.future,
    @required this.builder,
    this.loadingBuilder,
    this.loadingWidget,
    this.initialData,
    this.mutable = false,
  })  : assert(builder != null),
        assert((loadingBuilder == null && loadingWidget == null) ||
            (loadingBuilder != null && loadingWidget == null) ||
            loadingBuilder == null && loadingWidget != null),
        super(key: key);

  /// The asynchronous computation to which this builder is currently connected,
  /// possibly null.
  ///
  /// If no future has yet completed, including in the case where [future] is
  /// null, the data provided to the [builder] will be set to [initialData].
  final Future<T> future;

  final WidgetBuilder<T> builder;

  /// The data that will be used to create the snapshots provided until a
  /// non-null [future] has completed.
  ///
  /// If the future completes with an error, the data in the [AsyncSnapshot]
  /// provided to the [builder] will become null, regardless of [initialData].
  /// (The error itself will be available in [AsyncSnapshot.error], and
  /// [AsyncSnapshot.hasError] will be true.)
  final T initialData;

  /// default is true
  ///
  /// set to false if the future will change.
  ///
  /// when `mutable` is set to true then false the last data is returned.
  final bool mutable;

  /// set only if loadingWidget if null
  final LoadingWidgetBuilder loadingBuilder;

  /// set only if loadingBuilder if null
  final Widget loadingWidget;

  @override
  _FutureLoadingBuilderState<T> createState() =>
      _FutureLoadingBuilderState<T>();

  static bool atMostOneIsSet(List<Object> list) {
    int trueSum = list.where((item) => item != null).length;
    return trueSum <= 1;
  }
}

class _FutureLoadingBuilderState<T> extends State<FutureLoadingBuilder<T>> {
  Future<T> cashedFuture;

  @override
  void initState() {
    super.initState();
    cashedFuture = widget.future;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.mutable) cashedFuture = widget.future;

    return FutureBuilder<T>(
      future: cashedFuture,
      initialData: widget.initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.active:
          case ConnectionState.waiting:
            return buildLoading();

          case ConnectionState.done:
            if (snapshot.hasError) {
              var error = snapshot.error;
              if (error is Response<ErrorResponse>) {
                d2('error.body: ${error.body}');
                return Center(child: Text('Error: ${error.body.error[0]}'));
              } else if (error is SocketException) {
                d2('SocketException-> ${error.message}');
                return Center(
                  child: Text(
                    S.of(context)?.please_check_your_connection ??
                        'Please check your connection',
                    overflow: TextOverflow.fade,
                  ),
                );
              } else {
                d2('Unknown error: $error');
                return Center(
                    child: Text(S.of(context)?.server_error ?? 'Server error'));
              }
            }

            return widget.builder(context, snapshot.data);
        }
        return widget.builder(context, snapshot.data);
      },
    );
  }

  Widget buildLoading() {
    if (widget.loadingBuilder != null) return widget.loadingBuilder(context);
    if (widget.loadingWidget != null) return widget.loadingWidget;
    return Center(child: CircularProgressIndicator());
  }
}
