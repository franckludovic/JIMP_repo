import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
//import '../../../utils/helpers/helper_functions.dart';


class VertivalImageText extends StatelessWidget {
  const VertivalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = JColors.white,
    this.backgroundColor = JColors.white,
    this.onTap,
  });

  final IconData image;
  final String title;
  final Color textColor;
  final Color? backgroundColor ;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    //final dark = JHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: JSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Circular icons
            JRoundedContainer(
              showBorder: true,
              width: 70,
              height: 70,
              padding: const EdgeInsets.only( right:  JSizes.sm),
              child: Center(
                child: Icon(
                  image, // Use the icon instead of image
                  size: 35, // Adjust the size as needed
                  color: JColors.dark,
                ),
              ),
            ),

            ///Text
            const SizedBox(
                height: JSizes.spaceBtwItems / 3),
            SizedBox(
              width: 70,
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelLarge!.apply(color: textColor),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ), // Text
            ),
          ],
        ),
      ),
    );
  }
}
