import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:digitalksp/pages/author_page/author_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/author/author_models.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({
    super.key,
    this.size = 45.0,
    required this.author,
    required this.publishedDate,
    this.textColor = Colors.black,
  });

  final AuthorModels author;
  final String publishedDate;
  final double size;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => AuthorPage(authorId: author.id))),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.borderRadius),
                  border: Border.all(color: Colors.grey.shade400),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(author.photoUrl),
                      fit: BoxFit.cover)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        author.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500, color: textColor),
                      ),
                      const SizedBox(width: 6.0),
                      Tooltip(
                        message: 'Digital KSP Verified',
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: EdgeInsets.zero,
                        child: Icon(Icons.check_circle_rounded,
                            color: Theme.of(context).primaryColor, size: 14.0),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('d MMM, yyyy')
                            .format(DateTime.parse(publishedDate)),
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
