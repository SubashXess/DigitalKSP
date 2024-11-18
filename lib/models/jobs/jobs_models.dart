import 'dart:io';

class JobModels {
  final String id;
  final String jobTitle;
  final String companyName;
  final String experience;
  final String location;
  final String postedOn;

  JobModels({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.experience,
    required this.location,
    required this.postedOn,
  });

  factory JobModels.fromJson(Map<String, dynamic> json) => JobModels(
        id: json["id"] ?? '',
        jobTitle: json["job_title"] ?? '',
        companyName: json["company_name"] ?? '',
        experience: json["experience"] ?? '',
        location: json["location"] ?? '',
        postedOn: json["posted_on"] ?? '',
      );

  static List<JobModels> jobsFromJson(Map<String, dynamic> jsonData) {
    final categories = jsonData['data']['jobs'] as List;
    return categories.map((data) => JobModels.fromJson(data)).toList();
  }
}

class JobPostModel {
  final String id;
  final String jobTitle;
  final String companyName;
  final String experience;
  final String salary;
  final String mobile;
  final String email;
  final String location;
  final String aboutEmployer;
  final String jobDescription;
  final String rolesResponsibilities;
  final String shareCount;
  final String jobStatus;
  final String postedOn;
  final String userId;
  final String companyLogo;

  JobPostModel({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.experience,
    required this.salary,
    required this.mobile,
    required this.email,
    required this.location,
    required this.aboutEmployer,
    required this.jobDescription,
    required this.rolesResponsibilities,
    required this.shareCount,
    required this.jobStatus,
    required this.postedOn,
    required this.userId,
    required this.companyLogo,
  });

  factory JobPostModel.fromJson(Map<String, dynamic> json) => JobPostModel(
        id: json["id"] ?? '',
        jobTitle: json["job_title"] ?? '',
        companyName: json["company_name"] ?? '',
        experience: json["experience"] ?? '',
        salary: json["salary"] ?? '',
        mobile: json["mobile"] ?? '',
        email: json["email"] ?? '',
        location: json["location"] ?? '',
        aboutEmployer: json["about_employer"] ?? '',
        jobDescription: json["job_description"] ?? '',
        rolesResponsibilities: json["roles_responsibilities"] ?? '',
        shareCount: json["share_count"] ?? '',
        jobStatus: json["job_status"] ?? '',
        postedOn: json["posted_on"] ?? '',
        userId: json["user_id"] ?? '',
        companyLogo: json["company_logo"] ?? '',
      );
}

class JobApplyModel {
  final String jobId;
  final String name;
  final String phone;
  final String email;
  final String ctc;
  final String company;
  final File resume;

  const JobApplyModel({
    required this.jobId,
    required this.name,
    required this.phone,
    required this.email,
    required this.ctc,
    required this.company,
    required this.resume,
  });

  Map<String, dynamic> toJson() {
    return {
      'job_id': jobId,
      'name': name,
      'mobile': phone,
      'email': email,
      'current_ctc': ctc,
      'current_company': company,
      'resume': resume.path,
    };
  }
}
