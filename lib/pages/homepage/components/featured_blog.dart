import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../models/blogs/blog_models.dart';
import '../../blog_post_page/blog_post_page.dart';
import 'headline.dart';
import 'view_all_blog_page.dart';

class FeaturedBlog extends StatelessWidget {
  const FeaturedBlog({super.key, required this.size, required this.items});

  final Size size;
  final List<BlogModels> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSection(
            headline: 'Featured blogs',
            showMore: true,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ViewAllBlogPage(type: 'Featured')))),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 240.0,
          child: GridView.builder(
              itemCount: items.length,
              shrinkWrap: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: size.width * 0.8,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      right: index == items.length - 1 ? 0.0 : 10.0),
                  child: FeaturedBlogItem(item: items[index]),
                );
              }),
        ),
      ],
    );
  }
}

class FeaturedBlogItem extends StatelessWidget {
  const FeaturedBlogItem({super.key, required this.item});

  final BlogModels item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => BlogPostPage(blogId: item.id),
        ),
      ),
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 92.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey.shade200,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.coverPhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
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
                      Text(
                          DateFormat('d MMM, yyyy')
                              .format(DateTime.parse(item.publishedDate)),
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
          ],
        ),
      ),
    );
  }
}
