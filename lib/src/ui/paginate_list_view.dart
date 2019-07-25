import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';

class PaginateListView<T> extends StatelessWidget {
  final ItemBuilder<T> itemBuilder;
  final PageFuture<T> pageFuture;
  final int pageSize;
  final EdgeInsetsGeometry padding;

  const PaginateListView({
    Key key,
    @required this.itemBuilder,
    @required this.pageFuture,
    this.pageSize = 10,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagewiseListView(
      pageSize: pageSize,
      itemBuilder: itemBuilder,
      pageFuture: (int pageIndex) => pageFuture(pageIndex + 1),
      padding: padding,
    );
  }
}
