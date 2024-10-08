import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/utils/utility.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Row(
          children: <Widget>[
            Icon(Icons.error_outline, color: Colors.red),
            SizedBox(width: 16),
            Text('Logout'),
          ],
        ),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await Utility.logout();
            },
            child: const Text('Yes'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
        ],
      );
    },
  );
}
