import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/icons/circular_icon.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/job_and_internship_card/vertical_Application.dart';
import '../../../../common/widgets/layout/grid_layout.dart';
import '../../../../utils/constants/image_strings.dart';
import '../all_product/all_application.dart';
import '../search_page/widgets/SearchTextField.dart';

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
              icon: Iconsax.sort,
              color: Colors.yellow,
              onPressed: () => Get.to(() => const AllApplications(saves: true,))
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [

              SearchTextField(),

              SizedBox(height: JSizes.spaceBtwSections),

              JGridLayout(itemCount: 5,crossAxisCount: 2, itemBuilder: (_, index) => VerticalJInternshipCard(companyLogo: JImages.nvidia, companyName: 'Nvidia', internshipTitle: "Database Engineer",location: 'Douala', jobType: 'Internship', saved: true, )),

            ],
          ),
        ),
      ),
    );
  }
}
