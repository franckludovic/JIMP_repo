import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';


class VertivalImageText extends StatelessWidget {
  const VertivalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = JColors.white,
    this.backgroundColor = JColors.white,
    this.onTap,
  });

  final image, title;
  final Color textColor;
  final Color? backgroundColor ;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: JSizes.spaceBtwItems),
        child: Column(
          children: [
            ///Circular icons
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(JSizes.sm),
              decoration: BoxDecoration(
                  color: backgroundColor ?? (JHelperFunctions.isDarkMode(context) ? JColors.black : JColors.white),
                  borderRadius:
                  BorderRadius.circular(100)),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  color: dark ? JColors.dark : JColors.dark,
                ),
              ),
            ),

            ///Text
            const SizedBox(
                height: JSizes.spaceBtwItems / 2),
            SizedBox(
                width: 55,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.labelMedium!.apply(color: textColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )
            ),
          ],
        ),
      ),
    );
  }
}
