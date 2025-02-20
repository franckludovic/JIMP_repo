import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../features/personilization/screens/settings/settings.dart';
import '../../job_and_internship_card/intership_cards.dart';


class SearchAndPastCardInternship extends StatelessWidget {
  const SearchAndPastCardInternship({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HorizontalJIntershipCard( borderRadius: 5 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, day: 12, month: 02,year: 2023 ,onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJIntershipCard( borderRadius: 5 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, day: 20, month: 05,year: 2022 ,onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJIntershipCard( borderRadius: 5 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, day: 18, month: 11,year: 2019 ,onTap: () => (const SettingScreen()),),

      ],
    );
  }
}
