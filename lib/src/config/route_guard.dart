import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/provider/auth/check_login_provider.dart';
import 'package:provider/provider.dart';

class RouteGuard extends StatelessWidget {
  final WidgetBuilder builder;
  final String redirectTo;

  const RouteGuard({required this.builder, required this.redirectTo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = context.read<CheckLoginProvider>().isLoggedIn;

    if (isLoggedIn) {
      return builder(context);
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacementNamed(redirectTo);
      });
      return const SizedBox.shrink();
    }
  }
}
