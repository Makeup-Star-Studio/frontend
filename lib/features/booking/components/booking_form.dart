import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/booking_input_field.dart';
import 'package:makeupstarstudio/core/common/input_field/checkbox.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingFormSection extends StatefulWidget {
  const BookingFormSection({super.key});

  @override
  State<BookingFormSection> createState() => _BookingFormSectionState();
}

class _BookingFormSectionState extends State<BookingFormSection> {
  bool showPricing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _socialMediaController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _eventTypeController = TextEditingController();
  final TextEditingController _serviceTypeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _makeupController = TextEditingController();
  final TextEditingController _hairController = TextEditingController();
  final TextEditingController _hennaController = TextEditingController();
  final TextEditingController _drapingController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _pricingController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  DateTime? date = DateTime.now();
  DateTime selectedEventDate = DateTime.now();

  TimeOfDay? selectedTime =
      TimeOfDay.now(); // Add this variable for the selected time

  List<String> selectedEventTypes = [];
  List<String> selectedPricingTypes = [];

  final List<String> sourceOptions = [
    "Personal Website",
    "Google",
    "Facebook",
    "Instagram",
    "The Knot",
    "Yelp",
    "Wedding Wire",
    "Vendor Referral",
    "Client Referral",
    "Other",
    "Unknown"
  ];
  String selectedSourceOptions = "Personal Website";

