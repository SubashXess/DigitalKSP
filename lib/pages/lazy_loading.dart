import 'package:digitalksp/providers/blog_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LazyLoading extends StatefulWidget {
  const LazyLoading({super.key});

  @override
  State<LazyLoading> createState() => _LazyLoadingState();
}

class _LazyLoadingState extends State<LazyLoading> {
  late final ScrollController _scrollController;
  int _page = 1;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onListen);
    WidgetsBinding.instance.addPostFrameCallback((_) => _fetchData());
  }

  void _fetchData() {
    if (_loading) return;
    setState(() => _loading = true);
    context
        .read<BlogProviders>()
        .getBlogs(type: 'Normal', limit: 12, page: _page);
    setState(() => _loading = false);
  }

  void _onListen() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // Trigger API only if more data is available

      _page++;
      context
          .read<BlogProviders>()
          .getBlogs(type: 'Normal', limit: 12, page: _page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<BlogProviders>(builder: (context, provider, child) {
          return provider.normalBlogModel.isEmpty && _loading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: provider.normalBlogModel.length,
                  shrinkWrap: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.all(24.0),
                  itemBuilder: (context, index) {
                    if (index == provider.normalBlogModel.length) {
                      // Show loader at the bottom
                      return const Center(child: CircularProgressIndicator());
                    }
                    return Container(
                        height: 140.0,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.grey.shade200,
                        ),
                        child: Text(
                            '${index + 1} - ${provider.normalBlogModel[index].title}'));
                  },
                );
        }),
      ),
    );
  }
}
