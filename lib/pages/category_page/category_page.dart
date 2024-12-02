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
  @override
  void initState() {
    super.initState();
    context
        .read<BlogProviders>()
        .getBlogByIndCategory(category: widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: Consumer<BlogProviders>(builder: (context, provider, _) {
        return provider.blogByIndCategory.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.separated(
                itemCount: provider.blogByIndCategory.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  final blogs = provider.blogByIndCategory[index];
                  return BlogItem(item: blogs);
                },
                separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Divider(height: 0.0, color: Colors.grey.shade200),
                ),
              );
      }),
    );
  }
}
