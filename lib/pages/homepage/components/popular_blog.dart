import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import '../../../models/blogs/blog_models.dart';
import '../../blog_post_page/blog_post_page.dart';
import 'headline.dart';
import 'view_all_blog_page.dart';

class PopularBlogList extends StatelessWidget {
  const PopularBlogList({super.key, required this.items});

  final List<BlogModels> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSection(
          headline: 'Popular blogs',
          showMore: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => const ViewAllBlogPage(type: 'Most Popular')),
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 168.0,
          child: ListView.builder(
            itemCount: items.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index == items.length - 1 ? 0.0 : 10.0),
                child: PopularBlogItem(item: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class PopularBlogItem extends StatelessWidget {
  const PopularBlogItem({super.key, required this.item});

  final BlogModels item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => BlogPostPage(blogId: item.id))),
      child: Container(
        width: 140.0,
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100.0,
              width: double.infinity,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
                color: AppThemes.defaultTheme,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.coverPhoto),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => Container(),
                ),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadius)),
                child: Text(item.category,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontWeight: FontWeight.w500)),
              ),
            ),
            const SizedBox(height: 10.0),
            Text(item.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500, fontSize: 13.0)),
            const SizedBox(height: 4.0),
            Text(item.authorModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 12.0, color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}
