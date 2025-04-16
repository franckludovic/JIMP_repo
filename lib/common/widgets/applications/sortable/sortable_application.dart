import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import '../../../../features/Applications/controllers/posting_controller.dart';
import '../../../../utils/constants/sizes.dart';
import '../../job_and_internship_card/final_vertical_postings_card.dart';
import '../../layout/grid_layout.dart';

class JSortableApplications extends StatelessWidget {
  const JSortableApplications({
    Key? key,
    this.saves = false,
    required this.company,
  }) : super(key: key);

  final bool saves;
  final CompanyModel company;

  @override
  Widget build(BuildContext context) {
    final PostingController controller = Get.put(PostingController());

    // Fetch postings for the company
    controller.loadCompanyPostings(company.id);

    return Column(
      children: [
        // DropDown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
          onChanged: (value) {},
          items: [
            'Name',
            'Higher Price',
            'Lower Price',
            'Sale',
            'Newest',
            'Popularity'
          ]
              .map((option) =>
              DropdownMenuItem(value: option, child: Text(option)))
              .toList(),
        ),
        const SizedBox(height: JSizes.spaceBtwSections),
        // Applications
        Obx(() {
          return JGridLayout(
            itemCount: controller.companyPosts.length,
            crossAxisCount: 2,
            itemBuilder: (_, index) {
              final posting = controller.companyPosts[index];
              return VerticalPostingCard(posting: posting);
            },
          );
        }),
      ],
    );
  }
}
