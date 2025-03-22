import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/features/Applications/screens/search_page/widgets/SearchSubHead.dart';
import 'package:project_bc_tuto/features/Applications/screens/search_page/widgets/SearchTextField.dart';
import 'package:project_bc_tuto/features/Applications/screens/search_page/widgets/filter_tags.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/job_and_internship_card/vertical_Application.dart';
import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personilization/screens/settings/settings.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(title: Text('Search'), showBackArrow: true),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [

              SearchTextField(),

              SizedBox(height: JSizes.spaceBtwItems),

               SearchFieldSubHead(),

              SizedBox(height: JSizes.spaceBtwItems),

              JSearchFilterTag(
                textColor: JColors.black,
                backgroundColor: dark ? JColors.primary :JColors.primary.withAlpha((0.6 * 255).toInt()),
                tags: [
                  'Remote working','FullTime', "Flutter", "Douala"
                ]
              ),

              JDivider(),

              JGridLayout(
                  itemCount: 5,
                  crossAxisCount: 1,
                  mainAxisExtend: 230,
                  itemBuilder: (_, index) {
                    return  HorizontalJInternshipCard( borderRadius: 15, iconBorderRad: 8 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"],  completionDate: DateTime(2023, 12, 15), onTap: () => (const SettingScreen()),);
                  }
              ),


              SizedBox(height: JSizes.md,),

              JGridLayout(itemCount: 14,crossAxisCount: 2, itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', jobType: 'JOB', )),

            ],
          ),
        )
      ),
    );
  }
}

