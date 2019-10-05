import 'package:flutter/material.dart';

import 'pagewise/flutter_pagewise.dart';

class PaginatedListView<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final EdgeInsetsGeometry padding;
  final PagewiseLoadController<T> pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool showRefreshIndicator;

  const PaginatedListView({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    this.pageSize = 10,
    this.padding,
    this.pageLoadController,
    this.mutable = false,
    this.showRefreshIndicator = false,
  }) : super(key: key);

  @override
  _PaginatedListViewState<T> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    return widget.showRefreshIndicator
        ? RefreshIndicator(
            onRefresh: () async {
              await widget.pageFuture(1);
              setState(() => _reload = true);
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _reload = false);
            },
            child: buildListView(),
          )
        : buildListView();
  }

  Widget buildListView() {
    return widget.mutable ||
            widget.showRefreshIndicator ||
            _reload ||
            widget.pageLoadController != null
        ? PagewiseListView<T>(
            itemBuilder: widget.itemBuilder,
            padding: widget.padding,
            pageLoadController: widget.pageLoadController ??
                PagewiseLoadController(
                  pageSize: widget.pageSize,
                  pageFuture: (int pageIndex) =>
                      widget.pageFuture(pageIndex + 1),
                ),
          )
        : PagewiseListView<T>(
            pageSize: widget.pageSize,
            itemBuilder: widget.itemBuilder,
            pageFuture: (int pageIndex) => widget.pageFuture(pageIndex + 1),
            padding: widget.padding,
          );
  }
}
