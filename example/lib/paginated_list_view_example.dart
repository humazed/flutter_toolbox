import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_toolbox/flutter_toolbox.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Pagewise Demo',
      home: PaginatedListViewPage(),
    );
  }
}

class PaginatedListViewPage extends StatelessWidget {
  const PaginatedListViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Pagewise'),
            bottom: const TabBar(tabs: [
              Tab(text: 'List'),
              Tab(text: 'Empty List'),
              Tab(text: 'SliverList'),
            ]),
          ),
          body: const TabBarView(
            children: [
              PaginatedListViewExample(),
              PaginatedListViewEmptyExample(),
              PagewiseSliverListExample(),
            ],
          )),
    );
  }
}

class PaginatedListViewExample extends StatefulWidget {
  static const int PAGE_SIZE = 10;

  const PaginatedListViewExample({super.key});

  @override
  _PaginatedListViewExampleState createState() =>
      _PaginatedListViewExampleState();
}

class _PaginatedListViewExampleState extends State<PaginatedListViewExample> {
  @override
  void initState() {
    super.initState();
    d('_PaginatedListViewExampleState.initState');
  }

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      pageSize: PaginatedListViewExample.PAGE_SIZE,
//      mutable: true,
      showRefreshIndicator: true,
      noItemsFoundWidget: const Icon(Icons.hourglass_empty),
      itemBuilder: _itemBuilder,
      loadingBuilder: (_) => const Icon(Icons.hourglass_full),
      pageFuture: (int pageIndex) {
        return BackendService.getPosts(
            pageIndex * PaginatedListViewExample.PAGE_SIZE,
            PaginatedListViewExample.PAGE_SIZE);
      },
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
          title: Text(entry.title!),
          subtitle: Text(entry.body!),
        ),
        const Divider()
      ],
    );
  }
}

class PaginatedListViewEmptyExample extends StatelessWidget {
  static const int PAGE_SIZE = 0;

  const PaginatedListViewEmptyExample({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginatedListView(
      pageSize: PAGE_SIZE,
//      mutable: true,
      showRefreshIndicator: true,
//      noItemsFoundWidget: Icon(Icons.hourglass_empty),
      itemBuilder: _itemBuilder,
      pageFuture: ((pageIndex) =>
          BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE)),
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
          title: Text(entry.title!),
          subtitle: Text(entry.body!),
        ),
        const Divider()
      ],
    );
  }
}

class PagewiseSliverListExample extends StatelessWidget {
  static const int PAGE_SIZE = 6;

  const PagewiseSliverListExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const SliverAppBar(
        title: Text('This is a sliver app bar'),
        snap: true,
        floating: true,
      ),
      PaginatedSliverList(
        pageSize: PAGE_SIZE,
        itemBuilder: _itemBuilder,
        noItemsFoundWidget: const Icon(Icons.hourglass_empty),
        pageFuture: ((pageIndex) =>
            BackendService.getPosts(pageIndex * PAGE_SIZE, PAGE_SIZE)),
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
          title: Text(entry.title!),
          subtitle: Text(entry.body!),
        ),
        const Divider()
      ],
    );
  }
}

class BackendService {
  static Future<List<PostModel>> getPosts(offset, limit) async {
    final responseBody = (await http.get(Uri.parse(
            'https://jsonplaceholder.typicode.com/posts?_start=$offset&_limit=$limit')))
        .body;

    // The response body is an array of items
    return PostModel.fromJsonList(json.decode(responseBody)) ?? [];
  }

  static Future<List<ImageModel>> getImages(offset, limit) async {
    final responseBody = (await http.get(Uri.parse(
            'https://jsonplaceholder.typicode.com/photos?_start=$offset&_limit=$limit')))
        .body;

    // The response body is an array of items.
    return ImageModel.fromJsonList(json.decode(responseBody)) ?? [];
  }
}

class PostModel {
  String? title;
  String? body;

  PostModel.fromJson(obj) {
    title = obj['title'];
    body = obj['body'];
  }

  static List<PostModel>? fromJsonList(jsonList) {
    return jsonList.map<PostModel>((obj) => PostModel.fromJson(obj)).toList();
  }
}

class ImageModel {
  String? title;
  String? id;
  String? thumbnailUrl;

  ImageModel.fromJson(obj) {
    title = obj['title'];
    id = obj['id'].toString();
    thumbnailUrl = obj['thumbnailUrl'];
  }

  static List<ImageModel>? fromJsonList(jsonList) {
    return jsonList.map<ImageModel>((obj) => ImageModel.fromJson(obj)).toList();
  }
}
