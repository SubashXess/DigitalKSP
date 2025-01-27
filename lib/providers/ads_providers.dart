import 'dart:convert';
import 'dart:developer';

import 'package:digitalksp/models/ads/ads_model.dart';
import 'package:digitalksp/utilities/utilities.dart';
import 'package:flutter/material.dart';
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

  Future<void> submitAdClick(context,
      {required String link, required AdClickModel model}) async {
    final Uri url = Uri.parse(ApiRequest.instance.apiAdLead);

    try {
      final response = await http.post(
        url,
        headers: {
          ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
        },
        body: json.encode(model.toJson()),
      );

      if (response.statusCode == 200) {
        Utilities.showSnackBar(
          context: context,
          message: 'Submit successfully',
        );
        Navigator.of(context).pop();
        await Utilities.urlLauncher(url: link);
      } else {
        Utilities.showSnackBar(
          context: context,
          message: 'Failed to submit. Please try again later.',
        );
      }
    } catch (err) {
      Utilities.showSnackBar(
        context: context,
        message: 'Unexpected error occurred. Please try again.',
      );
    }
  }
}
