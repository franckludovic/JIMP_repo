import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/widgets/home_categories.dart';


import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/applications/applications_cards/JSearchAndPassCard.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';

import '../../../../common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';

import '../../../../common/widgets/texts/section_heading.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personilization/screens/settings/settings.dart';
import '../applications/Widgets/statistics_block.dart';
import '../search_page/search_body.dart';
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
                  JSearchContainer(text: "Search for an Opportunity", onTap: () => Get.to(() => const SearchBody()), ),


                ],
              ),
            ),

            ///Body
            Padding(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Column(
                  children: [
                       Container(
                         child: Column(
                           children: [
                             ///headings
                             const JSectionHeading(
                               title: "Popular Categories",
                               showActonButton: false,
                               textColor: JColors.primary,
                             ),
                             const SizedBox(height: JSizes.spaceBtwItems),

                             ///categories

                             JhomeCategories(),

                             const SizedBox(height: JSizes.spaceBtwSections),

                           ],
                         ),
                       )  ,

                    JSectionHeading(title: "Statistics : ", showActonButton: false,),
                    const SizedBox(height: JSizes.spaceBtwItems),

                    StatisticsBlock(),

                    const SizedBox(height: JSizes.spaceBtwSections),

                    JSectionHeading(title: "Recommended Internships", showActonButton: false,),
                    const SizedBox(height: JSizes.spaceBtwItems),


                    ///Internship slider
                    InternshipCarousel(
                        jobs : [
                          HorizontalJIntershipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], onTap: () => (const SettingScreen()),),
                          HorizontalJIntershipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"]),
                          HorizontalJIntershipCard(companyLogo: JImages.google,companyName: "Skyhub",duration: "1 - 4 month",jobTitle: "Data analyst", location: "Buea",skills: ["Python", "R", "ML", "DL"]),
                          HorizontalJIntershipCard(companyLogo: JImages.apple,companyName: "Apple",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"]),
                          HorizontalJIntershipCard(companyLogo: JImages.facebook,companyName: "Facebook",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"]),

                        ]
                    ),
                    const SizedBox(height: JSizes.spaceBtwSections),


                    ///applications in grid in 2 : n should be removed and replaced with horizontal layout in 1 : n
                    
                    JSectionHeading(title: 'Completed Internships', showActonButton: true, onPressed: () {}, TextSize: 20,),

                    const SizedBox(height: JSizes.spaceBtwItems),

                    SearchAndPastCardInternship(),




                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}







