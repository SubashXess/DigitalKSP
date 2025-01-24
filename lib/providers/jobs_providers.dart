import 'dart:convert';
import 'package:digitalksp/models/jobs/jobs_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';

class JobsProviders extends ChangeNotifier {
  final List<JobModels> _jobsModel = [];
  List<JobModels> get jobModel => _jobsModel;

  JobPostModel? _jobPostModel;
  JobPostModel? get jobPostModel => _jobPostModel;

  Future<void> getJobs({String limit = '12', String page = '1'}) async {
    final Uri url =
        Uri.parse('${ApiRequest.instance.apiGetJobs}?limit=$limit&page=$page');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        final List<JobModels> jobs = JobModels.jobsFromJson(jsonData).toList();
        _jobsModel.addAll(jobs);

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
    final Uri url =
        Uri.parse('${ApiRequest.instance.apiGetJobPost}?job_id=$id');

    try {
      final response = await http.get(url, headers: {
        ApiRequest.CONTENT_TYPE: ApiRequest.CONTENT_TYPE_JSON,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        _jobPostModel = JobPostModel.fromJson(jsonData['data']);

        notifyListeners();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }

  Future<void> applyJob(context, {required JobApplyModel job}) async {
    final Uri url = Uri.parse(ApiRequest.instance.apiApplyJob);

    try {
      final request = http.MultipartRequest('POST', url)
        ..followRedirects = false
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

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final Map<String, dynamic> jsonData = json.decode(responseBody);

        if (jsonData['success'] == true) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonData['message'])));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(jsonData['message'])));
        }
        notifyListeners();
      } else {
        throw Exception(
            'Failed to submit application. Status code: ${response.statusCode}');
      }
    } catch (err) {
      throw Exception('Unexpected error occured $err');
    }
  }
}
