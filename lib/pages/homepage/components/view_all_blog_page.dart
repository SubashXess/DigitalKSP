import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/blog_providers.dart';
import '../../category_page/components/blog_item.dart';

class ViewAllBlogPage extends StatefulWidget {
  const ViewAllBlogPage({super.key, required this.type});
  final String type;

  @override
  State<ViewAllBlogPage> createState() => _ViewAllBlogPageState();
}

class _ViewAllBlogPageState extends State<ViewAllBlogPage> {
  late final ScrollController _scrollController;
  int currentPage = 1;
  final int perPage = 12;
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
    _fetchInitialBlogs();
  }

  Future<void> _fetchInitialBlogs() async {
    await context.read<BlogProviders>().getBlogByType(
        type: widget.type, limit: '$perPage', page: '$currentPage');
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      _fetchMoreBlogs();
    }
  }

  Future<void> _fetchMoreBlogs() async {
    if (_isFetchingMore) return;

    setState(() {
      _isFetchingMore = true;
    });

    currentPage++;

    await context.read<BlogProviders>().getBlogByType(
        type: widget.type, limit: '$perPage', page: '$currentPage');

    setState(() {
      _isFetchingMore = false;
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} blogs'),
      ),
      body: Consumer<BlogProviders>(
        builder: (context, provider, _) {
          final blogs = provider.blogByTypeModel;

          if (blogs.isEmpty && !_isFetchingMore) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.separated(
            controller: _scrollController,
            itemCount: blogs.length + 1,
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              if (index == blogs.length) {
                return _isFetchingMore
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : const SizedBox.shrink();
              } else {
                final blog = blogs[index];
                return BlogItem(item: blog);
              }
            },
            separatorBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(height: 0.0, color: Colors.grey.shade200),
            ),
          );
        },
      ),
    );
  }
}
