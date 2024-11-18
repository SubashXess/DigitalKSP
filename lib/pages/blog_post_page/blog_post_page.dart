import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/models/blog_post_model.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/blogs/blog_models.dart';
import '../../providers/author_providers.dart';
import 'content_section.dart';

class BlogPostPage extends StatefulWidget {
  const BlogPostPage({
    super.key,
    required this.blogId,
    required this.authorId,
    required this.headerSection,
  });

  final String blogId;
  final String authorId;
  final BlogModels headerSection;

  @override
  State<BlogPostPage> createState() => _BlogPostPageState();
}

class _BlogPostPageState extends State<BlogPostPage> {
  late final List<SocialMediaModel> _socialMedia;

  @override
  void initState() {
    super.initState();
    context.read<AuthorProviders>().getAuthorById(widget.authorId);
    context.read<BlogProviders>().getBlogContent(widget.blogId);
    context.read<BlogProviders>().getBlogs(type: 'Latest', limit: 12);
    _socialMedia = SocialMediaModel.generatedItem;
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
                onPressed: () => Utilities.shareIt(
                    url: 'https://www.digitalksp.com/blog_details.php?id=158',
                    text: 'Sharing files, text, and images between apps'),
                icon: SvgPicture.asset(
                  'assets/icons/share-outlined.svg',
                  width: 20.0,
                  height: 20.0,
                ),
              ),
            ),
          ],
        ),
        body: provider.blogContent.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 16.0),
                      Consumer<AuthorProviders>(builder: (context, author, _) {
                        return author.authorById.isEmpty
                            ? const SizedBox()
                            : Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                color: Colors.transparent,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 20.0,
                                      backgroundColor: Colors.grey,
                                      backgroundImage: NetworkImage(
                                          author.authorById.first.photoUrl),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                author.authorById.first.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Tooltip(
                                                message: 'Digital KSP Verified',
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                margin: EdgeInsets.zero,
                                                child: Icon(
                                                    Icons.check_circle_rounded,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    size: 14.0),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 2.0),
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Published on ${DateFormat('d MMM, yyyy').format(DateTime.parse(widget.headerSection.publishDate))}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }),
                      const SizedBox(height: 20.0),
                      Container(
                        width: size.width,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.headerSection.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 20.0),
                            const Divider(height: 0.0),
                            const SizedBox(height: 20.0),
                            Row(
                              children: [
                                Text('244',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                                const SizedBox(width: 4.0),
                                Icon(
                                  Icons.visibility,
                                  size: 18.0,
                                  color: Colors.amber.shade600,
                                ),
                              ],
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              width: size.width,
                              height: 200.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadius),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.headerSection.coverPhoto),
                                      fit: BoxFit.cover)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      ListView.builder(
                        itemCount: provider.blogContent.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(16.0),
                        clipBehavior: Clip.none,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final content = provider.blogContent[index];
                          return Builder(builder: (context) {
                            return ContentSection(content: content, size: size);
                          });
                        },
                      ),
                      const SizedBox(height: 24.0),
                      Consumer<AuthorProviders>(builder: (_, provider, __) {
                        return provider.authorById.isEmpty
                            ? const SizedBox()
                            : Container(
                                width: size.width,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 80.0,
                                          height: 110.0,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppDimensions
                                                          .borderRadius),
                                              color: Colors.grey.shade200,
                                              image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          provider.authorById
                                                              .first.photoUrl),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    provider
                                                        .authorById.first.name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyLarge
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                  const SizedBox(width: 8.0),
                                                  Tooltip(
                                                    message:
                                                        'Digital KSP Verified',
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8.0),
                                                    margin: EdgeInsets.zero,
                                                    child: Icon(
                                                        Icons
                                                            .check_circle_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        size: 14.0),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 4.0),
                                              Text(
                                                provider.authorById.first.bio,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey),
                                              ),
                                              const SizedBox(height: 14.0),
                                              SizedBox(
                                                width: size.width,
                                                child: Wrap(
                                                  runSpacing: 8.0,
                                                  spacing: 8.0,
                                                  alignment:
                                                      WrapAlignment.start,
                                                  children: List.generate(
                                                    _socialMedia.length,
                                                    (index) => CircleAvatar(
                                                      radius: 16.0,
                                                      backgroundColor:
                                                          Colors.grey.shade200,
                                                      child: SvgPicture.asset(
                                                        _socialMedia[index]
                                                            .icon,
                                                        width: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                      }),
                      const SizedBox(height: 24.0),
                      Consumer<BlogProviders>(builder: (_, provider1, __) {
                        return provider1.latestBlogModel.isEmpty
                            ? const SizedBox()
                            : SizedBox(
                                width: size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Text('Our Latest Posts',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w700)),
                                    ),
                                    const SizedBox(height: 10.0),
                                    SizedBox(
                                      height: 186.0,
                                      child: ListView.builder(
                                        itemCount:
                                            provider1.latestBlogModel.length,
                                        shrinkWrap: true,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        scrollDirection: Axis.horizontal,
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        itemBuilder: (context, index) {
                                          final latest =
                                              provider1.latestBlogModel[index];

                                          return GestureDetector(
                                            onTap: latest.id ==
                                                    provider.blogContent.first
                                                        .blogId
                                                ? null
                                                : () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            BlogPostPage(
                                                                blogId:
                                                                    latest.id,
                                                                authorId: latest
                                                                    .author,
                                                                headerSection:
                                                                    latest))),
                                            child: Container(
                                              width: size.width * 0.5,
                                              margin: EdgeInsets.only(
                                                  right: index ==
                                                          provider1
                                                                  .latestBlogModel
                                                                  .length -
                                                              1
                                                      ? 0.0
                                                      : 10.0),
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 100.0,
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .borderRadius),
                                                        color: Colors
                                                            .grey.shade200,
                                                        image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              latest
                                                                  .coverPhoto),
                                                          fit: BoxFit.cover,
                                                          onError: (exception,
                                                                  stackTrace) =>
                                                              Container(),
                                                        )),
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0,
                                                          horizontal: 10.0),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                AppDimensions
                                                                    .borderRadius),
                                                        color: Colors.white,
                                                      ),
                                                      child: Text(
                                                          latest.category,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: Theme.of(
                                                                  context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 14.0),
                                                  Text(latest.title,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleSmall
                                                          ?.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                  const SizedBox(height: 8.0),
                                                  Text(latest.blogDescription,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                              color:
                                                                  Colors.grey)),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              );
                      }),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
      );
    });
  }
}
