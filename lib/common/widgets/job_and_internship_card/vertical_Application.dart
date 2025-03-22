import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/application_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../styles/shadow.dart';
import '../Images/rounded_image.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../texts/applications_title_text.dart';
import '../texts/compagny_title_with_verified_icon.dart';
import '../../../utils/constants/sizes.dart';


class VerticalJInternshipCard extends StatelessWidget {
  const VerticalJInternshipCard({
    super.key,
    required this.companyLogo,
    required this.internshipTitle,
    required this.companyName,
    required this.location,
    required this.jobType,
    this.saved = false,
  });

  final String companyLogo;
  final String internshipTitle;
  final String companyName;
  final String location;
  final String jobType;
  final bool saved;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => const JMyApplicationDetails()),
      child: SizedBox(
        width: 165,
        child: Container(
          padding: const EdgeInsets.all(JSizes.sm),
          decoration: BoxDecoration(
            boxShadow: [ShadowStyle.verticalApplicationShadow],
            borderRadius: BorderRadius.circular(JSizes.applicationImageRadius),
            color: dark ? JColors.darkGrey : JColors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Section: Logo
              JRoundedContainer(
                height: 130,
                width: double.infinity,
                padding: const EdgeInsets.all(JSizes.md),
                margin: const EdgeInsets.only(bottom: JSizes.sm),
                backgroundColor: dark ? JColors.dark : JColors.grey,
                child: JRoundedImage(
                  imageUrl: companyLogo,
                  applyImageRadius: true,
                  fit: BoxFit.contain,
                ),
              ),

              // Middle Section: Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JApplicationTitleText(
                    title: internshipTitle,
                    textSize: 20,
                    maxLines: 2,
                  ),
                  const SizedBox(height: JSizes.spaceBtwItems / 4),
                  Row(
                    children: [
                      Icon(Iconsax.location,
                          size: 14,
                          color: dark ? JColors.lightGrey : JColors.darkGrey),
                      const SizedBox(width: JSizes.xs),
                      Flexible(
                        child: Text(location,
                            style: Theme.of(context).textTheme.bodySmall,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ],
              ),

              // Bottom Section: Company & Save
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Company Name & Job Type
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            JCompagnyTittleVerifications(title: companyName, ),
                            const SizedBox(height: JSizes.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: JSizes.sm, vertical: 2),
                              decoration: BoxDecoration(
                                color: JColors.primary.withAlpha((0.2 * 255).toInt()),
                                borderRadius: BorderRadius.circular(JSizes.xs),
                              ),
                              child: Text(jobType,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(color: JColors.primary)),
                            ),
                          ],
                        ),
                      ),

                      // Save Button
                      Container(
                        decoration: BoxDecoration(
                          color: dark ? JColors.dark : JColors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha((0.1 * 255).toInt()),
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(saved ? Icons.bookmark : Icons.bookmark_border,
                              color: saved ? JColors.warning : JColors.primary),
                          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(saved ? "Removed from saved" : "Added to saved"),
                        ),
                      ),
                          padding: EdgeInsets.zero,
                          iconSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}