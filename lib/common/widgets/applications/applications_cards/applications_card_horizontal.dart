import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/common/widgets/texts/application_price_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/applications_title_text.dart';
import 'package:project_bc_tuto/common/widgets/texts/compagny_title_with_verified_icon.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../icons/circular_icon.dart';

class JApplicationsCardHorizontal extends StatelessWidget {
  const JApplicationsCardHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(JSizes.applicationImageRadius),
        color: dark ? JColors.darkGrey : JColors.softGrey,
      ),
      child: Row(
        children: [
          ///thumbnail
          JRoundedContainer(
            height: 120,
            padding: EdgeInsets.all(JSizes.sm),
            backgroundColor: dark ? JColors.dark : JColors.light,
            child: Stack(
              children: [
                ///thumbnail image
                SizedBox(
                    width: 120,
                    height: 120,
                    child: JRoundedImage(
                      imageUrl: JImages.productImage1,
                      applyImageRadius: true,
                    )
                ),


                ///Sale tab
                Positioned(
                  top: 12,
                  child: JRoundedContainer(
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
                ),

                ///Favorit icon
                Positioned(
                    top: 0,
                    right: 0,
                    child: const JCircularIcon(
                      icon: Iconsax.save_21,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          
          ///details
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: JSizes.sm , left: JSizes.sm),
              child: Column(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      JApplicationTitleText(title: "Green and blue shoe", smallSize: true,),
                      SizedBox(height: JSizes.spaceBtwItems/2,),
                      JCompagnyTittleVerifications(title: "Nike"),
                    ],
                  ),

                  Spacer(),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///pricing
                      const Flexible(child: JApplicationPrice(price: "256.0")),

                      ///add to cart

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
                            child: Center(child: Icon(Iconsax.add, color: JColors.white))),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
