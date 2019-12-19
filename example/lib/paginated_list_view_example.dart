import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagewise Demo',
      home: PaginatedListViewPage(),
    );
  }
}

class PaginatedListViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Pagewise'),
            bottom: TabBar(tabs: [
              Tab(text: 'List'),
              Tab(text: 'Empty List'),
              Tab(text: 'SliverList'),
            ]),
          ),
          body: TabBarView(
            children: [
              PaginatedListViewExample(),
              PaginatedListViewEmptyExample(),
              PagewiseSliverListExample(),
            ],
          )),
    );
  }
}

class PaginatedListViewExample extends StatelessWidget {
  static const int PAGE_SIZE = 10;

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      pageSize: PAGE_SIZE,
//      mutable: true,
      showRefreshIndicator: true,
      noItemsFoundWidget: Icon(Icons.hourglass_empty),
      itemBuilder: this._itemBuilder,
      pageFuture: (pageIndex) =>
          BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE),
    );
  }

  Widget _itemBuilder(BuildContext context, PostModel entry, int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.brown[200],
          ),
          title: Text(entry.title),
          subtitle: Text(entry.body),
        ),
        Divider()
      ],
    );
  }
}
class PaginatedListViewEmptyExample extends StatelessWidget {
  static const int PAGE_SIZE = 0;

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      pageSize: PAGE_SIZE,
//      mutable: true,
      showRefreshIndicator: true,
//      noItemsFoundWidget: Icon(Icons.hourglass_empty),
      itemBuilder: this._itemBuilder,
      pageFuture: (pageIndex) =>
          BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE),
    );
  }

  Widget _itemBuilder(BuildContext context, PostModel entry, int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.brown[200],
          ),
          title: Text(entry.title),
          subtitle: Text(entry.body),
        ),
        Divider()
      ],
    );
  }
}

class PagewiseSliverListExample extends StatelessWidget {
  static const int PAGE_SIZE = 6;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        title: Text('This is a sliver app bar'),
        snap: true,
        floating: true,
      ),
      PaginatedSliverList(
        pageSize: PAGE_SIZE,
        itemBuilder: _itemBuilder,
        noItemsFoundWidget: Icon(Icons.hourglass_empty),
        pageFuture: (pageIndex) =>
            BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE),
      ),
    ]);
  }

  Widget _itemBuilder(BuildContext context, PostModel entry, int index) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(
            Icons.person,
            color: Colors.brown[200],
          ),
          title: Text(entry.title),
          subtitle: Text(entry.body),
        ),
        Divider()
      ],
    );
  }
}

class BackendService {
  static Future<List<PostModel>> getPosts(offset, limit) async {
    final responseBody = (await http.get(
            'http://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit'))
        .body;

    // The response body is an array of items
    return PostModel.fromJsonList(json.decode(responseBody));
  }

  static Future<List<ImageModel>> getImages(offset, limit) async {
    final responseBody = (await http.get(
            'http://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit'))
        .body;

    // The response body is an array of items.
    return ImageModel.fromJsonList(json.decode(responseBody));
  }
}

class PostModel {
  String title;
  String body;

  PostModel.fromJson(obj) {
    this.title = obj['title'];
    this.body = obj['body'];
  }

  static List<PostModel> fromJsonList(jsonList) {
    return jsonList.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
  }
}

class ImageModel {
  String title;
  String id;
  String thumbnailUrl;

  ImageModel.fromJson(obj) {
    this.title = obj['title'];
    this.id = obj['id'].toString();
    this.thumbnailUrl = obj['thumbnailUrl'];
  }

  static List<ImageModel> fromJsonList(jsonList) {
    return jsonList.map<ImageModel>((obj) => ImageModel.fromJson(obj)).toList();
  }
}
