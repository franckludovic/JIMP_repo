import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import '../../../features/Applications/screens/Applicaton_details/my_application_details.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class HorizontalJIntershipCard extends StatelessWidget {
  const HorizontalJIntershipCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.duration,
    required this.skills,
    this.backgroundColor,
    this.onTap,
    this.saved = false,
  });

  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String location;
  final String duration;
  final Color? backgroundColor;
  final List<String> skills;
  final bool saved;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => const MyApplicationDetails()),
      child: Stack(
        children: [
          // Internship Card
          Container(
            height: 200,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: backgroundColor ??
                  (JHelperFunctions.isDarkMode(context)
                      ? JColors.grey
                      : JColors.secondary.withAlpha((0.1 * 255).toInt())),
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withAlpha((0.1 * 255).toInt()),
                  blurRadius: 5,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Company Logo
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    companyLogo,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.business, color: Colors.grey),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 12),

                // Job Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        jobTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Skills:  ${skills.join(", ")}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: JColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Save Button Positioned at Bottom-Left
          Positioned(
            bottom: 2.5, // Distance from bottom
            right: 3, // Distance from left
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: JColors.dark,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(JSizes.iconXs),
                  bottomRight: Radius.circular(JSizes.iconSm),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Icon(
                  Iconsax.save_21,
                  color: saved ? Colors.yellow : JColors.white,
                  size: 32,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
