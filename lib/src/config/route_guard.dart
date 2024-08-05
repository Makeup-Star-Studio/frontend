// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/src/provider/auth/check_login_provider.dart';
// import 'package:provider/provider.dart';

// class RouteGuard extends StatelessWidget {
//   final WidgetBuilder builder;
//   final String redirectTo;

//   const RouteGuard({required this.builder, required this.redirectTo, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isLoggedIn = context.read<CheckLoginProvider>().isLoggedIn;

//     if (isLoggedIn) {
//       return builder(context);
//     } else {
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         Navigator.of(context).pushReplacementNamed(redirectTo);
//       });
//       return const SizedBox.shrink();
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';

class RouteGuard extends StatelessWidget {
  final WidgetBuilder builder;
  final String redirectTo;

  const RouteGuard({
    super.key,
    required this.builder,
    required this.redirectTo,
  });

  Future<bool> isAuthenticated() async {
    final SharedPreferencesService sharedPref = SharedPreferencesService();
    bool logged = await sharedPref.getBoolPref('logged');
    return logged;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data == true) {
          return builder(context);
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacementNamed(context, redirectTo);
          });
          return Container();
        }
      },
    );
  }
}
