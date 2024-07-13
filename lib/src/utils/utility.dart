// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:mitini/src/src.dart';

// import '../../navigator_key.dart';

// class Utility {
//   // Navigate through routes
//   static Future navigate(BuildContext context, String route,
//       {dynamic arguments}) {
//     return Navigator.of(context).pushNamed(
//       route,
//       arguments: arguments,
//     );
//   }

// // Navigates through screen
//   static navigateMaterialRoute(BuildContext context, screen) {
//     return Navigator.push(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => screen,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           const begin = Offset(0.0, 1.0);
//           const end = Offset.zero;
//           var tween = Tween<Offset>(begin: begin, end: end);

//           var curveTween = CurveTween(curve: Curves.ease);

//           return SlideTransition(
//             position: animation.drive(curveTween).drive(tween),
//             child: child,
//           );
//         },
//       ),
//     );
//   }

//   // Method to navigate to a new screen using custom animation
//   static Future<void> navigatepushAndRemoveUntil(
//       BuildContext context, Widget screen,
//       {Duration duration = const Duration(milliseconds: 300)}) {
//     return Navigator.pushAndRemoveUntil(
//       context,
//       PageRouteBuilder(
//         pageBuilder: (context, animation, secondaryAnimation) => screen,
//         transitionsBuilder: (context, animation, secondaryAnimation, child) {
//           var begin = const Offset(1.0, 0.0);
//           var end = Offset.zero;
//           var curve = Curves.ease;

//           var tween =
//               Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//           var offsetAnimation = animation.drive(tween);

//           return SlideTransition(
//             position: offsetAnimation,
//             child: child,
//           );
//         },
//         transitionDuration: duration,
//       ),
//       (Route<dynamic> route) => false,
//     );
//   }

//   horizonDivider(String title,
//       {bool isSingleDivider = false, color, textStyle}) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (isSingleDivider)
//           Expanded(
//             child: Divider(
//               indent: 10.0,
//               endIndent: 20.0,
//               thickness: 1,
//               color: color,
//             ),
//           ),
//         if (isSingleDivider)
//           Padding(
//             padding: const EdgeInsets.only(right: 15),
//             child: Text(
//               title,
//               style: textStyle ?? AppStyles.text14PxRegular,
//             ),
//           ),
//         if (!isSingleDivider)
//           Expanded(
//             child: Divider(
//               indent: 20.0,
//               endIndent: 10.0,
//               thickness: 1,
//               color: color,
//             ),
//           ),
//         if (!isSingleDivider)
//           Text(
//             title,
//             style: textStyle ?? AppStyles.text14PxRegular,
//           ),
//         if (!isSingleDivider)
//           Expanded(
//             child: Divider(
//               indent: 10.0,
//               endIndent: 20.0,
//               thickness: 1,
//               color: color,
//             ),
//           ),
//       ],
//     );
//   }

//   static String getOperatorCode(String type) {
//     switch (type) {
//       case 'Ncell Topup':
//         return '2';
//       case 'NTC Topup':
//         return '1';

//       default:
//         return '';
//     }
//   }

//   static String formatValidity(String validity) {
//     // Regular expression to extract the number and the unit
//     final regex = RegExp(r'(\d+)(\w+)');
//     final match = regex.firstMatch(validity);

//     if (match != null) {
//       final value = int.parse(match.group(1)!);
//       final unit = match.group(2)!;

//       // Handle pluralization and unit conversion
//       String formattedUnit;
//       switch (unit) {
//         case 'day':
//         case 'days':
//           formattedUnit = value == 1 ? 'Day' : 'Days';
//           break;
//         case 'hour':
//         case 'hours':
//           formattedUnit = value == 1 ? 'Hour' : 'Hours';
//           break;
//         default:
//           throw Exception('Unknown time unit: $unit');
//       }

//       return '$value $formattedUnit';
//     } else {
//       throw Exception('Invalid format');
//     }
//   }

//   static String getTypeWiseOperator(String type) {
//     print('typeeeeeeeee $type');
//     switch (type) {
//       case 'NCELL':
//         return 'Ncell Topup';
//       case 'NTC':
//         return 'NTC Topup';
//       case 'DISHOME':
//         return 'Dishome Topup';
//       default:
//         return '';
//     }
//   }

//   static bool isAccessible(data) {
//     bool isEmpty = true;
//     try {
//       if (data != null) {
//         if (data is int) {
//           return isEmpty;
//         }
//         if (data?.isEmpty) {
//           isEmpty = false;
//         }
//       } else {
//         isEmpty = false;
//       }
//       return isEmpty;
//     } catch (e) {
//       return isEmpty;
//     }
//   }

