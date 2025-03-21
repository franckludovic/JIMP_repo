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
        HorizontalJIntershipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true ,onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJIntershipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true, onTap: () => (const SettingScreen()),),
        Divider(),
        HorizontalJIntershipCard( borderRadius: 10 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"], isCompleted: true,onTap: () => (const SettingScreen()),),

      ],
    );
  }
}
