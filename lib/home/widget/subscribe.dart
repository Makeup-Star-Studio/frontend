import 'package:flutter/material.dart';
import 'package:makeupstarstudio/common/button.dart';
import 'package:makeupstarstudio/common/text/heading.dart';
import 'package:makeupstarstudio/common/text/sub_heading_normal.dart';
import 'package:makeupstarstudio/theme/color.dart';

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
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _firstNameController,
                    decoration: const InputDecoration(
                      hoverColor: Colors.transparent,
                      filled: true,
                      fillColor: AppColorConstant.white,
                      hintText: 'FIRST NAME',
                      hintStyle: TextStyle(
                        color: AppColorConstant.black,
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                    ),
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
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _lastNameController,
                    decoration: const InputDecoration(
                      hoverColor: Colors.transparent,
                      filled: true,
                      fillColor: AppColorConstant.white,
                      hintText: 'LAST NAME',
                      hintStyle: TextStyle(
                        color: AppColorConstant.black,
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Add spacing between form fields
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hoverColor: Colors.transparent,
                      filled: true,
                      fillColor: AppColorConstant.white,
                      hintText: 'EMAIL',
                      hintStyle: TextStyle(
                        color: AppColorConstant.black,
                        fontSize: 14.0,
                      ),
                      border: InputBorder.none,
                    ),
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
