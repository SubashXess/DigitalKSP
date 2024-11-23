import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import '../models/wishwall/wishwall_profiles_model.dart';

class WishWallProviders extends ChangeNotifier {
  List<OrgProfileModel> _orgProfiles = [];
  List<OrgProfileModel> get orgProfiles => _orgProfiles;

  List<OrgProfileModel> _orgDetailProfile = [];
  List<OrgProfileModel> get orgDetailProfile => _orgDetailProfile;

  List<IndProfileModel> _indProfiles = [];
  List<IndProfileModel> get indProfiles => _indProfiles;

  List<IndProfileModel> _indDetailProfile = [];
  List<IndProfileModel> get indDetailProfile => _indDetailProfile;

  Future<void> getOrgProfiles({String limit = '10'}) async {
    final Uri url =
        Uri.parse('${ApiRequest.instance.apiGetOrgProfile}?limit=$limit');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _orgProfiles = OrgProfileModel.orgProfileFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getOrgDetailsProfile({required String id}) async {
    _orgDetailProfile = [];
    final Uri url = Uri.parse('${ApiRequest.instance.apiGetOrgProfile}?id=$id');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _orgDetailProfile =
            OrgProfileModel.orgProfileFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getIndProfiles({String limit = '10'}) async {
    final Uri url =
        Uri.parse('${ApiRequest.instance.apiGetIndProfile}?limit=$limit');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _indProfiles = IndProfileModel.indProfileFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getIndDetailsProfile({required String id}) async {
    _indDetailProfile = [];
    final Uri url = Uri.parse('${ApiRequest.instance.apiGetIndProfile}?id=$id');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _indDetailProfile =
            IndProfileModel.indProfileFromJson(jsonData).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
