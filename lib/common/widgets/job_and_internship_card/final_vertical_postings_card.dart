import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/Jcircular_image.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/application_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../features/Applications/controllers/posting_controller.dart';
import '../../../features/Applications/models/posting_model.dart';
import '../../styles/shadow.dart';
import '../Images/rounded_image.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../icons/jsaveicon.dart';
import '../shimmer/shimerEffect.dart';
import '../texts/applications_title_text.dart';
import '../texts/compagny_title_with_verified_icon.dart';
import '../../../utils/constants/sizes.dart';

class VerticalPostingCard extends StatelessWidget {
  const VerticalPostingCard({
    super.key,
    this.saved = false,
    required this.posting,
    this.backgroundColor,
    this.onTap,
    this.borderRadius = JSizes.borderRadiusLg,
    this.iconBorderRad = JSizes.md,
  });

  final bool saved;
  final PostingModel posting;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final double borderRadius;
  final double iconBorderRad;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    final controller = Get.put(PostingController());

    final List<String> location =  posting.location.split(',').map((item) => item.trim()).toList();

    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => JobDetailsPage(posting: posting)),
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
                  margin: const EdgeInsets.only(bottom: JSizes.sm),
                  backgroundColor: dark ? JColors.dark : JColors.grey,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        color: backgroundColor,
                        imageUrl: posting.companyLogo,
                        progressIndicatorBuilder: (context, url, downloadProgress) => const JShimmerEffect(width: 55, height: 55, radius: 55,),
                        errorWidget: (context, url, error) =>const Icon(Icons.business_rounded, color: JColors.primary, size: 50,),
                      )
                  ),
              ),

              // Middle Section: Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JApplicationTitleText(
                    title: posting.jobTitle,
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
                        child:
                        Text(posting.location != "" ? location[1] : '',
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
                            JCompagnyTittleVerifications(
                              title: posting.companyName ?? " ",
                            ),
                            const SizedBox(height: JSizes.xs),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: JSizes.sm, vertical: 2),
                              decoration: BoxDecoration(
                                color: JColors.primary
                                    .withAlpha((0.2 * 255).toInt()),
                                borderRadius: BorderRadius.circular(JSizes.xs),
                              ),
                              child: Text(posting.opportunityType,
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
                              color:
                                  Colors.black.withAlpha((0.1 * 255).toInt()),
                              blurRadius: 4,
                              spreadRadius: 1,
                            )
                          ],
                        ),
                        child: JSaveIcon(postingId: posting.id,),
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