//   static  Future<bool> isLoggedIn() async {
//     final SharedPreferencesService sharedPref = SharedPreferencesService();

//     var data = await sharedPref.getStringPref('userData');
//     bool logged = await sharedPref.getBoolPref('logged');
//     bool isLoggedIn = data != null && logged;
//     return isLoggedIn;
//   }

//   static getLanguageFromCode(String code) {
//     return code == 'en' ? 'English' : 'Other';
//   }

//   static logout() async {
//     try {
//       var context = navigatorKey.currentContext as BuildContext;
//       DialogManager.showModalDialouge(
//         context,
//         null,
//         true,
//         {
//           'text': 'Logging out...',
//         },
//       );

//       // HttpRepo httpRepo = HttpServices();
//       await SharedPreferencesService().deleteSharedPref('logged');

//       // await httpRepo.post(ApiConstant.logoutUri, {});
//       await SharedPreferencesService().deleteSharedPref('userData');

//       Navigator.of(context).pop();
//       Navigator.of(context).pushAndRemoveUntil(
//         CupertinoPageRoute(
//           builder: (context) => const SocailLoginScreen(),
//         ),
//         (_) => false,
//       );
//     } catch (e) {}
//   }

//   static String getTransactionTitle(String product, String message) {
//     if (product.contains('Ncell')) {
//       return 'Ncell Topup';
//     } else if (product.contains('Nepal Telecom')) {
//       return 'NTC Topup';
//     } else if (message.contains('Gift')) {
//       return 'Gift';
//     } else if (message.contains('Chat')) {
//       return 'Chat';
//     } else {
//       return 'Others';
//     }
//   }

//   static String getTransactionIconTypewise(String product, String message) {
//     if (product.contains('Ncell')) {
//       return Assets.ncell;
//     } else if (product.contains('Nepal Telecom')) {
//       return Assets.ntc;
//     } else if (message.contains('Gift')) {
//       return Assets.gifts;
//     } else if (message.contains('Chat')) {
//       return Assets.chats;
//     } else {
//       return Assets.others;
//     }
//   }

//   static void showExpirationDialog() {
//     var context = navigatorKey.currentContext as BuildContext;
//     DialogManager.customDialog(
//       context,
//       image: Assets.expired,
//       title: AppString.expiredTitle,
//       description: AppString.expiredMessage,
//       isDismissible: false,
//       action: CustomMaterialButton(
//         label: 'Sure, Logout',
//         elevation: 0,
//         radius: 30,
//         onTap: () {
//           Utility.logout();
//           SessionProvider().expireSession();
//         },
//         height: 40,
//       ),
//     );
//   }

//   static Duration getDuration(ToastLength? toastLength) {
//     switch (toastLength) {
//       case ToastLength.short:
//         return const Duration(seconds: 2);
//       case ToastLength.long:
//         return const Duration(seconds: 5);
//       default:
//         return const Duration(seconds: 2);
//     }
//   }

//   static Color getStatusColor(String status) {
//     switch (status.toLowerCase()) {
//       case 'failed':
//         return AppColors.rejectedColor;
//       case 'success':
//         return AppColors.successColor;
//       case 'pending':
//         return AppColors.pendingColor;
//       case 'cash in':
//         return AppColors.successColor;
//       case 'cash out':
//         return AppColors.rejectedColor;
//       default:
//         return AppColors.blackColor;
//     }
//   }

//   static String getStatus(String status) {
//     switch (status.toLowerCase()) {
//       case 'pending':
//         return 'Pending';
//       case 'success':
//         return 'Success';
//       case 'active':
//         return 'Active';

//       case 'cancelled':
//         return 'Cancelled';

//       case 'lost':
//         return 'Lost';
//       case 'cash in':
//         return 'Cash In';
//       case 'cash out':
//         return 'Cash Out';
//       case 'failed':
//         return 'Failed';
//       default:
//         return 'Unknown';
//     }
//   }

//   static getStatusIcon(String status) {
//     switch (status.toLowerCase()) {
//       case 'success':
//       case 'active':
//         return Icons.check_circle;

//       case 'delayed':
//         return Icons.access_time;

//       case 'failed':
//         return Icons.cancel;

//       default:
//         return Icons.help_outline;
//     }
//   }

//   static String formatCustomerNames(List<String> customerNames) {
//     if (customerNames.isEmpty) {
//       return 'N/A';
//     } else if (customerNames.length == 1) {
//       return customerNames[0].split(' ')[0];
//     } else {
//       return '${customerNames[0].split(' ')[0]} & ${customerNames.length - 1} ${customerNames.length > 2 ? 'others' : 'other'}';
//     }
//   }
// }
