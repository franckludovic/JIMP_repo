import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';

import '../../../../../common/widgets/buttons/bottom_button.dart';
import '../../../../../common/widgets/companies/compagny_schocase.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class JCategory extends StatelessWidget {
  const JCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: JSizes.spaceBtwItems),
        JSectionHeading(title: "Best Applications", onPressed: () {}),
        Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///--compagny
              JCompagnyShowCase(images: [JImages.productImage3, JImages.productImage1, JImages.productImage5],),
              JCompagnyShowCase(images: [JImages.productImage15, JImages.productImage9, JImages.productImage40],),
              JCompagnyShowCase(images: [JImages.productImage2, JImages.productImage8, JImages.productImage59],),
              JCompagnyShowCase(images: [JImages.productImage35, JImages.productImage29, JImages.productImage10],),
              const SizedBox(height: JSizes.spaceBtwItems),


              ///application

              Jbutton(buttonTitle: "Show more", borderRadius: 24, padding: 12),

            ],
          ),
        ),
      ],
    );
  }
}
