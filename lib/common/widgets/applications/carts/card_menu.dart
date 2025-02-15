import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../Images/rounded_image.dart';
import '../../texts/applications_title_text.dart';
import '../../texts/compagny_title_with_verified_icon.dart';

class JCardItem extends StatelessWidget {
  const JCardItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        JRoundedImage(
          imageUrl: JImages.productImage1,
          width: 60,
          height: 60,
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
              JCompagnyTittleVerifications(title: 'Nike'),
              Flexible(child: JApplicationTitleText(title: "black sport Shoe", maxLines: 1)),
              Text.rich(
                  TextSpan(
                      children:[
                        TextSpan(text: 'Color ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: 'Green ', style: Theme.of(context).textTheme.bodyLarge),
                        TextSpan(text: 'Size ', style: Theme.of(context).textTheme.bodySmall),
                        TextSpan(text: 'UK 08 ', style: Theme.of(context).textTheme.bodyLarge),
                      ]
                  )
              )
            ],
          ),
        )
      ],
    );
  }
}
