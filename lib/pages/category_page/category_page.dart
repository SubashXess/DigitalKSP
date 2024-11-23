import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../constants/styles.dart';
import '../blog_post_page/blog_post_page.dart';

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
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
      body: SingleChildScrollView(
        child: Consumer<BlogProviders>(builder: (context, provider, _) {
          return provider.blogByIndCategory.isEmpty
              ? const Center(child: CircularProgressIndicator.adaptive())
              : ListView.separated(
                  itemCount: provider.blogByIndCategory.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final blogs = provider.blogByIndCategory[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => BlogPostPage(
                              blogId: blogs.id,
                              headerSection: blogs,
                              authorId: blogs.author,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: size.width,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.access_time_rounded,
                                          size: 16.0, color: Colors.grey),
                                      const SizedBox(width: 4.0),
                                      Text(
                                        DateFormat('d MMM, yyyy').format(
                                            DateTime.parse(blogs.publishDate)),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(blogs.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4.0),
                                  Text(blogs.blogDescription,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.black54)),
                                  const SizedBox(height: 14.0),
                                  Text(blogs.authorModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: Colors.black45)),
                                ],
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Container(
                              width: 92.0,
                              height: 120.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                color: Colors.grey.shade200,
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        blogs.coverPhoto),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(height: 0.0, color: Colors.grey.shade200),
                  ),
                );
        }),
      ),
    );
  }
}
