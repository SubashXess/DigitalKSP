import 'dart:convert';
import 'dart:developer';

import 'package:digitalksp/models/ads/ads_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class AdsProviders extends ChangeNotifier {
  List<AdsModel> _ads = [];
  List<AdsModel> get ads => _ads;

  Future<void> getAds({int? id}) async {
    final Uri url = Uri.parse('${ApiRequest.instance.apiGetAds}?blog_id=$id');
    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        log(jsonData.toString());
        _ads = AdsModel.adsFromJson(jsonData);
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
