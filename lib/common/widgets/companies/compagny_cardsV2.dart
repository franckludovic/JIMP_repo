import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../Images/Jcircular_image.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../texts/compagny_title_with_verified_icon.dart';


class JCompagnyCard extends StatelessWidget {
  const JCompagnyCard({
    super.key,
    required this.showBorder,
    this.onTap,
  });

  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: JRoundedContainer(
        padding: const EdgeInsets.all(JSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            ///icon
            Flexible(
              child: JCircularImage(
                isNetworkImage: false,
                image: JImages.clothIcon,
                backgroundColor: Colors.transparent,
                overlayColor: JHelperFunctions.isDarkMode(context)
                    ? JColors.white
                    : JColors.black,
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwItems / 2),

            /// --text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JCompagnyTittleVerifications(
                      title: "CBC", compagnyTextSize: TextSizes.large),
                  Text(
                    '256 Applications',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
