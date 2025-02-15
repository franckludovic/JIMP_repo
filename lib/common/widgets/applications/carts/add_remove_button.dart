import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../icons/circular_icon.dart';

class JApplied_drop_buttons extends StatelessWidget {
  const JApplied_drop_buttons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        JCircularIcon(
          icon: Iconsax.minus,
          width: 32,
          height: 32,
          size: JSizes.md,
          color: JHelperFunctions.isDarkMode(context) ? JColors.grey : JColors.black,
          backgroundColor: JHelperFunctions.isDarkMode(context) ? JColors.darkerGrey : JColors.grey,
        ),
        SizedBox(width: JSizes.spaceBtwItems),
        Text("2", style: Theme.of(context).textTheme.titleSmall,),
        SizedBox(width: JSizes.spaceBtwItems),
        JCircularIcon(
            icon: Iconsax.add,
            width: 32,
            height: 32,
            size: JSizes.md,
            color: JColors.white,
            backgroundColor: JColors.primary
        ),
      ],
    );
  }
}
