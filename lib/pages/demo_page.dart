import 'dart:convert';

import 'package:digitalksp/models/blogs/blog_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  late final ScrollController _scrollController;

  List<BlogModels> items = [];
  int page = 1;
  bool hasMore = true;
  bool loading = false;
  String type = 'Normal';

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onListen);
    getBlog();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onListen() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.offset) {
      getBlog();
    }
  }

  Future<void> getBlog() async {
    if (loading) return;
    loading = true;
    int limit = 10;

    final Uri url = Uri.parse(
        '${ApiRequest.instance.apiGetBlogs}?type=$type&limit=$limit&page=$page');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Normal, Front Banner, Recent, Latest, Most Popular, Featured
        final newBlogs = BlogModels.blogsFromJson(jsonData);
        setState(() {
          page++;
          loading = false;
          if (newBlogs.length < limit) {
            hasMore = false;
          }
          items.addAll(newBlogs);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occurred: $err');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo Page'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + 1,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index < items.length) {
            final item = items[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              leading: Text('$index'),
              title: Text(item.title),
              subtitle: Text(
                item.blogDescription,
                maxLines: 2,
              ),
            );
          } else {
            return Center(
                child: hasMore
                    ? const CircularProgressIndicator()
                    : const Text('No more data'));
          }
        },
      ),
    );
  }
}
