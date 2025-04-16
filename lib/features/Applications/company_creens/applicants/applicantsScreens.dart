import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/data/repositories/applicant/applicant_repository.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/applicants/widget/applicant_tile.dart';
import 'package:project_bc_tuto/features/Applications/models/applicant_model.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../screens/Applicaton_details/myWidgets/application_tags.dart';
import '../../screens/search_page/widgets/SearchTextField.dart';

class ApplicantsScreens extends StatelessWidget {
  const ApplicantsScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicantModel applicant;

    Get.put(ApplicantRepository());


    final controller = Get.put(CompanyController());
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          "Applicants",
          style: Theme
              .of(context)
              .textTheme
              .headlineMedium,
        ),
      ),
      body: Column(
        children: [
          SearchTextField(isFilter: true),
          SizedBox(height: JSizes.spaceBtwSections * 1.5),
          SizedBox(
            height: 80,
            child: ListView.builder(
              itemCount: 1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 20,
                  child: JApplicatonTags(
                    tags: [
                      'Applied',
                      "Interviews",
                      "Best Match",
                      "All positions"
                    ],
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(JSizes.sm),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: dark ? Colors.white : JColors.dark,
                    width: 3,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: FutureBuilder<List<ApplicantModel>>(
                future: ApplicantRepository.instance
                    .fetchApplicantsByCompanyId(controller.user?.id ?? ''),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  final applicants = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: applicants.length,
                    itemBuilder: (context, index) {
                      final applicant = applicants[index];
                      return ApplicantTile(
                        percent: 0.2,
                        applicant: applicant,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}