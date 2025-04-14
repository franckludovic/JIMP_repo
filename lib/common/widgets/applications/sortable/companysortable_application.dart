import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../features/Applications/company_creens/Posting/Widgets/postings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../layout/grid_layout.dart';

class JCompanySortableApplications extends StatelessWidget {
  const JCompanySortableApplications({
    super.key,
  });

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
          items: ['Name', 'Lasted', 'Oldest', 'Less applied', 'Most applied'].map((option) => DropdownMenuItem(value:option, child: Text(option))).toList(),

        ),

        const SizedBox(height: JSizes.spaceBtwSections,),
        /// applications
        //JGridLayout(itemCount: 16, crossAxisCount: 1, mainAxisExtend: 260, itemBuilder: (_, index) => JobPostCard())
      ],
    );
  }
}

