import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/job_and_internship_card/carousel_slider_interships.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/home/widgets/company_home_header.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/home/widgets/company_home_stats.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/home/widgets/quick_actions.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/companies/Interview_cards.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../personilization/screens/settings/settings.dart';
import '../interviews/interviews.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CompanyHomeHeader(),
            Padding(
              padding: EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                children: [
                  CompanyHomeStats(),

                  SizedBox(height: JSizes.spaceBtwSections,),

                  QuickActioons(),

                  SizedBox(height: JSizes.spaceBtwSections,),

                  JSectionHeading(title: "Latest Postings", TextSize: 22, onPressed: () {}, ),

                  SizedBox(
                    child :  InternshipCarousel(jobs: [
                      HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"],  completionDate: DateTime(2023, 12, 15),onTap: () => (const SettingScreen()),),
                      HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
                      HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "1 - 4 month",jobTitle: "Data analyst", location: "Buea",skills: ["Python", "R", "ML", "DL"],  completionDate: DateTime(2023, 12, 15),),
                      HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"],  completionDate: DateTime(2023, 12, 15),),
                      HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"],  completionDate: DateTime(2023, 12, 15),),

                    ]
                    )
                  ),

                  SizedBox(height: JSizes.spaceBtwSections,),

                  JSectionHeading(title: "Upcoming Interviews", TextSize: 22 ,onPressed: () => Get.to(() => const  InterviewsScreens())),

                  JGridLayout(itemCount: 5,crossAxisCount: 1, mainAxisExtend: 110, itemBuilder: (index, _) => JUserInterviewCards())


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

