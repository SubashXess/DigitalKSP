import 'dart:convert';
import 'dart:developer';

import 'package:digitalksp/models/jobs/jobs_models.dart';
import 'package:flutter/material.dart';
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

  Future<void> applyJob(context, {required JobApplyModel job}) async {
    final Uri url =
        Uri.parse('${ApiRequest.BASE_URL}${ApiRequest.API_POST_JOB_APPLY}');

    try {
      final request = http.MultipartRequest('POST', url)
        ..fields['name'] = job.name
        ..fields['email'] = job.email
        ..fields['mobile'] = job.phone
        ..fields['current_ctc'] = job.ctc
        ..fields['current_company'] = job.company
        ..fields['job_id'] = job.jobId;

      final resume = await http.MultipartFile.fromPath(
        'resume',
        job.resume.path,
      );
      request.files.add(resume);

      var response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonData = json.decode(responseBody);

        if (jsonData['success'] == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonData['message'])));
          notifyListeners();
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonData['message'])));
        }
      } else {
        throw Exception(
            'Failed to submit application. Status code: ${response.statusCode}');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
