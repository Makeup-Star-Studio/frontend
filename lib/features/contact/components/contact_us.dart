// import 'package:flutter/material.dart';
// import 'package:makeupstarstudio/config/constants/color.dart';
// import 'package:makeupstarstudio/config/constants/responsive.dart';
// import 'package:makeupstarstudio/core/common/input_field/input_field.dart';
// import 'package:makeupstarstudio/core/common/text/button.dart';
// import 'package:makeupstarstudio/core/common/text/heading.dart';
// import 'package:makeupstarstudio/core/common/text/sub_heading_slanted.dart';
// import 'package:url_launcher/url_launcher.dart';

// class ContactUsSection extends StatefulWidget {
//   const ContactUsSection({super.key});

//   @override
//   State<ContactUsSection> createState() => _ContactUsSectionState();
// }

// class _ContactUsSectionState extends State<ContactUsSection> {
//   final _contactFormKey = GlobalKey<FormState>();
//   final _firstNameController = TextEditingController();
//   final _lastNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _messageController = TextEditingController();

//   bool _isHovering = false;

//   @override
//   Widget build(BuildContext context) {
//     final screenSize = MediaQuery.of(context).size;
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
//       child: Stack(
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const BigText(
//                 text: 'Contact Us',
//                 height: 1.0,
//               ),
//               const SubHeadingSlanted(
//                 text: 'bay area & beyond',
//                 size: 60.0,
//                 smallSize: 50.0,
//                 height: 1.0,
//               ),
//               const SizedBox(height: 20.0),
//               Image.asset(
//                 'assets/images/contact.png',
//                 width: 700,
//                 height: screenSize.height,
//                 fit: BoxFit.cover,
//               ),
//               const SizedBox(height: 20.0),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal:
//                         ResponsiveWidget.isSmallScreen(context) ? 20.0 : 0.0),
//                 child: RichText(
//                   textAlign: TextAlign.center,
//                   text: TextSpan(
//                     style: const TextStyle(
//                       color: AppColorConstant.black,
//                       fontFamily: 'Questrial',
//                       height: 1.75,
//                       fontSize: 18.0,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: "For pricing inquires please include:\n",
//                           style: TextStyle(
//                             fontFamily: 'Cradley',
//                             fontSize: ResponsiveWidget.isSmallScreen(context)
//                                 ? 28.0
//                                 : 24.0,
//                           )),
//                       const TextSpan(text: "- Description of event(s)\n"),
//                       const TextSpan(text: "- Date(s)\n"),
//                       const TextSpan(text: "- Timing to be ready by\n"),
//                       const TextSpan(text: "- Getting Ready Location(s)\n"),
//                       const TextSpan(text: "- Number of Clients\n"),
//                       const TextSpan(
//                           text:
//                               "- Services needed for each Bridal and Non-Bridal\n\n"),
//                       const TextSpan(
//                         text:
//                             "Please fill out the form below & we'll be in touch as soon as possible! You can also email us directly at info@makeupstarstudio.com\n",
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(
//                   height: ResponsiveWidget.isSmallScreen(context) ? 0.0 : 20.0),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                 child: Form(
//                   key: _contactFormKey,
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: TextFormInputField(
//                               controller: _firstNameController,
//                               hintText: 'First Name',
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'required';
//                                 }
//                                 return null;
//                               },
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                               focusBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: TextFormInputField(
//                               controller: _lastNameController,
//                               hintText: 'Last Name',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                               focusBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(height: 10.0),
//                       const SizedBox(height: 10.0),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: TextFormInputField(
//                               controller: _emailController,
//                               hintText: 'Email Address',
//                               validator: (value) {
//                                 if (value == null || value.isEmpty) {
//                                   return 'required';
//                                 }
//                                 return null;
//                               },
//                               keyboardType: TextInputType.emailAddress,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                               focusBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(width: 10.0),
//                           Expanded(
//                             child: TextFormInputField(
//                               controller: _phoneController,
//                               hintText: 'Contact Number',
//                               keyboardType: TextInputType.phone,
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                               focusBorder: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(0.0),
//                                 borderSide: const BorderSide(
//                                   width: 1.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       // const SizedBox(height: 10.0),
//                       const SizedBox(height: 10.0),
//                       TextFormInputField(
//                         controller: _messageController,
//                         hintText: 'Write Your Message',
//                         maxLines: 7,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'required';
//                           }
//                           return null;
//                         },
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(0.0),
//                           borderSide: const BorderSide(
//                             width: 1.0,
//                           ),
//                         ),
//                         focusBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(0.0),
//                           borderSide: const BorderSide(
//                             width: 1.0,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 20.0),
//                       ModifiedButton(
//                         text: 'SEND AN INQUIRY',
//                         press: () {
//                           if (_contactFormKey.currentState!.validate()) {
//                             // // ScaffoldMessenger.of(context).showSnackBar(
//                             // //   const SnackBar(
//                             // //     content: Text('Processing Data'),
//                             // //   ),
//                             // );
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: MouseRegion(
//               onEnter: (_) {
//                 setState(() {
//                   _isHovering = true;
//                 });
//               },
//               onExit: (_) {
//                 setState(() {
//                   _isHovering = false;
//                 });
//               },
//               child: GestureDetector(
//                 onTap: () {
//                   launchWhatsApp();
//                 },
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 200),
//                   width: ResponsiveWidget.isSmallScreen(context) ? 80 : 180,
//                   height: ResponsiveWidget.isSmallScreen(context) ? 50 : 65,
//                   decoration: const BoxDecoration(
//                     color: AppColorConstant.successColor,
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(100.0),
//                       bottomLeft: Radius.circular(100.0),
//                     ),
//                   ),
//                   transform: _isHovering
//                       ? Matrix4.diagonal3Values(1.1, 1.1, 1)
//                       : Matrix4.diagonal3Values(1, 1, 1),
//                   child: Image.asset(
//                     'assets/icons/whatsapp.png', // Change to the actual path of WhatsApp logo
//                     // fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void launchWhatsApp() async {
//     const url = 'https://wa.link/yoty74'; // Replace with your WhatsApp number
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }
