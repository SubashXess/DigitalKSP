import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/job_page/job_post_page.dart';
import 'package:digitalksp/providers/blog_providers.dart';
import 'package:digitalksp/providers/categories_provider.dart';
import 'package:digitalksp/providers/jobs_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../widgets/buttons_widget.dart';
import '../blog_post_page/blog_post_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogProviders>().getBlogs(type: 'Featured', limit: 12);
    context.read<BlogProviders>().getBlogs(type: 'Most Popular', limit: 12);
    context.read<BlogProviders>().getBlogs(type: 'Normal', limit: 12);
    // context.read<BlogProviders>().getBlogs(type: 'Front Banner', limit: 4);
    context.read<BlogProviders>().getBlogs(type: 'Recent', limit: 4);
    context.read<CategoriesProvider>().getCategory();
    context.read<JobsProviders>().getJobs();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActionButton(
                    icon: 'assets/icons/menu.svg',
                    onTap: () {},
                  ),
                  Row(
                    children: [
                      ActionButton(
                        icon: 'assets/icons/notification-bell.svg',
                        onTap: () {},
                      ),
                      const SizedBox(width: 8.0),
                      ActionButton(
                        icon: 'assets/icons/search.svg',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Consumer<CategoriesProvider>(builder: (context, provider, child) {
              return Container(
                height: 40.0,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  itemCount: provider.categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  clipBehavior: Clip.none,
                  itemBuilder: (context, index) {
                    final item = provider.categories[index];
                    final isSelected = provider.categorySelectedIndex == index;
                    return GestureDetector(
                      // onTap: () => provider.onCategorySelected(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        margin: EdgeInsets.only(
                            right: index == provider.categories.length - 1
                                ? 0.0
                                : 6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppDimensions.borderRadius),
                          color: isSelected
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade100,
                        ),
                        child: Text(item.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black)),
                      ),
                    );
                  },
                ),
              );
            }),
            const SizedBox(height: 20.0),
            Consumer<BlogProviders>(builder: (_, provider, __) {
              return provider.recentBlogModel.isEmpty
                  ? const SizedBox()
                  : CarouselSlider.builder(
                      itemCount: provider.recentBlogModel.length,
                      itemBuilder: (context, index, realIndex) {
                        final blog = provider.recentBlogModel[index];
                        return Container(
                          width: size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          padding: const EdgeInsets.all(10.0),
                          alignment: Alignment.bottomCenter,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius),
                              // gradient: const LinearGradient(
                              //     colors: [Colors.black, Colors.transparent],
                              //     begin: Alignment.bottomCenter,
                              //     end: Alignment.topCenter,
                              //     stops: [0.0, 0.5]),
                              image: DecorationImage(
                                image:
                                    CachedNetworkImageProvider(blog.coverPhoto),
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) => Container(),
                              )),
                          child: Container(
                            width: size.width,
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    AppDimensions.borderRadius),
                                color: Colors.white.withOpacity(0.86)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(blog.category,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .primaryColor)),
                                const SizedBox(height: 4.0),
                                Text(blog.title,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            fontWeight: FontWeight.w500)),
                              ],
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 8),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 450),
                        clipBehavior: Clip.none,
                        aspectRatio: 16 / 11,
                        viewportFraction: 1.0,
                      ),
                    );
            }),
            const SizedBox(height: 20.0),
            Consumer<BlogProviders>(builder: (_, provider, __) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Featured Blogs',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      width: size.width,
                      height: 200.0,
                      child: GridView.builder(
                        itemCount: provider.featuredBlogModel.length,
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
                          final featured = provider.featuredBlogModel[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlogPostPage(
                                        blogId: featured.id,
                                        authorId: featured.author,
                                        headerSection: featured))),
                            child: Container(
                              color: Colors.transparent,
                              child: Row(
                                children: [
                                  Container(
                                    width: 80.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            featured.coverPhoto),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(featured.category,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.w500,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                        const SizedBox(height: 8.0),
                                        Text(featured.title,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500)),
                                        const SizedBox(height: 4.0),
                                        Text(featured.blogDescription,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(color: Colors.grey)),
                                      ],
                                    ),
                                  ),
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
            Consumer<JobsProviders>(builder: (context, provider, __) {
              return provider.jobModel.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Jobs Vacancy',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(height: 10.0),
                          SizedBox(
                            height: 178.0,
                            child: ListView.builder(
                              itemCount: provider.jobModel.length,
                              shrinkWrap: true,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              scrollDirection: Axis.horizontal,
                              clipBehavior: Clip.none,
                              itemBuilder: (context, index) {
                                final job = provider.jobModel[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                JobPostPage(jobId: job.id)));
                                    print(job.id);
                                  },
                                  child: Container(
                                    width: size.width * 0.68,
                                    margin: EdgeInsets.only(
                                        right: index ==
                                                provider.jobModel.length - 1
                                            ? 0.0
                                            : 10.0),
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          AppDimensions.borderRadius),
                                      border: Border.all(
                                          color: Colors.grey.shade200),
                                    ),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(job.jobTitle,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500)),
                                          const SizedBox(height: 4.0),
                                          Text(job.companyName,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall),
                                          const SizedBox(height: 16.0),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/briefcase-outlined.svg',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.center,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.grey.shade500,
                                                    BlendMode.srcIn),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Text(job.experience,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            ],
                                          ),
                                          const SizedBox(height: 6.0),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/location-outlined.svg',
                                                width: 15.0,
                                                height: 15.0,
                                                fit: BoxFit.scaleDown,
                                                alignment: Alignment.center,
                                                colorFilter: ColorFilter.mode(
                                                    Colors.grey.shade500,
                                                    BlendMode.srcIn),
                                              ),
                                              const SizedBox(width: 8.0),
                                              Expanded(
                                                child: Text(job.location,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10.0),
                                          const Spacer(),
                                          Text('10 Jan, 2025',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                      color: Colors.grey)),
                                        ]),
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
            Consumer<BlogProviders>(builder: (_, provider, __) {
              return SizedBox(
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text('Popular Blogs',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: 174.0,
                      child: ListView.builder(
                        itemCount: provider.popularBlogModel.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        itemBuilder: (context, index) {
                          final blog = provider.popularBlogModel[index];
                          return GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => BlogPostPage(
                                        blogId: blog.id,
                                        authorId: blog.author,
                                        headerSection: blog))),
                            child: Container(
                              width: size.width * 0.4,
                              color: Colors.transparent,
                              margin: EdgeInsets.only(
                                  right: index ==
                                          provider.popularBlogModel.length - 1
                                      ? 0.0
                                      : 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: size.width * 0.4,
                                    height: 100.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0),
                                      color: Colors.grey.shade200,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                            blog.coverPhoto),
                                        fit: BoxFit.cover,
                                        onError: (exception, stackTrace) =>
                                            Container(),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(blog.category,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                  const SizedBox(height: 4.0),
                                  Text(blog.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4.0),
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
            SizedBox(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('Professional Frame',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 10.0),
                  SizedBox(
                    height: 210.0,
                    child: ListView.builder(
                      itemCount: 10,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          child: Container(
                            width: size.width * 0.56,
                            margin: EdgeInsets.only(
                                right: index == 10 - 1 ? 0.0 : 10.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  AppDimensions.borderRadius),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const CircleAvatar(radius: 36.0),
                                  const SizedBox(height: 10.0),
                                  Text('Eleanor Pena',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.w500)),
                                  const SizedBox(height: 4.0),
                                  Text('Consultant',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                  const SizedBox(height: 16.0),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/briefcase-outlined.svg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        colorFilter: ColorFilter.mode(
                                            Colors.grey.shade500,
                                            BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text('16 years',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    ],
                                  ),
                                  const SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/location-outlined.svg',
                                        width: 15.0,
                                        height: 15.0,
                                        fit: BoxFit.scaleDown,
                                        alignment: Alignment.center,
                                        colorFilter: ColorFilter.mode(
                                            Colors.grey.shade500,
                                            BlendMode.srcIn),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Expanded(
                                        child: Text(
                                            'Bhubaneswar, Odisha, Bhubaneswar, Bhubaneswar.,Bhubaneswar',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Consumer<BlogProviders>(builder: (_, provider, __) {
              return provider.normalBlogModel.isEmpty
                  ? const SizedBox()
                  : SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text('Our Blogs',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w700)),
                          ),
                          const SizedBox(height: 10.0),
                          ListView.builder(
                            itemCount: provider.normalBlogModel.length,
                            shrinkWrap: true,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final blog = provider.normalBlogModel[index];
                              return GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => BlogPostPage(
                                            blogId: blog.id,
                                            authorId: blog.author,
                                            headerSection: blog))),
                                child: Container(
                                  width: size.width,
                                  color: Colors.transparent,
                                  margin: EdgeInsets.only(
                                      bottom: index ==
                                              provider.normalBlogModel.length -
                                                  1
                                          ? 0.0
                                          : 10.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 80.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            color: Colors.grey.shade200,
                                            image: DecorationImage(
                                              image: CachedNetworkImageProvider(
                                                  blog.coverPhoto),
                                              fit: BoxFit.cover,
                                              onError:
                                                  (exception, stackTrace) =>
                                                      Container(),
                                            )),
                                      ),
                                      const SizedBox(width: 10.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(blog.category,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Theme.of(context)
                                                            .primaryColor)),
                                            const SizedBox(height: 6.0),
                                            Text(blog.title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall
                                                    ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.w500)),
                                            const SizedBox(height: 4.0),
                                            Text(blog.blogDescription,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                        color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
            }),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

// void _buildDialogBox(context, {required String name, required String quote}) {
//   if (mounted) {
//     showDialog(
//       context: context,
//       useSafeArea: true,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.white,
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16.0),
//           ),
//           child: Container(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   quote,
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineSmall
//                       ?.copyWith(fontWeight: FontWeight.w500),
//                 ),
//                 const SizedBox(height: 20.0),
//                 Text(
//                   '— Mahatma Gandhi',
//                   textAlign: TextAlign.center,
//                   style: Theme.of(context)
//                       .textTheme
//                       .bodyMedium
//                       ?.copyWith(fontStyle: FontStyle.italic),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
