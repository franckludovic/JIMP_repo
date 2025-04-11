import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/models/categorie_model.dart';

import '../../../utils/constants/image_strings.dart';
import '../../../utils/constants/sizes.dart';
import '../job_and_internship_card/intership_cards.dart';
import '../job_and_internship_card/vertical_Application.dart';
import '../layout/grid_layout.dart';
import '../texts/section_heading.dart';

class JCategoryTab extends StatelessWidget {
  final CategoryModel category;
  const JCategoryTab({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              /// -- Brands
              HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
              HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
              HorizontalJInternshipCard(companyLogo: JImages.nvidia,companyName: "Nvidia",duration: "8 - 9 month",jobTitle: "Database admin", location: "Douala",skills: ["C#", "java", "C"],  completionDate: DateTime(2023, 12, 15),),
              /// -- Products
              JSectionHeading(title: 'You might like', onPressed: () {}),
              const SizedBox(height: JSizes.spaceBtwItems),

              JGridLayout(
                itemCount: 4,
                itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', jobType: 'Internship', )),

            ],
          ),
        ),
      ],
    );
  }
}