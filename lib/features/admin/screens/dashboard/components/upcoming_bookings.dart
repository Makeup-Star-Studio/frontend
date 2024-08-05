import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/model/booking_model.dart';
import 'package:makeupstarstudio/src/provider/booking/booking_provider.dart';
import 'package:provider/provider.dart';

import 'booking_info_card.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({super.key});

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  late DateTime _selectedDate;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _calculateWeekDates();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookingProvider>(context, listen: false).fetchAllBookings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(
      builder: (context, bookingProvider, child) {
        if (bookingProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (bookingProvider.bookings.isEmpty) {
            return const Center(
              child: Text("No bookings found"),
            );
          }

          final filteredBookings =
              _filterBookingsByDate(bookingProvider.bookings, _selectedDate);

          return SingleChildScrollView(
            child: Container(
              padding:
                  const EdgeInsets.all(AppColorConstant.defaultPadding / 2),
              decoration: const BoxDecoration(
                color: AppColorConstant.adminSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Upcoming Bookings",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: IconButton(
                      onPressed: () {
                        _showCalendarPicker(context);
                      },
                      icon: const Icon(Icons.calendar_today),
                    ),
                    title: TextButton(
                      onPressed: () {
                        _showCalendarPicker(context);
                      },
                      child: Text(
                        DateFormat('MMM yyyy').format(_selectedDate),
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: _previousDay,
                          icon: const Icon(Icons.keyboard_arrow_left),
                        ),
                        IconButton(
                          onPressed: _nextDay,
                          icon: const Icon(Icons.keyboard_arrow_right),
                        ),
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: _buildDateContainers(),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: List.generate(
                        filteredBookings.length,
                        (index) => BookingInfoCard(
                            bookingInfo: filteredBookings[index]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<void> _showCalendarPicker(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _calculateWeekDates();
      });
    }
  }

  List<Booking> _filterBookingsByDate(
      List<Booking> bookings, DateTime selectedDate) {
    return bookings.where((booking) {
      final bookingDate = DateTime.parse(booking.eventDate.toString());
      return bookingDate.year == selectedDate.year &&
          bookingDate.month == selectedDate.month &&
          bookingDate.day == selectedDate.day;
    }).toList();
  }

  List<Widget> _buildDateContainers() {
    final List<Widget> dateContainers = [];
    const int daysInWeek = 7;

    for (int i = 0; i < daysInWeek; i++) {
      final date = _startDate.add(Duration(days: i));
      dateContainers.add(_buildDateContainer(date));
    }

    return dateContainers;
  }

  Widget _buildDateContainer(DateTime date) {
    final bool isSelected = date.year == _selectedDate.year &&
        date.month == _selectedDate.month &&
        date.day == _selectedDate.day;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedDate = date;
          _calculateWeekDates();
        });
      },
      child: Container(
        margin: EdgeInsets.all(ResponsiveWidget.isSmallScreen(context)
            ? 12
            : ResponsiveWidget.isMediumScreen(context)
                ? 18
                : 4),
        padding: EdgeInsets.symmetric(
            horizontal: ResponsiveWidget.isSmallScreen(context)
                ? 16
                : ResponsiveWidget.isMediumScreen(context)
                    ? 24
                    : 8,
            vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColorConstant.adminPrimaryColor
              : AppColorConstant.adminBgColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(date),
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 12.0,
                color: isSelected ? Colors.white : Colors.black38,
              ),
            ),
            Text(
              DateFormat('dd').format(date),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: isSelected
                    ? Colors.white
                    : AppColorConstant.black.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _calculateWeekDates() {
    final int weekDay = _selectedDate.weekday;
    _startDate = _selectedDate.subtract(Duration(days: weekDay - 1));
    _endDate = _startDate.add(const Duration(days: 6));
  }

  // _previousDay
  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(const Duration(days: 1));
      _calculateWeekDates();
    });
  }

// _nextDay
  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(const Duration(days: 1));
      _calculateWeekDates();
    });
  }
}
