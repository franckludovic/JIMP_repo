import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/widgets/home_categories.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/widgets/sideBar.dart';


import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:sidebarx/sidebarx.dart';

import '../../../../common/widgets/applications/applications_cards/JSearchAndPassCard.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/primary_header_conatiner.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/search_container.dart';

import '../../../../common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';

import '../../../../common/widgets/texts/section_heading.dart';

import '../../../../uploadcategories.dart';
import '../../../../uploadsubcategories.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../personilization/screens/settings/settings.dart';
import '../applications/Widgets/statistics_block.dart';
import '../search_page/search_body.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final SidebarXController sidebarController =
  SidebarXController(selectedIndex: 0, extended: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: JSidebar(controller: sidebarController),
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
                 // JSearchContainer(text: "Search for an Opportunity", onTap: () => Get.to(() => const UploadSubCategoriesPage()), ),


                ],
              ),
            ),

            ///Body
            Padding(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Column(
                  children: [
                       Column(
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
                       )  ,

                    JSectionHeading(title: "Statistics : ", showActonButton: false,),

                    StatisticsBlock(),

                    const SizedBox(height: JSizes.spaceBtwSections),


                    JSectionHeading(title: "Recommended Internships", showActonButton: false,),
                    const SizedBox(height: JSizes.spaceBtwItems),


                    ///Internship slider
                    InternshipCarousel(
                        jobs : [
                          HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"],  jobType: 'JOB',  completionDate: DateTime(2023, 12, 15), onTap: () => (const SettingScreen()),),
                          HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
                          HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Skyhub",duration: "1 - 4 month",jobTitle: "Data analyst", location: "Buea",skills: ["Python", "R", "ML", "DL"],  completionDate: DateTime(2023, 12, 15),),
                          HorizontalJInternshipCard(companyLogo: JImages.apple,companyName: "Apple",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"],  completionDate: DateTime(2023, 12, 15),),
                          HorizontalJInternshipCard(companyLogo: JImages.facebook,companyName: "Facebook",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"],  completionDate: DateTime(2023, 12, 15),),

                        ]
                    ),
                    const SizedBox(height: JSizes.spaceBtwSections),


                    ///applications in grid in 2 : n should be removed and replaced with horizontal layout in 1 : n

                    JSectionHeading(title: 'Other Internships', showActonButton: true, onPressed: () {}, TextSize: 20,),

                    const SizedBox(height: JSizes.spaceBtwItems),

                    HorizontalPostCard(),




                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}







