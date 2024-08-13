class ApiConstant {
  // *********************** INSTANCE *********************** //
  static const String localUrl = 'https://makeupstarstudio.com';
  static const String liveUrl = 'https://makeupstarstudio.com';
  // static const String localUrl = 'http://localhost:3001';
  // static const String liveUrl = '';

  // *********** Don't change anything below if you're not 1000% sure *********** //

  /// [AUTH_URL]
  // static const String adminRegisterUri = '/admin/register';
  static const String adminLoginUri = '/api/admin/login';

/* --------------------------------- Admin --------------------------------- */
  /// [Admin]
  /// [UPLOAD]
  static const String uploadAdminImage = '/api/admin/upload';

  /// [GET]
  static String getAdminInfo(String id) => "/api/admin/$id";

  /// [UPDATE]
  static String updateAdmin(String id) => "/api/admin/$id";

  /// [UPDATEPASSWORD]
  static String updateAdminPassword(String id) =>
      "/api/admin/update-password/$id";

/*--------------------------------- Services ---------------------------------*/
  /// [Services]
  /// [UPLOAD]
  static const String uploadServiceImage = '/api/services/upload';

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
  /// [UPLOAD]
  static const String uploadPortfolioImages = '/api/portfolio/upload';

  /// [GET]
  static const String getAllPortfolio = '/api/portfolio/';
  static const String getBridalPortfolio = '/api/portfolio/Bridal';
  static const String getBridalHennaGallery = '/api/portfolio/Bridal-Henna';
  static const String getNonBridalHennaGallery = '/api/portfolio/NonBridal-Henna';
  static const String getNonBridalGallery = '/api/portfolio/Non-Bridal';
  static const String getWhiteBridalGallery = '/api/portfolio/White-Bride';
  static const String getDrapingGallery = '/api/portfolio/Draping';

  /// [POST]
  static const String postPortfolio = '/api/portfolio/';

  /// [DELETE]
  static String deletePortfolioByCat(String category) => '/api/portfolio/delete/$category';
  static const String deleteBridalPortfolioByCat = "/api/portfolio/delete/Bridal";
  static const String deleteBridalHennaPortfolioByCat = "/api/portfolio/delete/Bridal";
  static const String deleteNonBridalHennaPortfolioByCat = "/api/portfolio/delete/Bridal";
  static const String deleteNonBridalPortfolioByCat = "/api/portfolio/delete/Bridal";
  static const String deleteWhiteBridePortfolioByCat = "/api/portfolio/delete/Bridal";
  static const String deleteDrapingPortfolioByCat = "/api/portfolio/delete/Bridal";

  /// [DELETEONE]
  static String deletePortfolio(String portfolioId, String imageId) => "/api/portfolio/$portfolioId/image/$imageId";

  /* --------------------------------- Booking --------------------------------- */
  /// [Booking]
  /// [GET]
  static const String getAllBookings = '/api/booking/';
  static String getSingleBooking(String id) => "/api/booking/$id";

  /// [POST]
  static const String postBooking = '/api/booking/';

  /// [DELETE]
  static String deleteBooking(String id) => "/api/booking/$id";

  /*------------------------RandomImages------------------------*/
  /// [RandomImages]
  /// [GET]
  static const String getRandomImages = '/api/images/';

  /// [POST]
  static const String uploadRandomImages = '/api/images/upload/';

  /// [DELETEONE]
  static String deleteRandomImage(String id) => "/api/images/delete/$id";

  /// [DELETEALL]
  static const String deleteAllRandomImages = '/api/images/';
}
