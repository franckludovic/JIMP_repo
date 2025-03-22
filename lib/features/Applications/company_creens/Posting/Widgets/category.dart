import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';

import '../../../../../common/widgets/buttons/bottom_button.dart';
import '../../../../../common/widgets/companies/compagny_schocase.dart';
import '../../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personilization/screens/settings/settings.dart';

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
              JCompagnyShowCase(
                jobs: [
                  HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"],  completionDate: DateTime(2023, 12, 15), onTap: () => (const SettingScreen()),),
                  HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
                  HorizontalJInternshipCard(companyLogo: JImages.google,companyName: "Skyhub",duration: "1 - 4 month",jobTitle: "Data analyst", location: "Buea",skills: ["Python", "R", "ML", "DL"],  completionDate: DateTime(2023, 12, 15),),
                  HorizontalJInternshipCard(companyLogo: JImages.apple,companyName: "Apple",duration: "5 - 6 month",jobTitle: "Web Developer", location: "Nigeria",skills: ["ReactJS", "javascript", "flutter"], completionDate: DateTime(2023, 12, 15),),
                  HorizontalJInternshipCard(companyLogo: JImages.facebook,companyName: "Facebook",duration: "1 - 3 month",jobTitle: "Network admin", location: "Libya",skills: ["Cisco", "javascript", "Linux"],  completionDate: DateTime(2023, 12, 15),),

                ],
              ),
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
