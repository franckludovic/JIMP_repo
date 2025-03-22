import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../job_and_internship_card/vertical_Application.dart';
import '../../layout/grid_layout.dart';

class JSortableApplications extends StatelessWidget {
  const JSortableApplications({
    super.key, this.saves = false,
  });

  final bool saves;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ///DropDown
        DropdownButtonFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.sort)
          ),
          onChanged: (value) {},
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity'].map((option) => DropdownMenuItem(value:option, child: Text(option))).toList(),

        ),

        const SizedBox(height: JSizes.spaceBtwSections,),
        /// applications
        JGridLayout(itemCount: 16, itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', jobType: 'Internship', saved: saves, ),
    )
      ],
    );
  }
}
