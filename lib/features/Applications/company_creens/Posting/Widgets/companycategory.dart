import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/Posting/Widgets/postings.dart';

import '../../../../../common/widgets/buttons/bottom_button.dart';
import '../../../../../common/widgets/layout/grid_layout.dart';
import '../../../../../utils/constants/sizes.dart';

class JCompanyCategory extends StatelessWidget {
  const JCompanyCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        const SizedBox(height: JSizes.spaceBtwItems),
        JSectionHeading(title: "Best Applications", onPressed: () {}),
        Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              // JGridLayout(
              //   itemCount: 5,
              //   mainAxisExtend: 250,
              //   crossAxisCount: 1,
              //   itemBuilder: (_, index) => JobPostCard(),
              // ),
              const SizedBox(height: JSizes.spaceBtwItems),


              ///application

              Jbutton(buttonTitle: "Show more", borderRadius: 24, padding: 12),

            ],
          ),
        ),
      ],
    );
  }
}
