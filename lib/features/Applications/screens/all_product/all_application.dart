import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/applications/applications_cards/applications_card_vertical.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class AllApplications extends StatelessWidget {
  const AllApplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text('Popular Applications'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
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
          ),
        ),
      ),
    );
  }
}
