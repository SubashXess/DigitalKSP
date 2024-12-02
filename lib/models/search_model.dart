import '../constants/urls.dart';

class SearchModel {
  final List<SearchCategoryModel> category;
  final List<SearchAuthorModel> author;
  final List<SearchBlogModel> blog;
  final List<SearchJobModel> job;
  final List<SearchIndProfile> indProfile;
  final List<SearchOrgProfile> orgProfile;

  const SearchModel({
    required this.category,
    required this.author,
    required this.blog,
    required this.job,
    required this.indProfile,
    required this.orgProfile,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};

    return SearchModel(
      category: (data['category'] as List<dynamic>? ?? [])
          .map((item) => SearchCategoryModel.fromJson(item))
          .toList(),
      author: (data['author'] as List<dynamic>? ?? [])
          .map((item) => SearchAuthorModel.fromJson(item))
          .toList(),
      blog: (data['blogs'] as List<dynamic>? ?? [])
          .map((item) => SearchBlogModel.fromJson(item))
          .toList(),
      job: (data['jobs'] as List<dynamic>? ?? [])
          .map((item) => SearchJobModel.fromJson(item))
          .toList(),
      indProfile: (data['ind_profile'] as List<dynamic>? ?? [])
          .map((item) => SearchIndProfile.fromJson(item))
          .toList(),
      orgProfile: (data['org_profile'] as List<dynamic>? ?? [])
          .map((item) => SearchOrgProfile.fromJson(item))
          .toList(),
    );
  }
}

class SearchCategoryModel {
  final String id;
  final String name;
  const SearchCategoryModel({required this.id, required this.name});

  factory SearchCategoryModel.fromJson(Map<String, dynamic> json) {
    return SearchCategoryModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
    );
  }
}

class SearchAuthorModel {
  final String id;
  final String name;
  final String bio;
  final String profile;

  const SearchAuthorModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.profile,
  });

  factory SearchAuthorModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_picture'] ?? '';

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return SearchAuthorModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      bio: json['address'] ?? '',
      profile: imageUrl,
    );
  }
}

class SearchBlogModel {
  final String id;
  final String title;
  final String category;
  final String coverPhoto;
  final String publishedDate;
  final SearchBlogAuthorModel authorDetails;

  const SearchBlogModel({
    required this.id,
    required this.title,
    required this.category,
    required this.coverPhoto,
    required this.publishedDate,
    required this.authorDetails,
  });

  factory SearchBlogModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['cover_photo'] ?? '';

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return SearchBlogModel(
      id: json["id"].toString(),
      title: json["title"] ?? '',
      category: json["category"] ?? '',
      coverPhoto: imageUrl,
      publishedDate: json["published_date"] ?? '',
      authorDetails: SearchBlogAuthorModel.fromJson(json["author_details"]),
    );
  }
}

class SearchBlogAuthorModel {
  final String id;
  final String name;
  final String bio;
  final String profile;

  const SearchBlogAuthorModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.profile,
  });

  factory SearchBlogAuthorModel.fromJson(Map<String, dynamic> json) {
    String imagePath = json['profile_picture'] ?? '';

    if (imagePath.startsWith('../')) {
      imagePath = imagePath.substring(3);
    }

    final imageUrl = imagePath.isNotEmpty
        ? '${ApiRequest.instance.IMAGE_URL_WITHOUT_UPLOADS}$imagePath'
        : '';

    return SearchBlogAuthorModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      bio: json['address'] ?? '',
      profile: imageUrl,
    );
  }
}

class SearchJobModel {
  final String id;
  final String jobTitle;
  final String companyName;
  final String experience;
  final String location;
  final String postedOn;
  final String companyLogo;

  SearchJobModel({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.experience,
    required this.location,
    required this.postedOn,
    required this.companyLogo,
  });

  factory SearchJobModel.fromJson(Map<String, dynamic> json) => SearchJobModel(
        id: json["id"].toString(),
        jobTitle: json["job_title"] ?? '',
        companyName: json["company_name"] ?? '',
        experience: json["experience"] ?? '',
        location: json["location"] ?? '',
        postedOn: json["posted_on"] ?? '',
        companyLogo: json["company_logo"] ?? '',
      );
}

class SearchIndProfile {
  final String id;
  final String fullName;
  final String industry;
  final String address;
  final String qualification;
  final String otherQualification;
  final String university;
  final String experienceYears;
  final String profilePhoto;

  SearchIndProfile({
    required this.id,
    required this.fullName,
    required this.industry,
    required this.address,
    required this.qualification,
    required this.otherQualification,
    required this.university,
    required this.experienceYears,
    required this.profilePhoto,
  });

  factory SearchIndProfile.fromJson(Map<String, dynamic> json) =>
      SearchIndProfile(
        id: json["id"].toString(),
        fullName: json["full_name"] ?? '',
        industry: json["industry"] ?? '',
        address: json["address"] ?? '',
        qualification: json["qualification"] ?? '',
        otherQualification: json["other_qualification"] ?? '',
        university: json["university"] ?? '',
        experienceYears: json["experience_years"].toString(),
        profilePhoto: json["profile_photo"] ?? '',
      );
}

class SearchOrgProfile {
  final String id;
  final String orgName;
  final String industry;
  final String orgAddress;
  final String profilePhoto;

  SearchOrgProfile({
    required this.id,
    required this.orgName,
    required this.industry,
    required this.orgAddress,
    required this.profilePhoto,
  });

  factory SearchOrgProfile.fromJson(Map<String, dynamic> json) =>
      SearchOrgProfile(
        id: json["id"].toString(),
        orgName: json["org_name"] ?? '',
        industry: json["industry"] ?? '',
        orgAddress: json["org_address"] ?? '',
        profilePhoto: json["profile_photo"] ?? '',
      );
}
