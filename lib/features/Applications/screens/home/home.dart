import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/applications/applications_cards/applications_card_vertical.dart';

import 'package:project_bc_tuto/features/Applications/screens/home/widgets/home_categories.dart';

import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';

import '../../../../common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
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
            JPrimaryHeaderContainer(
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
                        const homeCategories(),
                        const SizedBox(height: JSizes.spaceBtwSections),
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
                    
                    JSectionHeading(title: "Recommended Internships",onPressed: () {},),
                    const SizedBox(height: JSizes.spaceBtwItems * 0.1),
                    ///promo slider
                    JobCarousel(
                        jobs : [
                          JIntershipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"]),
                          JIntershipCard(companyLogo: JImages.google,companyName: "StarLabs",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"]),
                          JIntershipCard(companyLogo: JImages.google,companyName: "FrontCrown",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"]),
                          JIntershipCard(companyLogo: JImages.google,companyName: "LakeSide",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"]),

                        ]
                    ),
                    const SizedBox(height: JSizes.spaceBtwSections),

                    JSectionHeading(title: 'Popular Internships', onPressed: () {}),
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




