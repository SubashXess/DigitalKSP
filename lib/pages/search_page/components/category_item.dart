import 'package:digitalksp/models/search_model.dart';
import 'package:digitalksp/pages/category_page/category_page.dart';
import 'package:flutter/material.dart';
import '../../../constants/styles.dart';

class SearchCategorySection extends StatelessWidget {
  const SearchCategorySection({super.key, required this.items});

  final List<SearchCategoryModel> items;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('CATEGORIES',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 20.0),
          Wrap(
            runSpacing: 10.0,
            spacing: 10.0,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];
                return SearchCategoryItem(item: item);
              },
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class SearchCategoryItem extends StatelessWidget {
  const SearchCategoryItem({super.key, required this.item});

  final SearchCategoryModel item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (_) => CategoryPage(category: item.name))),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          color: Colors.white,
          border: Border.all(color: AppThemes.borderTheme),
        ),
        child: Text(item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: Colors.black87, fontSize: 13.0)),
      ),
    );
  }
}
