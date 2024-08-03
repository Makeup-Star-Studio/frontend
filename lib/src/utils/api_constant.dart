class ApiConstant {
  // *********************** INSTANCE *********************** //
// static const String localUrl = 'https://backend-jckk.onrender.com/';
//   static const String liveUrl = 'https://backend-jckk.onrender.com/';
  static const String localUrl = 'http://localhost:3001';
  static const String liveUrl = '';

  // *********** Don't change anything below if you're not 1000% sure *********** //

  /// [AUTH_URL]
  // static const String adminRegisterUri = '/admin/register';
  static const String adminLoginUri = '/admin/login';

  /// [Services]
  static const String getBridalServices = '/services/category/bridal';
  static const String getNonBridalMakeupServices = '/services/category/makeup';
  static const String getNonBridalHairServices = '/services/category/hair';
  static const String getHennaServices = '/services/category/henna';
  static const String getDrapingServices = '/services/category/draping';

  /// [Testimonials]
  static const String getAllTestimonials = '/testimonial/';
  static String getSingleTestimonial(String id) => "/testimonial/$id";
  static String updateTestimonial(String id) => "/testimonial/$id";
  static String deleteTestimonial(String id) => "/testimonial/$id";

  static const String postTestimonials = 'http://localhost:3001/testimonial/';
}
