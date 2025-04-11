import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/applications/applications_cards/applications_card_vertical.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../common/widgets/job_and_internship_card/vertical_Application.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Technology", style: Theme.of(context).textTheme.headlineMedium,),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Banner
              // const JRoundedImage(
              //   width: double.infinity,
              //   imageUrl: JImages.banner4,
              //   applyImageRadius: true,
              // ),

          HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
              const SizedBox(
                height: JSizes.spaceBtwSections,
              ),

              ///sub-categories
              Column(
                children: [
                  ///heading
                  JSectionHeading(
                    title: 'Nvidiaflu',
                    onPressed: () {},
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections / 2),

                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) => const SizedBox(width: JSizes.spaceBtwItems,),
                      itemBuilder: (context, index) =>VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', jobType: 'Internship', )),
                      //itemBuilder: (context, index) => const JApplicationsCardHorizontal()),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
