import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/controllers/intership_carousel_controller.dart';

import '../../../features/Applications/controllers/home_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/container_shapes/Cirular_shape.dart';
import 'intership_cards.dart';

class InternshipCarousel extends StatelessWidget {
  const InternshipCarousel({
    super.key,
    required this.jobs,
    this.onTap,
    this.autoplay = false,
  });

  final VoidCallback? onTap;
  final List<HorizontalJInternshipCard> jobs;
  final bool autoplay;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntershipCarouselController());

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
        CarouselSlider(
        items: jobs,
        options: CarouselOptions(
            height: 230,
            enlargeCenterPage: true,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 7),
            autoPlayAnimationDuration: const Duration(milliseconds: 1200),
            enableInfiniteScroll: true,
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index)
        ),
      ),
        const SizedBox(height: JSizes.spaceBtwItems),
        Center(
          child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < jobs.length; i++)
                JCircularContainer(
                  width: 20,
                  height: 4,
                  margin: EdgeInsets.only(right: 10),
                  backgroundColor:
                  controller.carouselCurrentIndex.value == i
                      ? JColors.primary
                      : JColors.grey,
                ),
            ],
          )),
        ),
        ],
      ),
    );

  }
}