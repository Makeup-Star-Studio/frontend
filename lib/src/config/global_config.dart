import 'package:flutter/foundation.dart';
import 'package:makeupstarstudio/config/constants/app_enums.dart';
import 'package:makeupstarstudio/src/utils/api_constant.dart';



class GlobalConfig {


  // Debug
  static const bool isDebugMode = kDebugMode;
  static const bool isShowDebugModeBanner = false;

  

  // Environment
  static const Environment environment = Environment.local;

  //-***** Don't change unless you know 100% what you are doing *****-//

  // BASE URL
  static const String apiUrl = environment == Environment.local
      ? ApiConstant.localUrl
      : ApiConstant.liveUrl;

  static const String baseUrl = apiUrl;

}
