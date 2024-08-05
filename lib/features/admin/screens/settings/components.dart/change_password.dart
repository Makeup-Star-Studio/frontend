import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final changePwdKey = GlobalKey<FormState>();

    bool isPasswordVisible = false;
    final TextEditingController oldPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: changePwdKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BodyText(text: 'Old Password'),
            TextFormField(
              controller: oldPasswordController,
              obscureText: !isPasswordVisible,
              cursorColor: AppColorConstant.black.withOpacity(0.6),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter Old Password',
                hintStyle: TextStyle(
                  color: ResponsiveWidget.isSmallScreen(context)
                      ? AppColorConstant.black
                      : AppColorConstant.black.withOpacity(0.6),
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
                  fontWeight: ResponsiveWidget.isSmallScreen(context)
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                hoverColor: Colors.transparent,
                filled: true,
                fillColor: AppColorConstant.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // ignore: dead_code
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const BodyText(text: 'New Password'),
            TextFormField(
              controller: newPasswordController,
              obscureText: !isPasswordVisible,
              cursorColor: AppColorConstant.black.withOpacity(0.6),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Enter New Password',
                hintStyle: TextStyle(
                  color: ResponsiveWidget.isSmallScreen(context)
                      ? AppColorConstant.black
                      : AppColorConstant.black.withOpacity(0.6),
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
                  fontWeight: ResponsiveWidget.isSmallScreen(context)
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                hoverColor: Colors.transparent,
                filled: true,
                fillColor: AppColorConstant.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const BodyText(text: 'Confirm New Password'),
            TextFormField(
              controller: confirmPasswordController,
              obscureText: !isPasswordVisible,
              cursorColor: AppColorConstant.black.withOpacity(0.6),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'required';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'Confirm New Password',
                hintStyle: TextStyle(
                  color: ResponsiveWidget.isSmallScreen(context)
                      ? AppColorConstant.black
                      : AppColorConstant.black.withOpacity(0.6),
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
                  fontWeight: ResponsiveWidget.isSmallScreen(context)
                      ? FontWeight.w600
                      : FontWeight.normal,
                ),
                hoverColor: Colors.transparent,
                filled: true,
                fillColor: AppColorConstant.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  borderSide: const BorderSide(width: 1.0),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ModifiedButton(
                color: AppColorConstant.adminPrimaryColor,
                textColor: AppColorConstant.white,
                press: () {
                  // Change password button action
                },
                text: 'Change Password',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
