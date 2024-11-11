import 'package:flutter/foundation.dart';

class BlogProviders extends ChangeNotifier {
  String? _selectedCategory;
  String? get selectedCategory => _selectedCategory;

  void selectCategory(String? value) {}
}
