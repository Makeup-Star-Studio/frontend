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

/*--------------------------------- Services ---------------------------------*/
  /// [Services]
  /// [GET]
  static const String getAllServices = '/services/';
  static const String getBridalServices = '/services/category/bridal';
  static const String getNonBridalMakeupServices = '/services/category/makeup';
  static const String getNonBridalHairServices = '/services/category/hair';
  static const String getHennaServices = '/services/category/henna';
  static const String getDrapingServices = '/services/category/draping';

  /// [POST]
  static const String postServices = 'http://localhost:3001/services/';

  /// [UPDATE]
  static String updateService(String id) => "/services/edit/$id";

  /// [DELETE]
  static const String deleteServices = "/services/remove/";
  static String deleteService(String id) => "/services/remove/$id";

/*--------------------------------- Testimonails ---------------------------------*/
  /// [Testimonials]
  /// [GET]
  static const String getAllTestimonials = '/testimonial/';
  static String getSingleTestimonial(String id) => "/testimonial/$id";

  /// [POST]
  static const String postTestimonials = 'http://localhost:3001/testimonial/';

  /// [UPDATE]
  static String updateTestimonial(String id) => "/testimonial/$id";

  /// [DELETE]
  static String deleteTestimonial(String id) => "/testimonial/$id";

/*--------------------------------- Portfolio ---------------------------------*/
  /// [Portfolio]
  /// [GET]
  static const String getAllPortfolio = '/portfolio/';
  static const String getBridalPortfolio = '/portfolio/bridal';
  static const String getGallery = '/portfolio/gallery';

  /// [POST]
  static const String postPortfolio = 'http://localhost:3001/portfolio/';
}
