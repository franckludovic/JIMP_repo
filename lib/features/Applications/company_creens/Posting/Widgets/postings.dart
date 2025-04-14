import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/Jcircular_image.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/posting_creations.dart';
import 'package:intl/intl.dart';

import '../../../../personilization/controllers/company_controller.dart';

class JobPostCard extends StatelessWidget {
  final PostingModel posting;
  final int applicantCount;

  const JobPostCard({
    super.key,
    required this.posting,
    this.applicantCount = 0,
  });

  String getRemainingDays() {
    final now = DateTime.now();
    final difference = posting.deadline.difference(now);
    if (difference.inDays > 0) {
      return "${difference.inDays} day${difference.inDays > 1
          ? 's'
          : ''} remaining";
    } else {
      return "Expired";
    }
  }

  /// Formats a Timestamp or DateTime into a readable date
  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyController());
    final controllerss = Get.put(PostingController());

    return JRoundedContainer(
      height: 250,
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [

                JRoundedImage(imageUrl: controller.user?.logoUrl ?? '',
                  isNetworkImage: true,
                  padding: EdgeInsets.all(0),
                  width: 85,
                  height: 85,
                  applyImageRadius: true,
                  borderRadius: 15,),

                const SizedBox(width: JSizes.sm),

                // Job title and created date.
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Job title:
                      Text(
                        posting.jobTitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Display Created on date:
                      Text(
                        "Created on ${formatDate(posting.createdAt.toDate())}",
                        style: TextStyle(color: JColors.darkGrey, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: JSizes.sm),
            // Posting detail section (e.g., deadline and applicant count)
            Row(
              children: [
                Expanded(
                  child: Text(
                    getRemainingDays(),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                // Optionally display number of applications
                if (applicantCount > 0)
                  Text(
                    "$applicantCount applied",
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
              ],
            ),
            const Spacer(),
            // Bottom Buttons: DROP and EDIT
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Delete button:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: JSizes.lg, vertical: JSizes.sm),
                      backgroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Confirm Delete",
                        middleText:
                        "Are you sure you want to delete this posting?",
                        confirm: ElevatedButton(
                          onPressed: () {
                            controllerss.deletePosting(posting.id);
                            Get.back();
                          },
                          child: const Text("Delete"),
                        ),
                        cancel: OutlinedButton(
                          onPressed: () => Get.back(),
                          child: const Text("Cancel"),
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Text(
                          "DROP",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: JSizes.sm),
                        Icon(Icons.delete_forever,
                            size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                  const SizedBox(width: JSizes.xl),
                  // Edit button: Navigates to the posting review/edit page.
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: JSizes.lg, vertical: JSizes.sm),
                      backgroundColor: JColors.primary,
                    ),
                    onPressed: () => Get.to(() => JobCreationPage()),
                    child: Row(
                      children: const [
                        Text(
                          "EDIT",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: JSizes.sm),
                        Icon(Iconsax.edit, size: 30, color: Colors.black),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
