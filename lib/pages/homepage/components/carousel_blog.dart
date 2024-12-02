import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalksp/components/author_card.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/blog_post_page/blog_post_page.dart';
import 'package:flutter/material.dart';
import '../../../models/blogs/blog_models.dart';

class CarouselBlog extends StatelessWidget {
  const CarouselBlog({super.key, required this.items});

  final List<BlogModels> items;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: items.length,
      itemBuilder: (context, index, realIndex) {
        final item = items[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CarouselBlogItem(
            item: item,
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 8),
        autoPlayAnimationDuration: const Duration(milliseconds: 350),
        clipBehavior: Clip.none,
        viewportFraction: 1.0,
        aspectRatio: 1.6,
      ),
    );
  }
}

class CarouselBlogItem extends StatelessWidget {
  const CarouselBlogItem({super.key, required this.item});

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
        width: double.infinity,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: AppThemes.defaultTheme,
          boxShadow: [AppStyles.boxShadow()],
          image: DecorationImage(
            image: CachedNetworkImageProvider(item.coverPhoto),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0.0, 0.64],
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
                      horizontal: 10.0, vertical: 6.0),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white)),
                  const SizedBox(height: 14.0),
                  AuthorCard(
                    author: item.authorModel,
                    publishedDate: item.publishedDate,
                    size: 36.0,
                    textColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
