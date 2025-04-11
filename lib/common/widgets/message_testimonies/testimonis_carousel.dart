
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/message_testimonies/testimonies_messages.dart';

import '../../../features/Applications/controllers/home_controller.dart';
import '../../../features/Applications/controllers/intership_carousel_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../custom_shapes/container_shapes/Cirular_shape.dart';


class MessageCarousel extends StatelessWidget {
  const MessageCarousel({
    super.key,
    required this.message,
    this.onTap,
  });

  final VoidCallback? onTap;
  final List<Testimonies> message;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IntershipCarouselController());

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CarouselSlider(
            items: message,
            options: CarouselOptions(
                height: 120,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 10),
                autoPlayAnimationDuration: const Duration(milliseconds: 1200),
                enableInfiniteScroll: true,
                viewportFraction: 0.9,
                onPageChanged: (index, _) => controller.updatePageIndicator(index)
            ),
          ),
          const SizedBox(height: JSizes.spaceBtwItems),
          Center(
            child: Obx(() => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < message.length; i++)
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
