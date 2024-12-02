import 'dart:convert';
import 'dart:developer';
import 'package:digitalksp/models/search_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class SearchProviders extends ChangeNotifier {
  SearchModel? _searchModel;
  SearchModel? get searchModel => _searchModel;

  Future<void> getSearchResult({required String query}) async {
    _searchModel = null;

    final Uri url = Uri.parse('${ApiRequest.instance.apiSearch}?query=$query');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _searchModel = SearchModel.fromJson(jsonData);
        log(_searchModel.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
