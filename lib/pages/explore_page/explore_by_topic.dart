import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/blog_providers.dart';
import '../blog_post_page/blog_post_page.dart';

class ExploreByTopic extends StatefulWidget {
  const ExploreByTopic({super.key});

  @override
  State<ExploreByTopic> createState() => _ExploreByTopicState();
}

class _ExploreByTopicState extends State<ExploreByTopic> {
  @override
  void initState() {
    super.initState();
    context.read<BlogProviders>().getBlogByCategory(limit: '8');
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<BlogProviders>(builder: (_, provider, __) {
      return provider.blogCategoryModel.isEmpty
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: size.width,
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Blogs by Category',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        provider.blogCategoryModel.length,
                        (categoryIndex) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: BlogCategory(
                              size: size,
                              category: provider
                                  .blogCategoryModel[categoryIndex]['category'],
                              items: List.generate(
                                  provider
                                      .blogCategoryModel[categoryIndex]['blogs']
                                      .length, (index) {
                                final item =
                                    provider.blogCategoryModel[categoryIndex]
                                        ['blogs'][index];

                                return Padding(
                                  padding: EdgeInsets.only(
                                      right: index ==
                                              provider
                                                      .blogCategoryModel[
                                                          categoryIndex]
                                                          ['blogs']
                                                      .length -
                                                  1
                                          ? 0.0
                                          : 10.0),
                                  child: BlogItem(
                                    image: item.coverPhoto,
                                    title: item.title,
                                    type: 'type',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              BlogPostPage(blogId: item.id),
                                        ),
                                      );
                                    },
                                  ),
                                );
                              }),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}

class BlogCategory extends StatelessWidget {
  const BlogCategory(
      {super.key,
      required this.size,
      required this.category,
      required this.items});

  final Size size;
  final String category;
  final List<Widget> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(category,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700, fontSize: 18.0)),
          ),
          const SizedBox(height: 10.0),
          SizedBox(
            height: 174.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: items,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BlogItem extends StatelessWidget {
  const BlogItem(
      {super.key,
      required this.image,
      required this.title,
      required this.type,
      required this.onTap});

  final String image;
  final String title;
  final String type;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140.0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 140.0,
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => Container(),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(type,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).primaryColor)),
            const SizedBox(height: 4.0),
            Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.0)),
          ],
        ),
      ),
    );
  }
}
