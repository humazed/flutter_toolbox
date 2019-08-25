import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class PaginateSliverList<T> extends StatelessWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final PagewiseLoadController<T> pageLoadController;

  /// default is false
  ///
  /// set to true if the future will change.
  final bool mutable;

  const PaginateSliverList({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    this.pageSize = 10,
    this.mutable = false,
    this.pageLoadController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mutable || pageLoadController != null
        ? PagewiseSliverList(
            itemBuilder: itemBuilder,
            pageLoadController: pageLoadController ??
                PagewiseLoadController(
                  pageSize: pageSize,
                  pageFuture: (int pageIndex) => pageFuture(pageIndex + 1),
                ),
          )
        : PagewiseSliverList(
            pageSize: pageSize,
            itemBuilder: itemBuilder,
            pageFuture: (int pageIndex) => pageFuture(pageIndex + 1),
          );
  }
}
