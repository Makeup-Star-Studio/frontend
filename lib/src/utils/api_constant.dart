class ApiConstant {
  // *********************** INSTANCE *********************** //
// static const String localUrl = 'https://backend-jckk.onrender.com/';
//   static const String liveUrl = 'https://backend-jckk.onrender.com/';
  static const String localUrl = 'http://localhost:3001';
  static const String liveUrl = '';

  // *********** Don't change anything below if you're not 1000% sure *********** //

  /// [AUTH_URL]
  // static const String adminRegisterUri = '/admin/register';
  static const String adminLoginUri = '/api/admin/login';

/* --------------------------------- Admin --------------------------------- */
  /// [Admin]
  /// [GET]
  static String getAdminInfo(String id) => "/api/admin/$id";

  /// [UPDATE]
  static String updateAdmin(String id) => "/api/admin/$id";

  /// [UPDATEPASSWORD]
  static String updateAdminPassword(String id) =>
      "/api/admin/update-password/$id";

/*--------------------------------- Services ---------------------------------*/
  /// [Services]
  /// [GET]
  static const String getAllServices = '/api/services/';
  static const String getBridalServices = '/api/services/category/bridal';
  static const String getNonBridalMakeupServices =
      '/api/services/category/makeup';
  static const String getNonBridalHairServices = '/api/services/category/hair';
  static const String getHennaServices = '/api/services/category/henna';
  static const String getDrapingServices = '/api/services/category/draping';

  /// [POST]
  static const String postServices = '/api/services/';

  /// [UPDATE]
  static String updateService(String id) => "/api/services/edit/$id";

  /// [DELETE]
  static const String deleteServices = "/api/services/remove/";
  static String deleteService(String id) => "/api/services/remove/$id";

/*--------------------------------- Testimonails ---------------------------------*/
  /// [Testimonials]
  /// [UPLOAD]
  static const String uploadTestimonialImage = '/api/testimonial/upload';
  /// [GET]
  static const String getAllTestimonials = '/api/testimonial/';
  static String getSingleTestimonial(String id) => "/api/testimonial/$id";

  /// [POST]
  static const String postTestimonials = '/api/testimonial/';

  /// [UPDATE]
  static String updateTestimonial(String id) => "/api/testimonial/$id";

  /// [DELETE]
  static String deleteTestimonial(String id) => "/api/testimonial/$id";

/*--------------------------------- Portfolio ---------------------------------*/
  /// [Portfolio]
  /// [GET]
  static const String getAllPortfolio = '/api/portfolio/';
  static const String getBridalPortfolio = '/api/portfolio/bridal';
  static const String getHennaGallery = '/api/portfolio/henna';
  static const String getNonBridalGallery = '/api/portfolio/non-bridal';
  static const String getWhiteBridalGallery = '/api/portfolio/white-bride';

  /// [POST]
  static const String postPortfolio = '/api/portfolio/';

  /* --------------------------------- Booking --------------------------------- */
  /// [Booking]
  /// [GET]
  static const String getAllBookings = '/api/booking/';
  static String getSingleBooking(String id) => "/api/booking/$id";

  /// [POST]
  static const String postBooking = '/api/booking/';

  /// [DELETE]
  static String deleteBooking(String id) => "/api/booking/$id";
}
