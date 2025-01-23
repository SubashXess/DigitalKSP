import 'package:digitalksp/providers/blog_providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/blog_item.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key, required this.category});
  final String category;

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late final ScrollController _scrollController;
  // Pagination variables
  int currentPage = 1;
  final int perPage = 12; // Number of blogs per page
  bool _isFetchingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onListen);
    // Fetch the first page of blogs
    context.read<BlogProviders>().getBlogByIndCategory(
        category: widget.category, limit: '$perPage', page: '$currentPage');
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onListen);
    _scrollController.dispose();
    super.dispose();
  }

  void _onListen() {
    // Check if we reached the bottom of the list and are not already fetching
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isFetchingMore) {
      _fetchMoreBlogs();
    }
  }

  Future<void> _fetchMoreBlogs() async {
    if (_isFetchingMore) return; // Prevent multiple fetches

    setState(() {
      _isFetchingMore = true;
    });

    currentPage++; // Increment the page count
    await context.read<BlogProviders>().getBlogByIndCategory(
        category: widget.category, limit: '$perPage', page: '$currentPage');

    setState(() {
      _isFetchingMore = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Consumer<BlogProviders>(
        builder: (context, provider, _) {
          final blogs = provider.blogByIndCategory;

          if (blogs.isEmpty && !_isFetchingMore) {
            // Show a loader while the first page is being fetched
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          return ListView.builder(
            controller: _scrollController,
            itemCount: blogs.length + 1, // Add 1 for the loading indicator
            padding: const EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              if (index == blogs.length) {
                // Display loading indicator at the end while fetching more data
                return _isFetchingMore
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      )
                    : const SizedBox(); // Return an empty widget if no more data
              }

              final blog = blogs[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: BlogItem(item: blog),
              );
            },
          );
        },
      ),
    );
  }
}
