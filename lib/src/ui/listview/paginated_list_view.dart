import 'package:flutter/material.dart';

import 'common.dart';
import 'pagewise/flutter_pagewise.dart';

class PaginatedListView<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final EdgeInsetsGeometry? padding;
  final NoItemsFoundBuilder? noItemsFoundBuilder;
  final Widget? noItemsFoundWidget;
  final PagewiseLoadController<T>? pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool showRefreshIndicator;

  /// Called when loading each page.
  ///
  /// It is expected to return a widget to display while the page is loading.
  /// For example:
  /// ```dart
  /// (BuildContext context) {
  ///   return Text('Loading...');
  /// }
  /// ```
  ///
  /// If not specified, a [CircularProgressIndicator](https://docs.flutter.io/flutter/material/CircularProgressIndicator-class.html) will be shown
  final LoadingBuilder? loadingBuilder;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  final Color? refreshIndicatorBackgroundColor;
  final Color? refreshIndicatorColor;

  const PaginatedListView({
    super.key,
    required this.itemBuilder,
    required this.pageFuture,
    this.pageSize = 10,
    this.padding,
    this.noItemsFoundBuilder,
    this.noItemsFoundWidget,
    this.pageLoadController,
    this.mutable = false,
    this.showRefreshIndicator = false,
    this.loadingBuilder,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
    this.refreshIndicatorBackgroundColor,
    this.refreshIndicatorColor,
  });

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    return widget.showRefreshIndicator
        ? RefreshIndicator(
            backgroundColor: widget.refreshIndicatorBackgroundColor,
            color: widget.refreshIndicatorColor,
            onRefresh: () async {
              await widget.pageFuture(1);
              setState(() => _reload = true);
            },
            child: buildListView(),
          )
        : buildListView();
  }

  Widget buildListView() {
    final mutable = widget.mutable ||
//        widget.showRefreshIndicator || removed as there it serve no purpose leave here just in case there is a side effect
        _reload ||
        widget.pageLoadController != null;

    _reload = false;

    pageFuture(int? pageIndex) => widget.pageFuture(pageIndex! + 1);

    final pageLoadController = widget.pageLoadController ??
        PagewiseLoadController(
          pageSize: widget.pageSize,
          pageFuture: pageFuture,
        );

    return PagewiseListView<T>(
      itemBuilder: widget.itemBuilder,
      padding: widget.padding,
      noItemsFoundBuilder: noItemsFoundBuilder(
        context,
        noItemsFoundBuilder: widget.noItemsFoundBuilder,
        noItemsFoundWidget: widget.noItemsFoundWidget,
      ),
      pageLoadController: mutable ? pageLoadController : null,
      pageSize: mutable ? null : widget.pageSize,
      pageFuture: mutable ? null : pageFuture,
      scrollDirection: widget.scrollDirection,
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
      loadingBuilder: widget.loadingBuilder,
    );
  }
}
