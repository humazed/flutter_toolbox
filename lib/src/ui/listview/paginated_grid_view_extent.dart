import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'common.dart';
import 'pagewise/flutter_pagewise.dart';

class PaginatedGridViewExtent<T> extends StatefulWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;

  /// The number of children in the cross axis.
  final double maxCrossAxisExtent;

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
  final bool shrinkWrap;
  final ScrollPhysics physics;

  const PaginatedGridViewExtent({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    @required this.maxCrossAxisExtent,
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
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  @override
  _PaginatedGridViewExtentState<T> createState() =>
      _PaginatedGridViewExtentState<T>();
}

class _PaginatedGridViewExtentState<T>
    extends State<PaginatedGridViewExtent<T>> {
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

    return PagewiseGridView<T>.extent(
      maxCrossAxisExtent: widget.maxCrossAxisExtent,
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
      shrinkWrap: widget.shrinkWrap,
      physics: widget.physics,
    );
  }
}
