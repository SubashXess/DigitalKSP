import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';
import '../../../models/blogs/blog_models.dart';
import '../../blog_post_page/blog_post_page.dart';

class BlogItem extends StatelessWidget {
  const BlogItem({super.key, required this.item});

  final BlogModels item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlogPostPage(blogId: item.id),
          ),
        );
      },
      child: Container(
        color: Colors.transparent,
        width: double.infinity,
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
                          size: 16.0, color: Colors.black54),
                      const SizedBox(width: 4.0),
                      Text(
                        DateFormat('d MMM, yyyy')
                            .format(DateTime.parse(item.publishDate)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black54),
                      ),
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
                  const SizedBox(height: 14.0),
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        CircleAvatar(
                            radius: 10.0,
                            backgroundImage: CachedNetworkImageProvider(
                                item.authorModel.photoUrl)),
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
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Container(
              width: 92.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                color: Colors.grey.shade200,
                image: DecorationImage(
                    image: CachedNetworkImageProvider(item.coverPhoto),
                    fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
