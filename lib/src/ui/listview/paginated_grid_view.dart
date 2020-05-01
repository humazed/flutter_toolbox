import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'common.dart';
import 'pagewise/flutter_pagewise.dart';

class PaginatedGridView<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;

  /// The number of children in the cross axis.
  final int crossAxisCount;

  final double childAspectRatio;

  final double crossAxisSpacing;

  final double mainAxisSpacing;

  final int pageSize;
  final EdgeInsetsGeometry padding;
  final NoItemsFoundBuilder noItemsFoundBuilder;
  final Widget noItemsFoundWidget;
  final PagewiseLoadController<T> pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool showRefreshIndicator;

  final Axis scrollDirection;

  const PaginatedGridView({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    @required this.crossAxisCount,
    this.childAspectRatio = 1.0,
    this.crossAxisSpacing = 0.0,
    this.mainAxisSpacing = 0.0,
    this.pageSize = 10,
    this.padding,
    this.noItemsFoundBuilder,
    this.noItemsFoundWidget,
    this.pageLoadController,
    this.mutable = false,
    this.showRefreshIndicator = false,
    this.scrollDirection = Axis.vertical,
  }) : super(key: key);

  @override
  _PaginatedGridViewState<T> createState() => _PaginatedGridViewState<T>();
}

class _PaginatedGridViewState<T> extends State<PaginatedGridView<T>> {
  bool _reload = false;

  @override
  Widget build(BuildContext context) {
    return widget.showRefreshIndicator
        ? RefreshIndicator(
            onRefresh: () async {
              await widget.pageFuture(1);
              setState(() => _reload = true);
            },
            child: buildGridView(),
          )
        : buildGridView();
  }

  Widget buildGridView() {
    final mutable = widget.mutable ||
//        widget.showRefreshIndicator || removed as there it serve no purpose leave here just in case there is a side effect
        _reload ||
        widget.pageLoadController != null;

    _reload = false;

    final PageFuture<T> pageFuture =
        (int pageIndex) => widget.pageFuture(pageIndex + 1);

    final pageLoadController = widget.pageLoadController ??
        PagewiseLoadController(
          pageSize: widget.pageSize,
          pageFuture: pageFuture,
        );

    return PagewiseGridView<T>.count(
      crossAxisCount: widget.crossAxisCount,
      childAspectRatio: widget.childAspectRatio,
      crossAxisSpacing: widget.crossAxisSpacing,
      mainAxisSpacing: widget.mainAxisSpacing,
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
    );
  }
}
