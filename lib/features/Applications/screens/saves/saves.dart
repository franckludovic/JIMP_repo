import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/icons/circular_icon.dart';
import 'package:project_bc_tuto/features/Applications/screens/home/home.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/applications/applications_cards/vertical_Application.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../utils/constants/image_strings.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Saved Application",
            style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          JCircularIcon(
              icon: Iconsax.add_square5,
              color: Colors.yellow,
              onPressed: () => Get.to( HomeScreen()))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [

              // JIGridLaout(
              //   JList: [
              //     VerticalJInternshipCard(companyName: "Google", companyLogo: JImages.google, internshipTitle: "Software engineer",saved: true),
              //     VerticalJInternshipCard(companyName: "Nvidia", companyLogo: JImages.nvidia, internshipTitle: "Data analyst",saved: true),
              //   ],
              // ),

              JGridLayout(itemCount: 5,crossAxisCount: 2, itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', )),

            ],
          ),
        ),
      ),
    );
  }
}
