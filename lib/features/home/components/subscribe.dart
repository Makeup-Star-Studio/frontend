import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/core/common/text/heading.dart';
import 'package:makeupstarstudio/core/common/text/sub_heading_normal.dart';

class SubscriptionSection extends StatefulWidget {
  const SubscriptionSection({super.key});

  @override
  State<SubscriptionSection> createState() => _SubscriptionSectionState();
}

class _SubscriptionSectionState extends State<SubscriptionSection> {
  final _subscribeKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ResponsiveWidget(
      largeScreen: _buildLargeScreen(screenSize),
      mediumScreen: _buildMediumScreen(screenSize),
      smallScreen: _buildSmallScreen(screenSize),
    );
  }

  // large screen
  Widget _buildLargeScreen(Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BigText(
          text: "subscribe to our list",
          size: 35,
          height: 1.0,
        ),
        const SubHeading(
          text: "join the geet community",
          size: 55,
          height: 1.0,
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.3),
          child: Form(
            key: _subscribeKey,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TextFormInputField(
                    controller: _firstNameController,
                    hintText: 'FIRST NAME',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between form fields
                Expanded(
                  child: TextFormInputField(
                    controller: _lastNameController,
                    hintText: 'LAST NAME',
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between form fields
                Expanded(
                  child: TextFormInputField(
                    controller: _emailController,
                    hintText: 'EMAIL',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20), // Add spacing between form fields
        ModifiedButton(
          press: () {
            if (_subscribeKey.currentState!.validate()) {
              // Process data.
            }
          },
          text: 'SUBSCRIBE',
        ),
      ],
    );
  }

  // medium screen
  Widget _buildMediumScreen(Size screenSize) {
    return _buildLargeScreen(
        screenSize); // Just using large screen layout for medium
  }

  // small screen
  Widget _buildSmallScreen(Size screenSize) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const BigText(
            text: "subscribe to\n our list",
            size: 35,
            height: 1.0,
          ),
          const SubHeading(
            text: "join the geet community",
            size: 70,
            height: 0.5,
          ),
          const SizedBox(height: 40.0),
          Form(
            key: _subscribeKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormInputField(
                  controller: _firstNameController,
                  hintText: 'FIRST NAME',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Add spacing between form fields
                TextFormInputField(
                  controller: _lastNameController,
                  hintText: 'LAST NAME',
                ),
                const SizedBox(height: 20), // Add spacing between form fields
                TextFormInputField(
                  controller: _emailController,
                  hintText: 'EMAIL',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20), // Add spacing between form fields
                ModifiedButton(
                  press: () {
                    if (_subscribeKey.currentState!.validate()) {
                      // Process data.
                    }
                  },
                  text: 'SUBSCRIBE',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
