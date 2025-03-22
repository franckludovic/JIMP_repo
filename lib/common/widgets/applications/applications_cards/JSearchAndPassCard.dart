import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../features/personilization/screens/settings/settings.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../job_and_internship_card/intership_cards.dart';


class SearchAndPastCardInternship extends StatelessWidget {
  const SearchAndPastCardInternship({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalJInternshipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, completionDate: DateTime(2023, 12, 15), backgroundColor: JColors.success.withAlpha((0.1 * 255).toInt()), iconBorderRad: JSizes.borderRadiusLg * 0.8,onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJInternshipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, completionDate: DateTime(2023, 12, 15), backgroundColor: JColors.success.withAlpha((0.1 * 255).toInt()), iconBorderRad: JSizes.borderRadiusLg * 0.8,onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJInternshipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, completionDate: DateTime(2023, 12, 15), backgroundColor: JColors.success.withAlpha((0.1 * 255).toInt()), iconBorderRad: JSizes.borderRadiusLg * 0.8,onTap: () => (const SettingScreen()),),

      ],
    );
  }
}
