import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../styles/shadow.dart';
import '../../custom_shapes/container_shapes/rounded_container.dart';
import '../../Images/rounded_image.dart';
import '../../texts/application_price_text.dart';
import '../../texts/applications_title_text.dart';
import '../../texts/compagny_title_with_verified_icon.dart';

class JApplicationsCardVertical extends StatelessWidget {
  const JApplicationsCardVertical({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    ///to be romoved and replaced with horizontal cards

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalApplicationShadow],
          borderRadius: BorderRadius.circular(JSizes.applicationImageRadius),
          color: dark ? JColors.darkGrey : JColors.white,
        ),
        child: Column(
          ///thumbnail, wishlist, discount
          children: [
            JRoundedContainer(
              height: 130,
              padding: const EdgeInsets.all(JSizes.sm),
              margin: const EdgeInsets.all(JSizes.md),
              backgroundColor: dark ? JColors.dark : JColors.light,
              child: Stack(
                children: [
                  ///image
                  const JRoundedImage(
                      imageUrl: JImages.nvidia, applyImageRadius: true),
                ],
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwItems / 2),

            ///details
             Padding(
              padding: const EdgeInsets.only(left: JSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JApplicationTitleText( title: "Acer gaming Laptop", smallSize: true),
                  const SizedBox(height: JSizes.spaceBtwItems / 2),
                  JCompagnyTittleVerifications(title: "Nike"),
                ],
              ),
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: JSizes.sm),
                  child: const JApplicationPrice(price: '35.0'),
                ),

                Container(
                  decoration: const BoxDecoration(
                      color: JColors.dark,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(JSizes.cardRadiusMd),
                        bottomRight: Radius.circular(JSizes.applicationImageRadius),
                      )
                  ),
                  child: const SizedBox(
                      width: JSizes.iconLg * 1.2,
                      height: JSizes.iconLg * 1.2 ,
                      child: Center(child: Icon(Iconsax.save_21,  size: 30,))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}


