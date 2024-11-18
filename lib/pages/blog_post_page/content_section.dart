import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import '../../constants/styles.dart';
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
                  padding: const EdgeInsets.only(bottom: 8.0),
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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      content.subHeadingType == ""
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
                              .titleSmall
                              ?.copyWith(fontSize: 16.0),
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
            ),
          ),
          content.imagePaths.isEmpty
              ? const SizedBox(height: 0.0, width: 0.0)
              : SizedBox(
                  width: size.width,
                  child: Wrap(
                    children: List.generate(
                      content.imagePaths.length,
                      (index) {
                        return content.imagePaths[index].isNotEmpty
                            ? Container(
                                width: size.width,
                                height: 200.0,
                                margin: const EdgeInsets.only(bottom: 20.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      AppDimensions.borderRadius),
                                  color: Colors.grey.shade200,
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(content.imagePaths[index]),
                                    fit: BoxFit.cover,
                                    onError: (_, __) => Container(),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
