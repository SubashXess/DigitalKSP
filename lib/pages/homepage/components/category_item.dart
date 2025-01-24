import 'package:cached_network_image/cached_network_image.dart';
import 'package:digitalksp/constants/styles.dart';
import 'package:flutter/material.dart';
import '../../../models/categories_model.dart';
import '../../category_page/category_page.dart';

class CategoryItemList extends StatelessWidget {
  const CategoryItemList({super.key, required this.items});

  final List<CategoriesModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        clipBehavior: Clip.none,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemBuilder: (context, index) {
          return Padding(
            padding:
                EdgeInsets.only(right: index == items.length - 1 ? 0.0 : 10.0),
            child: CategoryItem(item: items[index]),
          );
        },
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.item});

  final CategoriesModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => CategoryPage(category: item.name))),
      child: Column(
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.shade200,
              border: Border.all(
                  color: AppThemes.borderTheme,
                  width: AppDimensions.borderWidth * 2.0),
              image: DecorationImage(
                image: CachedNetworkImageProvider(item.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(item.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
