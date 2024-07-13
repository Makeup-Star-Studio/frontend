import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.circular(AppColorConstant.defaultPadding),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!ResponsiveWidget.isLargeScreen(context))
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          if (!ResponsiveWidget.isSmallScreen(context))
            Text(
              "Overview",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          const SizedBox(width: 20.0),
          const Observation(),
          if (!ResponsiveWidget.isSmallScreen(context))
            Spacer(flex: ResponsiveWidget.isLargeScreen(context) ? 2 : 1),
          const ProfileCard(),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Observation                            */

class Observation extends StatefulWidget {
  const Observation({super.key});

  @override
  State<Observation> createState() => _ObservationState();
}

class _ObservationState extends State<Observation> {
  final List<String> observationOptions = [
    "Today",
    "Last 7 Days",
    "Last 30 Days",
  ];
  String selectedObservedOption = "Last 7 Days";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: DropdownButton(
        // padding: EdgeInsets.only(top: 8),
        // isExpanded: true,
        icon: const Icon(Icons.keyboard_arrow_down),
        elevation: 0,
        underline: const SizedBox(),
        value: selectedObservedOption,
        items: observationOptions.map((String option) {
          return DropdownMenuItem(
            value: option,
            child: Text(option,
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                )),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            selectedObservedOption = newValue.toString();
          });
        },
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Profile Card                            */

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final bool _isLoggedIn = false; // Variable to simulate login status
  bool _isLogoutVisible = false;

  void _toggleLogoutVisibility() {
    setState(() {
      _isLogoutVisible = !_isLogoutVisible;
    });
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const LoginDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppColorConstant.defaultPadding,
      ),
      decoration: BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _isLoggedIn
                  ? const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    )
                  : const Icon(Icons.person, size: 40, color: Colors.black54),
              const SizedBox(width: AppColorConstant.defaultPadding),
              InkWell(
                mouseCursor: SystemMouseCursors.click,
                onTap: () {
                  if (!_isLoggedIn) _showLoginDialog(context);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isLoggedIn ? "Geet" : "Login | Register",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    if (_isLoggedIn)
                      Text(
                        "Admin",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: Colors.black38, fontSize: 12.0),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: AppColorConstant.defaultPadding / 2),
              if (_isLoggedIn)
                IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down),
                  onPressed: _toggleLogoutVisibility,
                ),
            ],
          ),
          if (_isLogoutVisible && _isLoggedIn)
            Positioned(
              top: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  // Implement your logout functionality here
                  // print("Logout tapped");
                },
                child: Container(
                  width: 120,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(0.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: const Text(
                    "Logout",
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColorConstant.black,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Login Dialog                            */

class LoginDialog extends StatefulWidget {
  const LoginDialog({super.key});

  @override
  State<LoginDialog> createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final _loginKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return const RegisterDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppColorConstant.defaultPadding * 4),
        child: Form(
          key: _loginKey,
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
              const SizedBox(height: 20),
              ModifiedButton(
                text: 'Sign In',
                color: AppColorConstant.adminPrimaryColor,
                textColor: AppColorConstant.white,
                press: () {
                  if (_loginKey.currentState!.validate()) {
                    // Implement your login functionality here
                    Navigator.of(context).pop();
                  }
                },
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
                onPressed: () {
                  // Implement your register functionality here
                  Navigator.of(context).pop();
                  _showRegisterDialog(context);
                },
                child: const BodyText(text: "Don't have an account? Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            //Register Dialog                            */

//Register Dialog
class RegisterDialog extends StatefulWidget {
  const RegisterDialog({super.key});

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  final _registerKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
        child: Form(
          key: _registerKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/logo-black.png', height: 100),
                const SizedBox(height: 20),
                TextFormInputField(
                  textAlign: TextAlign.left,
                  controller: _fnameController,
                  hintText: 'First Name',
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
                TextFormInputField(
                  textAlign: TextAlign.left,
                  controller: _lnameController,
                  hintText: 'Last Name',
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
                TextFormInputField(
                  textAlign: TextAlign.left,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
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
                TextFormInputField(
                  textAlign: TextAlign.left,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  hintText: 'Phone Number',
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
                const SizedBox(height: 20),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  cursorColor: AppColorConstant.black.withOpacity(0.6),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
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
                        _isConfirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ModifiedButton(
                  text: 'Register Now',
                  color: AppColorConstant.adminPrimaryColor,
                  textColor: AppColorConstant.white,
                  press: () {
                    if (_registerKey.currentState!.validate()) {
                      // Implement your registration functionality here
                    }
                  },
                ),
                TextButton(
                  style: ButtonStyle(
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Show login dialog again
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const LoginDialog();
                      },
                    );
                  },
                  child: const BodyText(text: "Already have an account? Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
