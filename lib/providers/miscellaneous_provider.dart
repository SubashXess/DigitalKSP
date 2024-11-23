import 'dart:convert';
import 'dart:developer';

import 'package:digitalksp/models/quote_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class MiscellaneousProvider extends ChangeNotifier {
  List<QuoteModels> _quotes = [];
  List<QuoteModels> get quotes => _quotes;

  int _bottomNavIndex = 0;
  int get bottomNavIndex => _bottomNavIndex;

  void onNavBarSelected(int index) {
    _bottomNavIndex = index;
    notifyListeners();
  }

  Future<void> getQuotes() async {
    final Uri url = Uri.parse(ApiRequest.instance.apiGetQuote);

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        _quotes = QuoteModels.quoteFromJson(jsonData).toList();

        log(_quotes.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
