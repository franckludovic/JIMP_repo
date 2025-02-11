import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/icons/circular_icon.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class JBottonAddToCart extends StatelessWidget {
  const JBottonAddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: JSizes.defaultSpace, vertical: JSizes.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? JColors.darkerGrey : JColors.light,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(JSizes.cardRadiusLg),
          topRight: Radius.circular(JSizes.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              JCircularIcon(
                icon: Iconsax.minus,
                backgroundColor: JColors.darkGrey,
                width: 40,
                height: 40,
                color: JColors.white,
              ),
              const SizedBox(width: JSizes.spaceBtwItems),
              Text("2", style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(width: JSizes.spaceBtwItems),
              JCircularIcon(
                icon: Iconsax.add,
                backgroundColor: JColors.black,
                width: 40,
                height: 40,
                color: JColors.white,
              ),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(JSizes.sm),
              backgroundColor: JColors.black,
              side: const BorderSide(color: JColors.black),
            ),
            onPressed: () {},
            child: const Text("Add to card")),

        ],
      ),
    );
  }
}
