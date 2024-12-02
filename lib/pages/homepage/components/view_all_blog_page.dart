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
  @override
  void initState() {
    super.initState();
    context.read<BlogProviders>().getBlogByType(type: widget.type, limit: '12');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} blogs'),
      ),
      body: Consumer<BlogProviders>(builder: (context, provider, _) {
        return provider.blogByTypeModel.isEmpty
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ListView.separated(
                itemCount: provider.blogByTypeModel.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16.0),
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  final blogs = provider.blogByTypeModel[index];
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
