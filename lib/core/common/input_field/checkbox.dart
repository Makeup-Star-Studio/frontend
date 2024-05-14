import 'package:flutter/material.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/core/common/text/body.dart';

class EventTypeCheckboxGroup extends StatefulWidget {
  final List<String> eventTypes;
  final List<String> selectedTypes;
  final Function(List<String>) onChanged;

  const EventTypeCheckboxGroup({
    super.key,
    required this.eventTypes,
    required this.selectedTypes,
    required this.onChanged,
  });

  @override
  State<EventTypeCheckboxGroup> createState() => _EventTypeCheckboxGroupState();
}

class _EventTypeCheckboxGroupState extends State<EventTypeCheckboxGroup> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: ResponsiveWidget.isSmallScreen(context) ? 1 : 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: ResponsiveWidget.isSmallScreen(context)
            ? 6
            : ResponsiveWidget.isMediumScreen(context)
                ? 3
                : 5,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.eventTypes.length,
      itemBuilder: (context, index) {
        final eventType = widget.eventTypes[index];
        final isSelected = widget.selectedTypes.contains(eventType);
        return CheckboxListTile(
          hoverColor: Colors.transparent,
          checkColor: Colors.black,
          title: BodyText(
            textAlign: TextAlign.start,
            text: eventType,
          ),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value != null && value) {
                widget.selectedTypes.add(eventType);
              } else {
                widget.selectedTypes.remove(eventType);
              }
              widget.onChanged(widget.selectedTypes);
            });
          },
        );
      },
    );
  }
}
