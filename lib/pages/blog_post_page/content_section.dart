import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import '../../models/blog_post_model.dart';

class ContentSection extends StatelessWidget {
  const ContentSection({super.key, required this.content, required this.size});

  final BlogContentModel content;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          content.heading.isEmpty
              ? const SizedBox(height: 0.0, width: 0.0)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    content.heading,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontSize: {
                                'h1': 24.0,
                                'h2': 20.0,
                                'h3': 18.0,
                                'h4': 16.0,
                                'h5': 14.0,
                                'h6': 12.0,
                                'paragraph': 14.0,
                              }[content.headingType] ??
                              14.0,
                        ),
                  ),
                ),
          content.subHeading.isEmpty
              ? const SizedBox(height: 0.0, width: 0.0)
              : Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content.subHeadingType.isEmpty
                          ? const SizedBox(height: 0.0, width: 0.0)
                          : Container(
                              width: 6.0,
                              height: 6.0,
                              margin:
                                  const EdgeInsets.only(right: 8.0, top: 8.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black87,
                              ),
                            ),
                      Expanded(
                        child: Text(
                          content.subHeading,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(bottom: 24.0),
            child: HtmlWidget(
              content.content,
              textStyle: Theme.of(context).textTheme.bodyMedium,
              onTapUrl: (url) async {
                await Utilities.urlLauncher(url: url);
                return true;
              },
            ),
          ),
          content.imagePaths.isEmpty
              ? const SizedBox(height: 0.0, width: 0.0)
              : SizedBox(
                  width: size.width,
                  child: DynamicImageWidget(
                      imagePaths: content.imagePaths, size: size),
                  // child: Wrap(
                  //   children: List.generate(
                  //     content.imagePaths.length,
                  //     (index) {
                  //       return content.imagePaths[index].isNotEmpty
                  //           ? GestureDetector(
                  //               child: Container(
                  //                 width: size.width,
                  //                 height: size.width * 9 / 16,
                  //                 margin: const EdgeInsets.only(bottom: 20.0),
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(
                  //                       AppDimensions.borderRadius),
                  //                   color: Colors.grey.shade200,
                  //                   image: DecorationImage(
                  //                     image: CachedNetworkImageProvider(
                  //                         content.imagePaths[index]),
                  //                     fit: BoxFit.contain,
                  //                   ),
                  //                 ),
                  //               ),
                  //             )
                  //           : const SizedBox.shrink();
                  //     },
                  //   ),
                  // ),
                ),
        ],
      ),
    );
  }
}

class DynamicImageWidget extends StatelessWidget {
  final List<String> imagePaths;
  final Size size;

  const DynamicImageWidget(
      {super.key, required this.imagePaths, required this.size});

  Future<Size> _getImageSize(String imageUrl) async {
    final completer = Completer<Size>();
    final image = Image.network(imageUrl);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((info, _) {
        final myImage = info.image;
        completer.complete(
            Size(myImage.width.toDouble(), myImage.height.toDouble()));
      }),
    );
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(
        imagePaths.length,
        (index) {
          return imagePaths[index].isNotEmpty
              ? FutureBuilder<Size>(
                  future: _getImageSize(imagePaths[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        width: size.width,
                        height: 200.0,
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasData) {
                      final imageSize = snapshot.data!;
                      final aspectRatio = imageSize.width / imageSize.height;
                      final dynamicHeight = size.width / aspectRatio;

                      return GestureDetector(
                        child: Container(
                          width: size.width,
                          height: dynamicHeight,
                          margin: const EdgeInsets.only(bottom: 20.0),
                          decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(
                            //     AppDimensions.borderRadius),
                            // color: Colors.grey.shade200,
                            image: DecorationImage(
                              image:
                                  CachedNetworkImageProvider(imagePaths[index]),
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
