import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/booking/booking_provider.dart';
import 'package:provider/provider.dart';

class AdminBookingViewPage extends StatefulWidget {
  const AdminBookingViewPage({super.key});

  @override
  State<AdminBookingViewPage> createState() => _AdminBookingViewPageState();
}

class _AdminBookingViewPageState extends State<AdminBookingViewPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchAllBookings();
    });
  }

  void _deleteBooking(int index) async {
    final booking =
        Provider.of<BookingProvider>(context, listen: false).booking[index];
    final id = booking.id;

    final shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content: const Text('Are you sure you want to delete this booking?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (shouldDelete) {
      await Provider.of<BookingProvider>(context, listen: false)
          .deleteBooking(id ?? '')
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColorConstant.successColor,
            content: Text('Booking Deleted Successfully'),
          ),
        );
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColorConstant.errorColor,
            content: Text('Failed to delete booking'),
          ),
        );
        print('Error: $e');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM dd, yyyy, hh:mm a');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Bookings'),
        leading: ResponsiveWidget.isSmallScreen(context)
            ? IconButton(
                icon: const Icon(Icons.menu,
                    color: AppColorConstant.adminMenuColor),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : null,
        automaticallyImplyLeading: false,
      ),
      body: Consumer<BookingProvider>(
        builder: (context, bookingProvider, child) {
          if (bookingProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (bookingProvider.booking.isEmpty) {
            return const Center(
              child: Text('No bookings available.'),
            );
          } else {
            final bookings = bookingProvider.booking;
            return ListView(
              children: bookings.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final booking = entry.value;
                final formattedDate =
                    dateFormat.format(booking.eventDate.toLocal());

                return ExpansionTile(
                  title: Text('$index. ${booking.fname} ${booking.lname}'),
                  subtitle: Text(
                    'Event Date: $formattedDate - Location: ${booking.eventLocation}',
                  ),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.email),
                            title: Text('Email: ${booking.email}'),
                            subtitle: Text('Phone: ${booking.phoneNumber}'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.event),
                            title: Text(
                                'Event Type: ${booking.eventType.join(', ')}'),
                            subtitle: Text(
                                'Service Type: ${booking.serviceType.join(', ')}'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.people),
                            title: Text(
                                'People doing Makeup: ${booking.totalPeopleMakeup}'),
                            subtitle: Text(
                                'People doing Hair: ${booking.totalPeopleHair}'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.brush),
                            title: Text(
                                'People doing Henna: ${booking.totalPeopleHenna}'),
                            subtitle: Text(
                                'People doing Draping: ${booking.totalPeopleDraping}'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.info),
                            subtitle: Text(
                                'Where did you hear about us: ${booking.howDidYouHear}'),
                            title: Text(
                                'Premium Service: ${booking.premiumService}'),
                          ),
                          ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                                'Pricing: \$${booking.servicePricing.join(', ')}'),
                            subtitle: Text(
                                'Message: ${booking.addedQuestionsOrInfo ?? 'N/A'}'),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              // color: Colors.grey[150],
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.grey[300],
                              ),
                              width: 60,
                              child: IconButton(
                                hoverColor: Colors.transparent,
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                iconSize: 30,
                                onPressed: () => _deleteBooking(entry.key),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}
