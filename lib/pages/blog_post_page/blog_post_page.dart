import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/components/author_card.dart';
import 'package:digitalksp/models/ads/ads_model.dart';
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
                            onTap: () => _showAdDialog(
                                url: adsProvider.ads.first.textLink),
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
                        : GestureDetector(
                            onTap: () =>
                                _showAdDialog(url: adsProvider.ads.first.link2),
                            child: CachedNetworkImage(
                              imageUrl: adsProvider.ads.first.image2,
                              fit: BoxFit.fitWidth,
                            ),
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

  void _showAdDialog({required String url}) {
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
                  maxLength: 60,
                  autofillHints: const [AutofillHints.name],
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  capitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    } else if (value.length < 3) {
                      return 'Enter valid name please';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                RoundedFormField(
                  controller: emailController,
                  node: emailNode,
                  hintText: 'Email address',
                  hintColor: Colors.black54,
                  maxLength: 60,
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                RoundedFormField(
                  controller: phoneController,
                  node: phoneNode,
                  hintText: 'Phone number',
                  hintColor: Colors.black54,
                  maxLength: 15,
                  autofillHints: const [AutofillHints.telephoneNumberLocal],
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    } else if (!RegExp(r'^[0-9]{10,15}$').hasMatch(value)) {
                      return 'Enter a valid phone number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actionsOverflowAlignment: OverflowBarAlignment.center,
          actions: [
            RoundedButton(
              label: 'Submit',
              onTap: () async {
                FocusScope.of(context).unfocus();
                final ads = context.read<AdsProviders>();

                if (nameController.text.trim().isEmpty ||
                    emailController.text.trim().isEmpty ||
                    phoneController.text.trim().isEmpty) {
                  Utilities.showSnackBar(
                    context: context,
                    message: 'All fields are required',
                  );
                  return;
                }
                await ads.submitAdClick(
                  context,
                  link: url,
                  model: AdClickModel(
                    blogId: int.parse(widget.blogId),
                    blogType: ads.ads.first.addType,
                    name: nameController.text.trim(),
                    email: emailController.text.trim(),
                    contact: phoneController.text.trim(),
                  ),
                );
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
