import 'package:flutter/material.dart';

import 'common.dart';
import 'pagewise/flutter_pagewise.dart';

class PaginatedSliverList<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final NoItemsFoundBuilder noItemsFoundBuilder;
  final Widget noItemsFoundWidget;
  final PagewiseLoadController<T> pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  const PaginatedSliverList({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    this.pageSize = 10,
    this.noItemsFoundBuilder,
    this.noItemsFoundWidget,
    this.pageLoadController,
    this.mutable = false,
  }) : super(key: key);

  @override
  _PaginatedSliverListState<T> createState() => _PaginatedSliverListState<T>();
}

class _PaginatedSliverListState<T> extends State<PaginatedSliverList<T>> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    return buildListView();
  }

  Widget buildListView() {
    final mutable =
        widget.mutable || _reload || widget.pageLoadController != null;

    final PageFuture<T> pageFuture =
        (int pageIndex) => widget.pageFuture(pageIndex + 1);

    final pageLoadController = widget.pageLoadController ??
        PagewiseLoadController(
          pageSize: widget.pageSize,
          pageFuture: pageFuture,
        );

    return PagewiseSliverList<T>(
      itemBuilder: widget.itemBuilder,
      noItemsFoundBuilder: noItemsFoundBuilder(
          widget.noItemsFoundBuilder, widget.noItemsFoundWidget),
      pageLoadController: mutable ? pageLoadController : null,
      pageSize: mutable ? null : widget.pageSize,
      pageFuture: mutable ? null : pageFuture,
    );
  }
}
