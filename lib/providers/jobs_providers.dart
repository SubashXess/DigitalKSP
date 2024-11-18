import 'dart:convert';
import 'dart:developer';

import 'package:digitalksp/models/jobs/jobs_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class JobsProviders extends ChangeNotifier {
  List<JobModels> _jobsModel = [];
  List<JobModels> get jobModel => _jobsModel;

  JobPostModel? _jobPostModel;
  JobPostModel? get jobPostModel => _jobPostModel;

  Future<void> getJobs({String limit = '12'}) async {
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_JOBS}?limit=$limit');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        _jobsModel = JobModels.jobsFromJson(jsonData).toList();

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> getJobPost({required String id}) async {
    _jobPostModel = null;
    final Uri url = Uri.parse(
        '${ApiRequest.BASE_URL}${ApiRequest.API_GET_JOB_POST}?job_id=$id');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _jobPostModel = JobPostModel.fromJson(jsonData['data']);
        log(_jobPostModel.toString());
        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
