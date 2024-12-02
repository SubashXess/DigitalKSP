import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/homepage/components/view_all_blog_page.dart';
import 'package:flutter/material.dart';
import '../../../models/blogs/blog_models.dart';
import '../../blog_post_page/blog_post_page.dart';
import 'headline.dart';

class LatestBlogList extends StatelessWidget {
  const LatestBlogList({super.key, required this.items});

  final List<BlogModels> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadlineSection(
            headline: 'Latest blogs',
            showMore: true,
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const ViewAllBlogPage(type: 'Latest')))),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          height: 160.0,
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
                child: LatestBlogItem(item: items[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class LatestBlogItem extends StatelessWidget {
  const LatestBlogItem({super.key, required this.item});

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
        width: 140.0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: AppThemes.defaultTheme,
          image: DecorationImage(
            image: CachedNetworkImageProvider(item.coverPhoto),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(14.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.5],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
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
              Text(item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }
}
