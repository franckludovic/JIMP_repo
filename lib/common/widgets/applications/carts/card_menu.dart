import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../Images/rounded_image.dart';
import '../../texts/applications_title_text.dart';
import '../../texts/compagny_title_with_verified_icon.dart';
import 'add_remove_button.dart';

class JAppliedCard extends StatelessWidget {
  const JAppliedCard({
    super.key,
    this.status = 'PENDING',
  });

  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            JRoundedImage(
              imageUrl: JImages.google,
              width: 100,
              height: 100,
              padding: EdgeInsets.all(JSizes.sm),
              backgroundColor: JHelperFunctions.isDarkMode(context) ? JColors.darkerGrey : JColors.grey,
            ),

            const SizedBox(width: JSizes.spaceBtwItems),


            ///title, price, and Size
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JCompagnyTittleVerifications(title: "Google"),
                  Flexible(child: JApplicationTitleText(title: "Senior Software Engineer", maxLines: 2)),
                  Row(
                    children: [
                      Text(status, style:Theme.of(context).textTheme.bodyMedium!.apply(color: status == 'ACCEPTED' ? Colors.green : status == 'REJECTED' ? Colors.red :  Colors.amber)),
                      SizedBox(width: JSizes.xs,),
                      Icon( status == 'REJECTED' ? Iconsax.close_circle : status == 'ACCEPTED' ? Iconsax.tick_circle : Iconsax.clock ,
                        color: status == 'ACCEPTED' ? Colors.green : status == 'REJECTED' ? Colors.red :  Colors.amber,)
                    ],
                  ),

                ],
              ),
            )
          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems),

        JApplied_drop_buttons(),

        const SizedBox(height: JSizes.xxs),
        Divider( thickness: 3,),

        const SizedBox(height: JSizes.spaceBtwSections),
      ],
    );
  }
}
