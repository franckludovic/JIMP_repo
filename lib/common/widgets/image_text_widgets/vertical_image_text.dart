import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../features/Applications/controllers/category_controller.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class VerticalImageText extends StatelessWidget {
  const VerticalImageText({
    super.key,
    required this.icon,
    required this.title,
    this.textColor = JColors.white,
    this.backgroundColor = JColors.white,
    this.onTap,
  });

  final Widget icon;
  final String title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: JSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular Icon inside container
            JRoundedContainer(
              showBorder: true,
              width: 65,
              height: 65,
              radius: 65,

              padding: const EdgeInsets.all(0),
              backgroundColor: backgroundColor!,
              child: Center(
                child: icon
              ),
            ),

            /// Text
            const SizedBox(height: JSizes.spaceBtwItems / 3),
            SizedBox(
              width: 70,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
