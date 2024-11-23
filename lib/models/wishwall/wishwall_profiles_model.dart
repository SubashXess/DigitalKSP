import '../../constants/urls.dart';

class OrgProfileModel {
  final String id;
  final String orgName;
  final String orgEmail;
  final String orgMobile;
  final String estDate;
  final String industry;
  final String orgAddress;
  final String serviceYears;
  final String bio;
  final String otherInformation;
  final String achievements;
  final String profilePhoto;
  final String profilesStatus;
  final String orgUrl;
  final String createdAt;
  final String updatedAt;

  const OrgProfileModel({
    required this.id,
    required this.orgName,
    required this.orgEmail,
    required this.orgMobile,
    required this.estDate,
    required this.industry,
    required this.orgAddress,
    required this.serviceYears,
    required this.bio,
    required this.otherInformation,
    required this.achievements,
    required this.profilePhoto,
    required this.profilesStatus,
    required this.orgUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrgProfileModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_photo'];

    // if (imagePath.startsWith('../')) {
    //   imagePath = imagePath.substring(3);
    // }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITH_UPLOADS}$imagePath'
        : 'assets/images/placeholder-user.png';

    return OrgProfileModel(
      id: json["id"].toString(),
      orgName: json["org_name"] ?? '',
      orgEmail: json["org_email"] ?? '',
      orgMobile: json["org_mobile"] ?? '',
      estDate: json["est_date"] ?? '',
      industry: json["industry"] ?? '',
      orgAddress: json["org_address"] ?? '',
      serviceYears: json["service_years"].toString(),
      bio: json["bio"] ?? '',
      otherInformation: json["other_information"] ?? '',
      achievements: json["achievements"] ?? '',
      profilePhoto: imageUrl,
      profilesStatus: json["profiles_status"] ?? '',
      orgUrl: json["org_url"] ?? '',
      createdAt: json["created_at"] ?? '',
      updatedAt: json["updated_at"] ?? '',
    );
  }

  static List<OrgProfileModel> orgProfileFromJson(
      Map<String, dynamic> jsonData) {
    final profile = jsonData['data']['org_profiles'] as List;
    return profile.map((data) => OrgProfileModel.fromJson(data)).toList();
  }
}

class IndProfileModel {
  final String id;
  final String type;
  final String fullName;
  final String email;
  final String mobile;
  final String dob;
  final String industry;
  final String address;
  final String qualification;
  final String achievements;
  final String otherQualification;
  final String university;
  final String passingYear;
  final String experienceYears;
  final String currentCompany;
  final String designation;
  final String bio;
  final String profilePhoto;
  final String profilesStatus;
  final String url;
  final String createdAt;
  final String updatedAt;

  IndProfileModel({
    required this.id,
    required this.type,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.industry,
    required this.address,
    required this.qualification,
    required this.achievements,
    required this.otherQualification,
    required this.university,
    required this.passingYear,
    required this.experienceYears,
    required this.currentCompany,
    required this.designation,
    required this.bio,
    required this.profilePhoto,
    required this.profilesStatus,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
  });

  factory IndProfileModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_photo'];

    // if (imagePath.startsWith('../')) {
    //   imagePath = imagePath.substring(3);
    // }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITH_UPLOADS}$imagePath'
        : 'assets/images/placeholder-user.png';

    return IndProfileModel(
      id: json["id"].toString(),
      type: json["type"] ?? '',
      fullName: json["full_name"] ?? '',
      email: json["email"] ?? '',
      mobile: json["mobile"] ?? '',
      dob: json["dob"] ?? '',
      industry: json["industry"] ?? '',
      address: json["address"] ?? '',
      qualification: json["qualification"] ?? '',
      achievements: json["achievements"] ?? '',
      otherQualification: json["other_qualification"] ?? '',
      university: json["university"] ?? '',
      passingYear: json["passing_year"].toString(),
      experienceYears: '${json["experience_years"]} years'.toString(),
      currentCompany: json["current_company"] ?? '',
      designation: json["designation"] ?? '',
      bio: json["bio"] ?? '',
      profilePhoto: imageUrl,
      profilesStatus: json["profiles_status"] ?? '',
      url: json["url"] ?? '',
      createdAt: json["created_at"] ?? '',
      updatedAt: json["updated_at"] ?? '',
    );
  }

  static List<IndProfileModel> indProfileFromJson(
      Map<String, dynamic> jsonData) {
    final profile = jsonData['data']['wish_wall_profiles'] as List;
    return profile.map((data) => IndProfileModel.fromJson(data)).toList();
  }
}
