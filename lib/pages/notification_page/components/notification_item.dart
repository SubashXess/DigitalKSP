import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/models/notification_models.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constants/styles.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({super.key, required this.item});

  final NotificationModels item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppThemes.defaultTheme,
              image: DecorationImage(
                colorFilter: item.read
                    ? const ColorFilter.mode(Colors.white, BlendMode.color)
                    : null,
                image: CachedNetworkImageProvider(item.authorImage),
                fit: BoxFit.cover,
                onError: (exception, stackTrace) => Container(),
              ),
            ),
            child: Icon(Icons.check_circle_rounded,
                color: item.read ? Colors.grey : Theme.of(context).primaryColor,
                size: 14.0),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: item.read ? Colors.grey : Colors.black,
                      fontWeight:
                          item.read ? FontWeight.w400 : FontWeight.w500),
                ),
                const SizedBox(height: 6.0),
                Text(
                    DateFormat('d MMM, yyyy')
                        .format(DateTime.parse(item.publishedDate)),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: item.read
                            ? Colors.grey.shade400
                            : Colors.grey.shade600)),
              ],
            ),
          ),
          const SizedBox(width: 10.0),
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
              color: Colors.grey.shade200,
              image: DecorationImage(
                colorFilter: item.read
                    ? const ColorFilter.mode(Colors.white, BlendMode.color)
                    : null,
                image: CachedNetworkImageProvider(item.coverImage),
                onError: (exception, stackTrace) => Container(),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
