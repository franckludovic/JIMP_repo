import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../layout/grid_layout.dart';
import '../applications_cards/applications_card_vertical.dart';

class JSortableApplications extends StatelessWidget {
  const JSortableApplications({
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
          items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity'].map((option) => DropdownMenuItem(value:option, child: Text(option))).toList(),

        ),

        const SizedBox(height: JSizes.spaceBtwSections,),
        /// applications
        JGridLayout(itemCount: 16, itemBuilder: (_, index) => JApplicationsCardVertical())
      ],
    );
  }
}
