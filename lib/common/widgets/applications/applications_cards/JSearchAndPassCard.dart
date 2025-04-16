import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../features/personilization/screens/settings/settings.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../job_and_internship_card/final_Horizontal_Postings_card.dart';
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


class HorizontalPostCard extends StatelessWidget {
  const HorizontalPostCard({super.key});

  @override
  Widget build(BuildContext context) {

    final PostingController postingController = Get.put(PostingController());

    return Obx(() {
      final posts = postingController.posts;
      final latestPosting = posts.length >= 5 ? posts.sublist(0, 5) : posts;

      return JGridLayout(
        crossAxisCount: 1,
        mainAxisExtend: 230,
        itemCount: latestPosting.length,
        itemBuilder: (_, index) {
          final posting = latestPosting[index];
          return HorizontalJPostingCard(
            posting: posting,
          );
        });
    });
  }
}

