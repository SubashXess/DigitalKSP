import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/author_page/author_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/blogs/blog_models.dart';
import '../../blog_post_page/blog_post_page.dart';
import 'headline.dart';

class BlogList extends StatelessWidget {
  const BlogList({super.key, required this.items});

  final List<BlogModels> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const HeadlineSection(headline: 'Our blogs', showMore: false),
        const SizedBox(height: 10.0),
        ListView.separated(
          itemCount: items.length,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0.0 : 10.0),
              child: BlogItem(item: items[index]),
            );
          },
          separatorBuilder: (_, __) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(height: 0.0, color: Colors.grey.shade200),
          ),
        ),
      ],
    );
  }
}

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.item});

  final BlogModels item;

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
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                color: AppThemes.defaultTheme,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.coverPhoto,
                      maxHeight: 100, maxWidth: 80),

                  fit: BoxFit.cover,

                  // image: CachedNetworkImageProvider(item.coverPhoto),
                  // fit: BoxFit.cover,
                  // onError: (exception, stackTrace) => Container(),
                ),
              ),
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
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                AuthorPage(authorId: item.authorModel.id))),
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 10.0,
                            backgroundImage:
                                NetworkImage(item.authorModel.photoUrl),
                          ),
                          const SizedBox(width: 8.0),
                          Text(item.authorModel.name,
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
