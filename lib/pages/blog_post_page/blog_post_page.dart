import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/components/author_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/ads_providers.dart';
import '../../providers/blog_providers.dart';
import '../../utilities/utilities.dart';
import 'package:share_plus/share_plus.dart';
import '../homepage/components/latest_blog.dart';
import 'content_section.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({super.key, required this.blogId});

  final String blogId;

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  @override
  void initState() {
    super.initState();

    context.read<BlogProviders>().getBlogContent(widget.blogId);
    context
        .read<BlogProviders>()
        .getBlogByType(type: 'Latest', limit: 10, page: 1);
    context.read<AdsProviders>().getAds(id: int.tryParse(widget.blogId));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Consumer<BlogProviders>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                onPressed: () async {
                  // Get the image URL
                  final imageUrl = provider.blogPostModel!.blog.coverPhoto;

                  // Download the image and compress it
                  final imageFile =
                      await Utilities.downloadAndCompressImage(imageUrl);

                  // Check if the image file exists
                  if (await imageFile.exists()) {
                    // Share the image along with text (title, description, URL)
                    await Share.shareXFiles(
                      [XFile(imageFile.path)], // List of files to share

                      text:
                          '${provider.blogPostModel!.blog.title}\n\nRead more at: https://digitalksp.com/blogs?id=${widget.blogId}', // Text content to share
                    );
                    log('Shared successfully: ${provider.blogPostModel!.blog.coverTitle}');
                  } else {
                    log('Error: Image file not accessible');
                  }
                },
                // onPressed: () => Utilities.shareIt(context,
                //     url: 'https://digitalksp.com/blogs?id=${widget.blogId}',
                //     subject: provider.blogPostModel!.blog.coverTitle,
                //     text: provider.blogPostModel?.blog.title),
                icon: SvgPicture.asset(
                  'assets/icons/share-outlined.svg',
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: const CircularFabMenu(),
        body: provider.blogPostModel == null
            ? const Center(child: CircularProgressIndicator.adaptive())
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            provider.blogPostModel!.blog.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 20.0),
                          AuthorCard(
                            author: provider.blogPostModel!.blog.authorModel,
                            publishedDate:
                                provider.blogPostModel!.blog.publishedDate,
                          ),
                          const SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height * 0.32,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            provider.blogPostModel!.blog.coverPhoto,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    ListView.builder(
                      itemCount: provider.blogPostModel!.content.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(16.0),
                      clipBehavior: Clip.none,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final content = provider.blogPostModel!.content[index];
                        return Builder(builder: (context) {
                          return ContentSection(content: content, size: size);
                        });
                      },
                    ),
                    const SizedBox(height: 20.0),
                    LatestBlogList(items: provider.latestBlogModel),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
      );
    });
  }
}
