import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:makeupstarstudio/config/constants/color.dart';
import 'package:makeupstarstudio/config/constants/responsive.dart';
import 'package:makeupstarstudio/src/provider/testimonial/testimonial_provider.dart';
import 'package:provider/provider.dart';

class OverViewInfoCard3 extends StatefulWidget {
  const OverViewInfoCard3({
    super.key,
  });

  @override
  State<OverViewInfoCard3> createState() => _OverViewInfoCard3State();
}

class _OverViewInfoCard3State extends State<OverViewInfoCard3> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TestimonialProvider>(context, listen: false)
          .fetchTestimonial();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppColorConstant.defaultPadding),
      decoration: const BoxDecoration(
        color: AppColorConstant.adminSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ResponsiveWidget.isSmallScreen(context)
          ? const OverViewContainerSmallScreen()
          : const OverViewContainerLargeScreen(),
    );
  }
}

class OverViewContainerLargeScreen extends StatelessWidget {
  const OverViewContainerLargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TestimonialProvider>(
        builder: (context, testimonialProvider, child) {
      final testimonial = testimonialProvider.testimonials;
      if (testimonialProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppColorConstant.defaultPadding * 0.75),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: const Color(0xFFA4CDFF).withOpacity(0.4),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: SvgPicture.asset(
            'assets/svgs/review.svg',
            // colorFilter: const ColorFilter.mode(Color(0xFFA4CDFF), BlendMode.srcIn),
          ),
        ),
        title: const Text(
          'Testimonials',
          style: TextStyle(
            color: AppColorConstant.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text("${testimonial.length}",
            style: const TextStyle(
              color: AppColorConstant.black,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            )),
        trailing: const Icon(Icons.more_vert, color: Colors.black),
      );
    });
  }
}

class OverViewContainerSmallScreen extends StatelessWidget {
  const OverViewContainerSmallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TestimonialProvider>(
        builder: (context, testimonialProvider, child) {
      final testimonials = testimonialProvider.testimonials;
      if (testimonialProvider.isLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(
                    AppColorConstant.defaultPadding * 0.75),
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFA4CDFF).withOpacity(0.4),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/svgs/review.svg',
                  // colorFilter: const ColorFilter.mode(
                  //     AppColorConstant.black ?? Colors.black, BlendMode.srcIn),
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.black)
            ],
          ),
          const SizedBox(height: AppColorConstant.defaultPadding / 2),
          const Text(
            'Testimonials',
            style: TextStyle(
              color: AppColorConstant.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppColorConstant.defaultPadding / 2),
          Text('${testimonials.length}',
              style: const TextStyle(
                color: AppColorConstant.black,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ))
        ],
      );
    });
  }
}
