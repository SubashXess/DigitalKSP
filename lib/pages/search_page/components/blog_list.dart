import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/models/search_model.dart';
import 'package:digitalksp/pages/blog_post_page/blog_post_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';

class SearchBlogSection extends StatelessWidget {
  const SearchBlogSection({super.key, required this.items});

  final List<SearchBlogModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('BLOGS',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 20.0),
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = items[index];
            return SearchBlogItem(item: item);
          },
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(height: 0.0, color: Colors.grey.shade200),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class SearchBlogItem extends StatelessWidget {
  const SearchBlogItem({super.key, required this.item});

  final SearchBlogModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => BlogPostPage(blogId: item.id))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 80.0,
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius),
                  color: AppThemes.defaultTheme,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(item.coverPhoto),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) => Container(),
                  )),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(item.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor)),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                          DateFormat('d MMM, yyyy')
                              .format(DateTime.parse(item.publishedDate)),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.grey)),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w500)),
                  const SizedBox(height: 8.0),
                  GestureDetector(
                    // onTap: () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) =>
                    //             AuthorPage(authorId: item.authorModel.id))),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          CircleAvatar(
                              radius: 10.0,
                              backgroundImage: CachedNetworkImageProvider(
                                  item.authorDetails.profile)),
                          const SizedBox(width: 8.0),
                          Text(item.authorDetails.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.black87)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
