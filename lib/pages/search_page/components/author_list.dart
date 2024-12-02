import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/models/search_model.dart';
import 'package:digitalksp/pages/author_page/author_page.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class SearchAuthorSection extends StatelessWidget {
  const SearchAuthorSection({super.key, required this.items});

  final List<SearchAuthorModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AUTHORS',
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 20.0),
        ListView.builder(
          itemCount: items.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          clipBehavior: Clip.none,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final item = items[index];
            return Padding(
              padding: EdgeInsets.only(
                  bottom: index == items.length - 1 ? 0.0 : 10.0),
              child: SearchAuthorItem(item: item),
            );
          },
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}

class SearchAuthorItem extends StatelessWidget {
  const SearchAuthorItem({super.key, required this.item});

  final SearchAuthorModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => AuthorPage(authorId: item.id))),
      child: Container(
        width: double.infinity,
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              alignment: Alignment.bottomRight,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppThemes.defaultTheme,
                image: DecorationImage(
                  image: CachedNetworkImageProvider(item.profile),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => Container(),
                ),
              ),
              child: Icon(Icons.check_circle_rounded,
                  color: Theme.of(context).primaryColor, size: 14.0),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    item.bio,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }
}
