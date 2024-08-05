import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/features/admin/screens/settings/components.dart/change_password.dart';
import 'package:makeupstarstudio/features/admin/screens/settings/components.dart/edit_profile.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool showEditProfile = true;

  void toggleView() {
    setState(() {
      showEditProfile = !showEditProfile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false,
        leading: ResponsiveWidget.isSmallScreen(context)
            ? IconButton(
                icon: const Icon(Icons.menu,
                    color: AppColorConstant.adminMenuColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
        actions: [
          TextButton(
            onPressed: toggleView,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.hovered)) {
                    return AppColorConstant.adminMenuColor
                        .withOpacity(0.7); // Change to desired hover color
                  }
                  return AppColorConstant.adminMenuColor; // Default color
                },
              ),
            ),
            child: Text(
              showEditProfile ? 'Change Password' : 'Add Profile',
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: showEditProfile
          ? const EditProfileScreen()
          : const ChangePasswordScreen(),
    );
  }
}
