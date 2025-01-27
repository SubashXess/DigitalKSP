// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class ApiRequest {
  final String baseUrl;

  ApiRequest._({required this.baseUrl});

  static late final ApiRequest _instance;

  factory ApiRequest.initialize({required String baseUrl}) {
    _instance = ApiRequest._(baseUrl: baseUrl);
    return _instance;
  }

  static ApiRequest get instance => _instance;

  String get _url => '$baseUrl/controllers/v1';

  static const String AUTHORIZATION = 'Authorization';
  static const String CONTENT_TYPE = 'Content-Type';
  static const String CONTENT_TYPE_JSON = 'application/json';

  String get IMAGE_URL_WITH_UPLOADS => '$baseUrl/uploads/';
  String get IMAGE_URL_WITHOUT_UPLOADS => '$baseUrl/';

  // Quotes
  String get apiGetQuote => '$_url/quotes/get_quotes.php';

  // Authors
  String get apiGetAuthor => '$_url/author/get_author.php';

  // Blog Categories
  String get apiGetCategories => '$_url/category/get_categories.php';
  String get apiGetAuthorBlogCategory =>
      '$_url/category/get_author_blog_categories.php'; // author

  // Blogs
  String get apiGetBlogByCategory => '$_url/blogs/get_blog_post.php';
  String get apiGetBlogByIndCategory =>
      '$_url/blogs/get_ind_blogs_by_category.php';
  String get apiGetBlogByAuthor => '$_url/blogs/blogs_by_author.php';
  String get apiGetBlogs => '$_url/blogs/get_blog.php';
  String get apiGetBlogPost => '$_url/blogs/get_blog_post.php'; // blog_id

  // Jobs
  String get apiApplyJob => '$_url/jobs/apply_job.php';
  String get apiGetJobPost => '$_url/jobs/get_job_post.php'; // job_id
  String get apiGetJobs => '$_url/jobs/get_jobs.php';

  // Wishwall profiles
  String get apiGetOrgProfile => '$_url/wishwall/get_org_profile.php';
  String get apiGetIndProfile => '$_url/wishwall/get_ind_profile.php';

  // Search
  String get apiSearch => '$_url/search/search.php';

  // Ads
  String get apiGetAds => '$_url/ads/ads.php';
  String get apiAdLead => '$_url/ads/on_ad_click.php';
}
