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
      height: 44.0,
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
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: Colors.white,
          border: Border.all(color: AppThemes.borderTheme),
        ),
        child: Text(item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.black87)),
      ),
    );
  }
}