  final List<String> artistOptions = [
    "Yes, Exclusive with Geet",
    "No, Team Geet (Senior Artists) is perfect",
    "NA / No Preference",
  ];
  String selectedArtistOptions = "Yes, Exclusive with Geet";

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ResponsiveWidget.isSmallScreen(context)
              ? 20
              : screenSize.width * 0.15),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const BodyText(
            text: 'For bookings & inquiries, contact:',
            fontWeight: FontWeight.w600,
            smallSize: 20.0,
            mediumSize: 20.0,
            size: 22.0,
          ),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              _launchEmail('info@makeupstarstudio.com');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: 'Email: ',
                  ),
                  TextSpan(
                    text: 'info@makeupstarstudio.com',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColorConstant.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            hoverColor: Colors.transparent,
            onTap: () {
              _launchURL('https://maps.app.goo.gl/Yj5N8eYKiPm6udRm7');
            },
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                    text: 'Location: ',
                  ),
                  TextSpan(
                    text: '60 Descanso Dr, San Jose, CA 95134, United States',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColorConstant.secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            color: AppColorConstant.white,
            // margin: EdgeInsets.symmetric(horizontal: screenSize.width * 0.15),
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // full name
                  BookingInputField(
                      labelText: 'Full Name:',
                      controller: _fullNameController,
                      hintText: 'Your name here'),
                  const SizedBox(height: 20),
                  // email address
                  BookingInputField(
                    labelText: 'Email:',
                    controller: _emailController,
                    hintText: 'E.g. myemail@emial.com',
                  ),
                  const SizedBox(height: 20),
                  // phone number
                  BookingInputField(
                    labelText: 'Phone:',
                    controller: _phoneController,
                    hintText:
                        'with country code ex: +1 USA/CAN, +44 UK, +61 AUS, +91 INDIA)',
                  ),
                  const SizedBox(height: 20),
                  // social media
                  BookingInputField(
                    labelText: 'Instagram/Facebook/SocialMedia',
                    controller: _socialMediaController,
                    hintText: 'E.g. Instagram: @makeupstarstudio',
                    isTextRequired: false,
                  ),
                  const SizedBox(height: 20),
                  // event date
                  BookingInputField(
                    labelText:
                        "Event Date (it's showing current date and time, please select your date and time)",
                    controller: _eventDateController,
                    hintText: 'MM/DD/YY HH:MM',
                    isFormFieldRequired: false,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: AppColorConstant.black,
                        ),
                      ),
                    ),
                    child: ListTile(
                      leading: TextButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: selectedEventDate,
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3000),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light(),
                                child: child!,
                              );
                            },
                          );
                          if (newDate != null) {
                            // ignore: use_build_context_synchronously
                            TimeOfDay? newTime = await showTimePicker(
                              // ignore: use_build_context_synchronously
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(selectedEventDate),
                              builder: (BuildContext context, Widget? child) {
                                return Theme(
                                  data: ThemeData.light(),
                                  child: child!,
                                );
                              },
                            );
                            if (newTime != null) {
                              setState(() {
                                selectedEventDate = DateTime(
                                  newDate.year,
                                  newDate.month,
                                  newDate.day,
                                  newTime.hour,
                                  newTime.minute,
                                );
                              });
                            }
                          }
                        },
                        child: BodyText(
                          text: DateFormat('M/d/y HH:mm', 'en_US')
                              .format(selectedEventDate.toLocal()),
                          color: AppColorConstant.black.withOpacity(0.6),
                        ),
                      ),
                      trailing: const Icon(
                        Icons.calendar_month_outlined,
                        color: AppColorConstant.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // event type
                  BookingInputField(
                    labelText: 'Event Type (select all that apply)',
                    controller: _eventTypeController,
                    hintText: 'E.g. Wedding, Photoshoot, etc',
                    isFormFieldRequired: false,
                  ),
                  EventTypeCheckboxGroup(
                    eventTypes: const [
                      'Wedding',
                      'Pre Wedding',
                      'Sangeet',
                      'Mehendi',
                      'Reception',
                      'Engagement',
                      'Maternity',
                      'Professional Shoot',
                      'Anniversary',
                      'Baby Shower',
                      'Birthday',
                      'Festival',
                      'Other',
                    ],
                    selectedTypes: selectedEventTypes,
                    onChanged: (selectedTypes) {
                      setState(() {
                        selectedEventTypes = selectedTypes;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  BookingInputField(
                    labelText: 'Service Type (select all that apply)',
                    controller: _serviceTypeController,
                    hintText: 'E.g. Bridal Makeup, Hair, etc',
                    isFormFieldRequired: false,
                  ),
                  EventTypeCheckboxGroup(
                    eventTypes: const [
                      'Bridal Makeup',
                      'Bridal Hair Styling',
                      'Makeup',
                      'Hair Styling',
                      'Bridal Henna',
                      'Henna',
                      'Draping - South Indian Saree',
                      'Draping - Regular Saree',
                      'Draping - Dupatta, Veil',
                      'Just want Pricing',
                      'Other',
                    ],
                    selectedTypes: selectedEventTypes,
                    onChanged: (selectedTypes) {
                      setState(() {
                        selectedEventTypes = selectedTypes;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // location
                  BookingInputField(
                    labelText: 'Location of event:',
                    controller: _locationController,
                    hintText: 'E.g. City, State, Country',
                  ),
                  const SizedBox(height: 20),
                  // makeup
                  BookingInputField(
                    labelText: 'How many people will be needing makeup?',
                    controller: _makeupController,
                    hintText: 'E.g. self, 1, 2, 3, etc',
                  ),
                  const SizedBox(height: 20),
                  // hair
                  BookingInputField(
                    labelText: 'How many people will be needing hair styling?',
                    controller: _hairController,
                    hintText: 'E.g. self, 1, 2, none, etc',
                  ),
                  const SizedBox(height: 20),
                  // henna
                  BookingInputField(
                    labelText: 'How many people will be needing henna?',
                    controller: _hennaController,
                    hintText: 'E.g. self, 1, 2, none, etc',
                  ),
                  const SizedBox(height: 20),
                  // draping
                  BookingInputField(
                    labelText: 'How many people will be needing draping?',
                    controller: _drapingController,
                    hintText: 'E.g. self, 1, 2, none, etc',
                  ),
                  const SizedBox(height: 20),
                  // how did you hear about us
                  BookingInputField(
                    labelText: 'How did you hear about us? (Select an option)',
                    controller: _sourceController,
                    hintText: 'E.g. Instagram, Facebook, Google, etc',
                    isFormFieldRequired: false,
                    isTextRequired: false,
                  ),
                  DropdownButton(
                    // padding: EdgeInsets.only(top: 8),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: AppColorConstant.black,
                    ),
                    value: selectedSourceOptions,
                    items: sourceOptions.map((String option) {
                      return DropdownMenuItem(
                        value: option,
                        child: BodyText(text: option),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedSourceOptions = newValue.toString();
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // artist preference
                  BookingInputField(
                    labelText:
                        'Are you looking for the exclusive premium service? (Select an option)',
                    controller: _artistController,
                    hintText: 'E.g. Yes, No',
                    isFormFieldRequired: false,
                  ),
                  DropdownButton(
                    // padding: EdgeInsets.only(top: 8),
                    isExpanded: true,
                    underline: Container(
                      height: 1,
                      color: AppColorConstant.black,
                    ),
                    value: selectedArtistOptions,
                    items: artistOptions.map((String option) {
                      return DropdownMenuItem(
                        value: option,
                        child: BodyText(text: option),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedArtistOptions = newValue.toString();
                        showPricing = selectedArtistOptions ==
                                "Yes, Exclusive with Geet" ||
                            selectedArtistOptions ==
                                "No, Team Geet (Senior Artists) is perfect" ||
                            selectedArtistOptions == "NA / No Preference";
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  // pricing
                  Visibility(
                    visible: showPricing,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BookingInputField(
                          labelText:
                              'What are you willing to pay for that perfect look(per event)?',
                          controller: _pricingController,
                          hintText: 'E.g. Bridal Makeup, Hair, etc',
                          isFormFieldRequired: false,
                        ),
                        EventTypeCheckboxGroup(
                          eventTypes: const [
                            "\$500 - \$850",
                            "\$850 - \$1500",
                            "\$1500 - \$2500",
                            "\$2500 - \$3500",
                            "\$3500 plus",
                          ],
                          selectedTypes: selectedPricingTypes,
                          onChanged: (selectedTypes) {
                            setState(() {
                              selectedPricingTypes = selectedTypes;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  // message
                  BookingInputField(
                    maxLines: 5,
                    labelText:
                        "Let's chat! Feel free to include any details regarding the services you're interested in, the event or occasion, location, and of course, any questions you might have for our team. We look forward to working with you!\n",
                    controller: _messageController,
                    hintText: 'What do I need to know about the project?',
                    isTextRequired: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: const BorderSide(
                        color: AppColorConstant.subHeadingColor,
                      ),
                    ),
                    focusBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                      borderSide: const BorderSide(
                        color: AppColorConstant.subHeadingColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // submit button
                  Align(
                      alignment: Alignment.center,
                      child: ModifiedButton(
                          text: 'BOOK AN APPOINTMENT', press: () {}))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    final String url = emailLaunchUri.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      throw 'Could not launch $url';
    }
  }
}
