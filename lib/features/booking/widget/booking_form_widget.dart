import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/input_field/booking_input_field.dart';
import 'package:makeupstarstudio/core/common/input_field/checkbox.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';
import 'package:makeupstarstudio/core/common/text/button.dart';
import 'package:makeupstarstudio/features/booking/widget/dialog_box.dart';
import 'package:makeupstarstudio/features/booking/widget/validator.dart';
import 'package:makeupstarstudio/src/model/booking_model.dart';
import 'package:makeupstarstudio/src/provider/booking/booking_provider.dart';
import 'package:provider/provider.dart';

class BookingFormWidget extends StatefulWidget {
  const BookingFormWidget({super.key});

  @override
  State<BookingFormWidget> createState() => _BookingFormWidgetState();
}

class _BookingFormWidgetState extends State<BookingFormWidget> {
  bool showPricing = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  // final TextEditingController _socialMediaController = TextEditingController();
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
  List<String> selectedServiceTypes = [];
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
  void initState() {
    super.initState();
  }

  late Booking _booking;
 void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    _formKey.currentState!.save();

    // Update the booking object with the formatted date
    _booking = Booking(
      fname: _firstNameController.text,
      lname: _lastNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      // socialMedia: _socialMediaController.text,
      eventDate: selectedEventDate, // Use the formatted event date
      eventType: selectedEventTypes,
      serviceType: selectedServiceTypes,
      eventLocation: _locationController.text,
      totalPeopleMakeup: int.tryParse(_makeupController.text) ?? 0,
      totalPeopleHair: int.tryParse(_hairController.text) ?? 0,
      totalPeopleHenna: int.tryParse(_hennaController.text) ?? 0,
      totalPeopleDraping: int.tryParse(_drapingController.text) ?? 0,
      howDidYouHear: selectedSourceOptions,
      premiumService: selectedArtistOptions,
      servicePricing: selectedPricingTypes,
      addedQuestionsOrInfo: _messageController.text,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    try {
      await Provider.of<BookingProvider>(context, listen: false)
          .postBooking(_booking);
      _clearForm();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const BookingDialogBox();
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Something Went Wrong'),
            content: const Text('Please try again later!'),
            backgroundColor: AppColorConstant.errorColor,
            actions: <Widget>[
              TextButton(
                child: const BodyText(text:'OK', color: AppColorConstant.black,),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}


  void _clearForm() {
    _formKey.currentState!.reset();
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _phoneController.clear();
    // _socialMediaController.clear();
    _eventDateController.clear();
    _eventTypeController.clear();
    _serviceTypeController.clear();
    _locationController.clear();
    _makeupController.clear();
    _hairController.clear();
    _hennaController.clear();
    _drapingController.clear();
    _sourceController.clear();
    _artistController.clear();
    _pricingController.clear();
    _messageController.clear();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    // _socialMediaController.dispose();
    _eventDateController.dispose();
    _eventTypeController.dispose();
    _serviceTypeController.dispose();
    _locationController.dispose();
    _makeupController.dispose();
    _hairController.dispose();
    _hennaController.dispose();
    _drapingController.dispose();
    _sourceController.dispose();
    _artistController.dispose();
    _pricingController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                labelText: 'First Name:',
                controller: _firstNameController,
                hintText: 'Your first name here'),
            const SizedBox(height: 20),
            BookingInputField(
                labelText: 'Last Name:',
                controller: _lastNameController,
                hintText: 'Your last name here'),
            const SizedBox(height: 20),
            // email address
            RichText(
              textAlign: TextAlign.start,
              text: const TextSpan(
                style: TextStyle(
                  color: AppColorConstant.black,
                  fontFamily: 'Questrial',
                  height: 1.75,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                children: [
                  TextSpan(
                    text: 'Email Address:',
                  ),
                  TextSpan(
                    text: ' *',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: AppColorConstant.errorColor,
                    ),
                  ),
                ],
              ),
            ),
            TextFormField(
              cursorColor: AppColorConstant.black.withOpacity(0.6),
              textAlign: TextAlign.start,
              controller: _emailController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Email is required';
                }
                // Regular expression for validating email
                final emailRegex = RegExp(
                  r'^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$',
                );
                if (!emailRegex.hasMatch(value)) {
                  return 'Invalid email';
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@.]')),
                LowercaseTextFormatter(), // Custom formatter to convert text to lowercase
              ],
              decoration: InputDecoration(
                hoverColor: Colors.transparent,
                filled: true,
                fillColor: AppColorConstant.white,
                hintText: 'Example: myemail@gmail.com',
                hintStyle: TextStyle(
                  fontFamily: 'Questrial',
                  color: AppColorConstant.black.withOpacity(0.6),
                  fontSize: ResponsiveWidget.isSmallScreen(context) ? 14 : 16,
                  fontWeight: FontWeight.normal,
                ),
                border: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColorConstant.subHeadingColor),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: AppColorConstant.subHeadingColor),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),
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
            // // social media
            // BookingInputField(
            //   labelText: 'Instagram/Facebook/SocialMedia',
            //   controller: _socialMediaController,
            //   hintText:
            //       'Note: provide your social media user name, E.g. Instagram: @makeupstarstudio',
            //   isTextRequired: false,
            // ),
            // const SizedBox(height: 20),
            // event date
            BookingInputField(
              labelText:
                  "Event Date (it's showing current date and time, please select your date and time)",
              controller: _eventDateController,
              hintText: 'MM/DD/YYYY HH:MM AM/PM',
              keyboardType: TextInputType.datetime,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
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
                      // date format should be 'MM/dd/yyyy hh:mm a'
                      text: DateFormat('MM/dd/yyyy hh:mm a', 'en_US').format(
                        selectedEventDate.toLocal(),
                      ),

                      color: AppColorConstant.black,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColorConstant.black,
                  ),
                ],
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
              selectedTypes: selectedServiceTypes,
              onChanged: (selectedTypes) {
                setState(() {
                  selectedServiceTypes = selectedTypes;
                });
              },
            ),
            const SizedBox(height: 20),
            // location
            BookingInputField(
              labelText: 'Location of event:',
              controller: _locationController,
              hintText:
                  'E.g. 60 Descanso Dr, San Jose, CA 95134, United States',
            ),
            const SizedBox(height: 20),
            // makeup
            BookingInputField(
              labelText: 'How many people will be needing makeup?',
              controller: _makeupController,
              hintText: 'Note: Please enter in digit format. For ex: 1',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // hair
            BookingInputField(
              labelText: 'How many people will be needing hair styling?',
              controller: _hairController,
              hintText: 'Note: Please enter in digit format. For ex: 1',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // henna
            BookingInputField(
              labelText: 'How many people will be needing henna?',
              controller: _hennaController,
              hintText: 'Note: Please enter in digit format. For ex: 1',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            // draping
            BookingInputField(
              labelText: 'How many people will be needing draping?',
              controller: _drapingController,
              keyboardType: TextInputType.number,
              hintText: 'Note: Please enter in digit format. For ex: 1',
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
                  showPricing =
                      selectedArtistOptions == "Yes, Exclusive with Geet" ||
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
              hintText: 'Any extra questions or information, you can add here?',
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  color: AppColorConstant.errorColor,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                  color: AppColorConstant.errorColor,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // submit button
            Align(
                alignment: Alignment.center,
                child: ModifiedButton(
                    text: 'BOOK AN APPOINTMENT', press: _submitForm)),
          ],
        ),
      ),
    );
  }
}
