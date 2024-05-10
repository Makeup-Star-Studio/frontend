import 'package:flutter/material.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const BigText(
          text: "subscribe to our list",
          size: 35,
        ),
        const SubHeading(
          text: "join the geet community",
          size: 55,
        ),
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
}
