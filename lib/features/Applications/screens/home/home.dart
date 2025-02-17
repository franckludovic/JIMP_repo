import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/widgets/home_categoriesV2.dart';


import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/applications/applications_cards/applications_card_vertical.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';

import '../../../../common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';

import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../common/widgets/texts/section_heading.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personilization/screens/settings/settings.dart';
import '../all_product/all_application.dart';
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

                             // JCategoryTab(
                             //   categories: [
                             //     {"name": "Design", "color": Colors.green, "icon": Icons.brush},
                             //     {"name": "Coding", "color": Colors.red, "icon": Icons.code},
                             //     {"name": "Data", "color": Colors.orange, "icon": Icons.bar_chart},
                             //     {"name": "Network", "color": Colors.purple, "icon": Icons.wifi},
                             //     {"name": "AI", "color": Colors.blue, "icon": Icons.smart_toy},
                             //     {"name": "Security", "color": Colors.deepOrange, "icon": Icons.security},
                             //     {"name": "Cloud", "color": Colors.cyan, "icon": Icons.cloud},
                             //   ],
                             // ),


                             const SizedBox(height: JSizes.spaceBtwSections),

                           ],
                         ),
                       )  ,

                    JSectionHeading(title: "Recommended Internships",onPressed: () {},),
                    const SizedBox(height: JSizes.spaceBtwItems * 0.1),


                    ///promo slider
                    JobCarousel(
                        jobs : [
                          HorizontalJIntershipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], onTap: () => (const SettingScreen()),),
                          HorizontalJIntershipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"]),
                          HorizontalJIntershipCard(companyLogo: JImages.google,companyName: "Skyhub",duration: "1 - 4 month",jobTitle: "Data analyst", location: "Buea",skills: ["Python", "R", "ML", "DL"]),
                          HorizontalJIntershipCard(companyLogo: JImages.apple,companyName: "Apple",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"]),
                          HorizontalJIntershipCard(companyLogo: JImages.facebook,companyName: "Facebook",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"]),

                        ]
                    ),
                    const SizedBox(height: JSizes.spaceBtwSections),

                    JSectionHeading(title: 'Popular Internships', onPressed: () => Get.to(() => AllApplications())),

                    ///applications in grid in 2 : n should be removed and replaced with horizontal layout in 1 : n
                    // JIGridLaout(
                    //     JList: [
                    //       VerticalJInternshipCard(companyName: "Google", companyLogo: JImages.google, internshipTitle: "Software engineer",saved: true,),
                    //       VerticalJInternshipCard(companyName: "Facebook", companyLogo: JImages.facebook, internshipTitle: "Network admin"),
                    //       VerticalJInternshipCard(companyName: "Apple", companyLogo: JImages.apple, internshipTitle: "Database admin"),
                    //       VerticalJInternshipCard(companyName: "Nvidia", companyLogo: JImages.nvidia, internshipTitle: "Data analyst",saved: true,),
                    //
                    //     ]
                    // )

                    JGridLayout(itemCount: 8, itemBuilder: (_, index) => JApplicationsCardVertical())



                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}





