import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/src/provider/admin/user_provider.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:provider/provider.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _changePwdKey = GlobalKey<FormState>();

  bool _isOldPasswordVisible = false;
  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  final bool _isLoading = false;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _changePwdKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPasswordField(
              label: 'Old Password',
              controller: _oldPasswordController,
              isVisible: _isOldPasswordVisible,
              onVisibilityToggle: () => setState(() {
                _isOldPasswordVisible = !_isOldPasswordVisible;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'New Password',
              controller: _newPasswordController,
              isVisible: _isNewPasswordVisible,
              onVisibilityToggle: () => setState(() {
                _isNewPasswordVisible = !_isNewPasswordVisible;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (value.length < 8) {
                  return 'Password must be at least 8 characters long';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            _buildPasswordField(
              label: 'Confirm New Password',
              controller: _confirmPasswordController,
              isVisible: _isConfirmPasswordVisible,
              onVisibilityToggle: () => setState(() {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              }),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                if (value != _newPasswordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Center(
              child: _isLoading
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColorConstant.adminPrimaryColor),
                    )
                  : ModifiedButton(
                      color: AppColorConstant.adminPrimaryColor,
                      textColor: AppColorConstant.white,
                      press: () async {
                        if (_changePwdKey.currentState!.validate() ?? false) {
                          _updatePassword();
                        }
                      },
                      text: 'Change Password',
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.user?.data.user.id;

    if (userId != null) {
      await loginProvider.updatePassword(
        id: userId,
        currentPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
        newPasswordConfirm: _confirmPasswordController.text,
      );

      // show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password updated successfully',
              style: TextStyle(color: AppColorConstant.white)),
          backgroundColor: AppColorConstant.successColor,
        ),
      );
      // show error message
      // await _fetchUserInfo();
    } else {
      print('User ID is null. Unable to change password.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update password',
              style: TextStyle(color: AppColorConstant.white)),
          backgroundColor: AppColorConstant.errorColor,
        ),
      );
    }
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback onVisibilityToggle,
    required FormFieldValidator<String> validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyText(text: label),
        TextFormField(
          controller: controller,
          obscureText: !isVisible,
          cursorColor: AppColorConstant.black.withOpacity(0.6),
          validator: validator,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            hintStyle: TextStyle(
              color: ResponsiveWidget.isSmallScreen(context)
                  ? AppColorConstant.black
                  : AppColorConstant.black.withOpacity(0.6),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 16,
              fontWeight: FontWeight.normal,
            ),
            hoverColor: Colors.transparent,
            filled: true,
            fillColor: AppColorConstant.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(0.0),
              borderSide: const BorderSide(width: 1.0),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: onVisibilityToggle,
            ),
          ),
        ),
      ],
    );
  }
}
