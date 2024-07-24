import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/features/admin/screens/main/admin_main_page.dart';
import 'package:makeupstarstudio/src/provider/auth/login_provider.dart';
import 'package:makeupstarstudio/src/services/shared_pref.dart';
import 'package:provider/provider.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final SharedPreferencesService _sharedPrefs = SharedPreferencesService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool showCrossIcon = false;
  final formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  late LoginProvider loginState;

  @override
  void initState() {
    super.initState();
    loginState = context.read<LoginProvider>();

    _usernameController.addListener(() {
      setState(() {
        showCrossIcon = _usernameController.text.length >= 2;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        initialData: const [],
        future: Future.wait(
          [
            _sharedPrefs.getStringPref('settings'),
            // _sharedPrefs.getStringPref('userData'),
            _sharedPrefs.getStringPref('loggedUsers')
          ],
        ),
        builder: (context, AsyncSnapshot snapshot) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.all(AppColorConstant.defaultPadding * 4),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/logo-black.png', height: 100),
                    const SizedBox(height: 20),
                    TextFormInputField(
                      textAlign: TextAlign.left,
                      controller: _usernameController,
                      hintText: 'Username',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          width: 1.0,
                        ),
                      ),
                      focusBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0.0),
                        borderSide: const BorderSide(
                          width: 1.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      cursorColor: AppColorConstant.black.withOpacity(0.6),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: TextStyle(
                          color: ResponsiveWidget.isSmallScreen(context)
                              ? AppColorConstant.black
                              : AppColorConstant.black.withOpacity(0.6),
                          fontSize:
                              ResponsiveWidget.isSmallScreen(context) ? 16 : 14,
                          fontWeight: ResponsiveWidget.isSmallScreen(context)
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                        hoverColor: Colors.transparent,
                        filled: true,
                        fillColor: AppColorConstant.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0.0),
                          borderSide: const BorderSide(
                            width: 1.0,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        style: ButtonStyle(
                          overlayColor:
                              WidgetStateProperty.all(Colors.transparent),
                        ),
                        onPressed: () {
                          // Implement your register functionality here
                          Navigator.of(context).pop();
                          // _showForgotPassword(context);
                        },
                        child: const BodyText(text: "Forgot Password?"),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ModifiedButton(
                      text: 'Sign In',
                      color: AppColorConstant.adminPrimaryColor,
                      textColor: AppColorConstant.white,
                      press: () {
                        if (formKey.currentState!.validate()) {
                          loginState.loginUser(
                            context,
                            _usernameController.text,
                            _passwordController.text,
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
