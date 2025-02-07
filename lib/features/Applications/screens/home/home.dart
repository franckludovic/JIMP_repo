import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/applications/applications_cards/applications_card_vertical.dart';

import 'package:project_bc_tuto/features/Applications/screens/home/widgets/home_categories.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/widgets/promo_slider.dart';

import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';

import '../../../../common/widgets/layout/grid_layout.dart';

import '../../../../common/widgets/texts/section_heading.dart';

import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            ///Header
            PrimaryHeaderContainer(
              child: Column(
                children: [

                  /// Appbar
                  const HomeAppbar(),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  ///Searchbar
                  const JSearchContainer(text: "Search for an Opportunity"),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  ///Categories & heading
                  Padding(
                    padding: EdgeInsets.only(left: JSizes.defaultSpace),
                    child: Column(
                      children: [

                        ///headings
                        const JSectionHeading(
                          title: "Popular Categories",
                          showActonButton: false,
                          textColor: Colors.white,
                        ),
                        const SizedBox(height: JSizes.spaceBtwItems),

                        ///categories
                        const homeCategories()
                      ],
                    ),
                  ),
                ],
              ),
            ),

            ///Body

            Padding(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Column(
                  children: [

                    ///promo slider
                    const PromoSlider(banners: [
                      JImages.banner1,
                      JImages.banner2,
                      JImages.banner3,
                      JImages.banner4,
                      JImages.banner5
                    ]),
                    const SizedBox(height: JSizes.spaceBtwSections),

                    JSectionHeading(title: 'Popular Jobs', onPressed: () {}),
                    const SizedBox(height: JSizes.spaceBtwItems),



                    ///applications in grid in 2 : n should be removed and replaced with horizontal layout in 1 : n
                    JGridLayout(itemCount: 6, itemBuilder: (_, index) => const JApplicationsCardVertical(), )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}




