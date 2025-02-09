import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/controllers/home_controller.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/Cirular_shape.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../utils/constants/sizes.dart';

class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key, required this.banners,
  });

  final List<String> banners;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              onPageChanged: (index, _) =>
                  controller.updatePageIndicator(index)),
          items: banners.map((url) => JRoundedImage(imageUrl: url)).toList(),
        ),
        const SizedBox(height: JSizes.spaceBtwItems),
        Center(
          child: Obx(() => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < banners.length; i++)
                CircularContainer(
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
        )
      ],
    );
  }
}
