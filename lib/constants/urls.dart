// ignore_for_file: constant_identifier_names

class ApiRequest {
  // static const String DOMAIN =
  //     'http://192.168.29.168/DigitalKSP-Backend/controllers/';
  static const String IMAGE_URL_WITH_UPLOADS =
      'http://192.168.29.168/DigitalKSP-Backend/uploads/';
  static const String IMAGE_URL_WITHOUT_UPLOADS =
      'http://192.168.29.168/DigitalKSP-Backend/';

  static const String BASE_URL =
      'http://192.168.29.168/DigitalKSP-Backend/controllers/';

  static const String AUTHORIZATION = 'Authorization';
  static const String CONTENT_TYPE = 'Content-Type';
  static const String CONTENT_TYPE_JSON = 'application/json';

  static const String API_GET_QUOTE = 'get_quotes.php';
  static const String API_GET_AUTHORS = 'author/get_author.php';
  static const String API_GET_CATEGORIES = 'get_categories.php';
  static const String API_GET_BLOG_BY_AUTHOR = 'blogs/blogs_by_author.php';
  static const String API_GET_AUTHOR_BLOG_CATEGORIES =
      'author/get_author_blog_categories.php';
  static const String API_GET_BLOG_POST = 'blogs/get_blog_post.php';
  static const String API_GET_BLOGS = 'blogs/get_blog.php';

  // Jobs
  static const String API_GET_JOBS = 'jobs/get_jobs.php';
  static const String API_GET_JOB_POST =
      'jobs/get_job_post.php'; // PARAMETERS: job_id = ?
}
