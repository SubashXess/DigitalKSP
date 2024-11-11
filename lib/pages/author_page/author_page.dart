import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/models/author_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../providers/author_providers.dart';

class AuthorPage extends StatefulWidget {
  const AuthorPage({super.key, required this.authorModels});

  final AuthorModels authorModels;

  @override
  State<AuthorPage> createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/share-outlined.svg',
                    width: 20.0,
                    height: 20.0,
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40.0,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: CachedNetworkImageProvider(
                        widget.authorModels.photoUrl),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.authorModels.name,
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Blog writter',
                          maxLines: 3,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('About',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10.0),
                        ReadMoreText(
                          widget.authorModels.bio,
                          numLines: 2,
                          readMoreText: 'Read more',
                          readLessText: 'Read less',
                          readMoreTextStyle: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Theme.of(context).primaryColor),
                          readMoreIconColor: Theme.of(context).primaryColor,
                          readMoreAlign: Alignment.centerLeft,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blogs',
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 10.0),
                        Consumer<AuthorProviders>(
                            builder: (context, provider, _) {
                          final categories = provider.blogByAuthor
                              .map((map) => map.category)
                              .toSet()
                              .toList();
                          return SizedBox(
                            width: size.width,
                            height: 36.0,
                            child: ListView.builder(
                              itemCount: categories.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              clipBehavior: Clip.none,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                return GestureDetector(
                                  onTap: () {
                                    provider.selectCategory(category);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        right: index ==
                                                provider.blogByAuthor
                                                        .map((map) =>
                                                            map.category)
                                                        .toSet()
                                                        .toList()
                                                        .length -
                                                    1
                                            ? 0.0
                                            : 4.0),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.borderRadius * 10.0),
                                      border: Border.all(
                                          color: provider.selectedCategory ==
                                                  category
                                              ? Colors.white30
                                              : Colors.black12),
                                      color:
                                          provider.selectedCategory == category
                                              ? Theme.of(context).primaryColor
                                              : Colors.transparent,
                                    ),
                                    child: Text(
                                      category,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedCategory ==
                                                          category
                                                      ? Colors.white
                                                      : Colors.black54),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                        const SizedBox(height: 20.0),
                        Consumer<AuthorProviders>(
                            builder: (context, provider, _) {
                          final filteredBlogs = provider.getFilteredBlogs();
                          return ListView.separated(
                            itemCount: filteredBlogs.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final blogs = filteredBlogs[index];
                              return SizedBox(
                                width: size.width,
                                // margin: EdgeInsets.only(
                                //     bottom: index ==
                                //             provider.blogByAuthor.length - 1
                                //         ? 0.0
                                //         : 10.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(blogs.category,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor)),
                                          const SizedBox(height: 8.0),
                                          Text(blogs.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          const SizedBox(height: 4.0),
                                          Text(blogs.description,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.black54)),
                                          const SizedBox(height: 14.0),
                                          Row(
                                            children: [
                                              const Icon(
                                                  Icons.access_time_rounded,
                                                  size: 16.0,
                                                  color: Colors.grey),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                blogs.publishDate,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Container(
                                      width: 80.0,
                                      height: 80.0,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            AppDimensions.borderRadius),
                                        color: Colors.grey.shade200,
                                        image: DecorationImage(
                                            image: CachedNetworkImageProvider(
                                                blogs.image),
                                            fit: BoxFit.cover),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            separatorBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Divider(
                                  height: 0.0, color: Colors.grey.shade200),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
