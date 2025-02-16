import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/applications/applications_cards/applications_card_horizontal.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Sport Shirts"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              const JRoundedImage(
                width: double.infinity,
                imageUrl: JImages.banner4,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: JSizes.spaceBtwSections,
              ),

              ///sub-categories
              Column(
                children: [
                  ///heading
                  JSectionHeading(
                    title: 'Sport shirt',
                    onPressed: () {},
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections / 2),

                  SizedBox(
                    height: 120,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: JSizes.spaceBtwItems,),
                      itemBuilder: (context, index) => const JApplicationsCardHorizontal()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
