import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/Images/Jcircular_image.dart';
import 'package:project_bc_tuto/common/widgets/texts/application_price_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/applications_title_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/compagny_title_with_verified_icon.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class JApplicationData extends StatelessWidget {
  const JApplicationData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///price and sale price
        Row(
          children: [
            ///sale tag
            JRoundedContainer(
              radius: JSizes.sm,
              backgroundColor:
              JColors.secondary.withAlpha((0.8 * 255).toInt()),
              padding: const EdgeInsets.symmetric(
                  horizontal: JSizes.sm, vertical: JSizes.xs),
              child: Text('25%',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge!
                      .apply(color: JColors.black)),
            ),
            
            SizedBox(width: JSizes.spaceBtwItems),
            
            ///price
            Text("\$250", style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
            SizedBox(width: JSizes.spaceBtwItems),
            JApplicationPrice(price: " 175", isLarge: true),
          ],
        ),
        SizedBox(height: JSizes.spaceBtwItems / 1.5),

        ///title
        JApplicationTitleText(title: "Green nike short Shirt"),
        SizedBox(height: JSizes.spaceBtwItems / 1.5),

        ///storck statues
        Row(
          children: [
            JApplicationTitleText(title: "Status"),
            SizedBox(width: JSizes.spaceBtwItems),
            Text("180 Application", style: Theme.of(context).textTheme.titleMedium),

          ],
        ),
        SizedBox(height: JSizes.spaceBtwItems / 1.5),

        ///brand
        Row(
          children: [
            JCircularImage(
              image: JImages.cosmeticsIcon,
              width: 32,
              height: 32,
              overlayColor: dark ? JColors.white : JColors.black,
            ),
            SizedBox(width: JSizes.spaceBtwItems / 2),
            JCompagnyTittleVerifications(title: "Apple",compagnyTextSize: TextSizes.medium),
          ],
        )
      ],
    );
  }
}
