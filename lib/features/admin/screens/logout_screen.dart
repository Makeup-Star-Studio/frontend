import 'package:flutter/material.dart';
import 'package:makeupstarstudio/src/utils/utility.dart';

Future<void> showLogoutConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    barrierDismissible: false, // User must tap a button to close the dialog
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(Icons.error_outline, color: Colors.red), // Replace with Assets.sadLogout
            SizedBox(width: 16),
            Text('Logout'),
          ],
        ),
        content: Text('Are you sure you want to logout?'), // Replace with AppString.sureLogout
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              Utility.logout(); // Perform the logout
            },
            child: Text('Yes'), // Replace with a localized string if needed
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog without logging out
            },
            child: Text('No'), // Replace with a localized string if needed
          ),
        ],
      );
    },
  );
}