import 'dart:convert';

import 'package:digitalksp/constants/urls.dart';
import 'package:digitalksp/models/categories_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  List<CategoriesModel> _categories = [];
  List<CategoriesModel> get categories => _categories;

  int? _categorySelectedIndex;
  int? get categorySelectedIndex => _categorySelectedIndex;

  Future<void> getCategory() async {
    final Uri url =
        Uri.parse('${ApiRequest.BASE_URL}${ApiRequest.API_GET_CATEGORIES}');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        _categories = CategoriesModel.categoriesFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  void onCategorySelected(int index) {
    if (categorySelectedIndex == index) {
      _categorySelectedIndex = null;
    } else {
      _categorySelectedIndex = index;
    }
    notifyListeners();
  }
}
