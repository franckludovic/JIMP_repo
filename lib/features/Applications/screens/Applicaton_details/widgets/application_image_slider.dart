import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_shapes/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class JApplicationImage extends StatelessWidget {
  const JApplicationImage({
    super.key,

  });


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return JCurvedEdgeswidgets(
      child: Container(
        color: dark ? JColors.darkerGrey : JColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(
                      JSizes.applicationImageRadius * 2),
                  child: Center(
                      child: Image(
                          image: AssetImage(JImages.productImage5))),
                )),

            ///image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: JSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  separatorBuilder: (_, __) => const SizedBox(
                    width: JSizes.spaceBtwItems,
                  ),
                  itemCount: 8,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemBuilder: (_, index) => JRoundedImage(
                    imageUrl: JImages.productImage3,
                    width: 80,
                    backgroundColor:
                    dark ? JColors.dark : JColors.light,
                    border: Border.all(color: JColors.primary),
                    padding: const EdgeInsets.all(JSizes.sm),
                  ),
                ),
              ),
            ),
            const JAppbar(
              showBackArrow: true,
              actions: [
                JCircularIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            )
          ],
        ),
      ),
    );
  }
}
