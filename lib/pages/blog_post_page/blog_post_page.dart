import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/components/author_card.dart';
import 'package:digitalksp/widgets/buttons_widget.dart';
import 'package:digitalksp/widgets/form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/ads_providers.dart';
import '../../providers/blog_providers.dart';
import '../../utilities/utilities.dart';
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

    return Consumer2<BlogProviders, AdsProviders>(
        builder: (context, provider, adsProvider, _) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                onPressed: () async {
                  await Utilities.shareContent(
                    imageUrl: provider.blogPostModel!.blog.coverPhoto,
                    text:
                        '${provider.blogPostModel!.blog.title}\n\nRead more at: https://digitalksp.com/blogs?id=${widget.blogId}',
                  );
                },
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        provider.blogPostModel!.blog.blogDescription,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    adsProvider.ads.isEmpty
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () => _showAdDialog(context),
                            child: Container(
                              width: size.width,
                              margin:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Stack(
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 16.0),
                                    child: Text(
                                      adsProvider.ads.first.textAd,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                              color: Colors.white),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0.0,
                                    top: 0.0,
                                    child: Container(
                                      color: Colors.grey.shade200,
                                      padding: const EdgeInsets.all(2.0),
                                      child: Text(
                                        'Ad',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 10.0,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    SizedBox(height: adsProvider.ads.isEmpty ? 0.0 : 20.0),
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
                    adsProvider.ads.isEmpty
                        ? const SizedBox()
                        : CachedNetworkImage(
                            imageUrl: adsProvider.ads.first.image2,
                            fit: BoxFit.fitWidth,
                          ),
                    SizedBox(height: adsProvider.ads.isEmpty ? 0.0 : 20.0),
                    LatestBlogList(items: provider.latestBlogModel),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
      );
    });
  }

  void _showAdDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController phoneController = TextEditingController();

    final FocusNode nameNode = FocusNode();
    final FocusNode emailNode = FocusNode();
    final FocusNode phoneNode = FocusNode();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "Fill your details to redirect to url",
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedFormField(
                    controller: nameController,
                    node: nameNode,
                    hintText: 'Your full name',
                    hintColor: Colors.black54,
                    maxLength: 60),
                const SizedBox(height: 10.0),
                RoundedFormField(
                    controller: emailController,
                    node: emailNode,
                    hintText: 'Email address',
                    hintColor: Colors.black54,
                    maxLength: 60),
                const SizedBox(height: 10.0),
                RoundedFormField(
                    controller: phoneController,
                    node: phoneNode,
                    hintText: 'Phone number',
                    hintColor: Colors.black54,
                    maxLength: 60),
              ],
            ),
          ),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            RoundedButton(
              label: 'Submit',
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(height: 20.0),
            SmallTextButton(
              label: 'Cancel',
              labelColor: Colors.black54,
              onTap: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }
}
