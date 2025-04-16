import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import 'package:intl/intl.dart';

import '../../../features/Applications/controllers/posting_controller.dart';
import '../../../features/Applications/models/posting_model.dart';
import '../../../features/Applications/screens/Applicaton_details/application_details.dart';
import '../../../features/personilization/controllers/company_controller.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../icons/jsaveicon.dart';
import '../shimmer/shimerEffect.dart';

class HorizontalJPostingCard extends StatelessWidget {
  const HorizontalJPostingCard({
    super.key,
    required this.posting,
    this.backgroundColor,
    this.onTap,
    this.saved = false,
    this.borderRadius = JSizes.borderRadiusLg,
    this.iconBorderRad = JSizes.md, this.user,
  });

  final PostingModel posting;
  final UserModel? user;
  final Color? backgroundColor;
  final bool saved;
  final VoidCallback? onTap;
  final double borderRadius;
  final double iconBorderRad;



  @override
  Widget build(BuildContext context) {
    final isDark = JHelperFunctions.isDarkMode(context);
    final controller = Get.put(PostingController());

    final time = posting.deadline.difference(DateTime.now()).inHours.isLowerThan(1) ;

    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => JobDetailsPage(posting: posting)),
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(vertical: JSizes.spaceBtwItems / 2),
        decoration: BoxDecoration(
          color: time
          ?JColors.success.withAlpha((0.1 * 255).toInt())
          : backgroundColor ??
              (isDark
                  ? JColors.darkerGrey
                  : JColors.primary.withAlpha((0.2 * 255).toInt())),
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha((0.1 * 255).toInt()),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Main Content
            Padding(
              padding: const EdgeInsets.all(JSizes.md),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Logo
                  _buildCompanyLogo(isDark),
                  const SizedBox(width: JSizes.spaceBtwItems),
                  // Job Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleSection(context),
                        const SizedBox(height: JSizes.spaceBtwItems / 2),
                        _buildMetaDataSection(context, isDark),
                        const SizedBox(height: JSizes.spaceBtwItems / 2),
                        _buildSkillsSection(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: JSizes.md,
              left: JSizes.md,
              right: JSizes.md,
              child: _buildBottomRow(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompanyLogo(bool isDark) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: isDark ? JColors.dark : JColors.white,
        borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
      ),
      //padding: const EdgeInsets.all(JSizes.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          color: backgroundColor,
          imageUrl: posting.companyLogo,
          progressIndicatorBuilder: (context, url, downloadProgress) => const JShimmerEffect(width: 55, height: 55, radius: 55,),
          errorWidget: (context, url, error) =>const Icon(Icons.business_rounded, color: JColors.primary, size: 40,),
        )
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          posting.companyName,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: JColors.darkGrey,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: JSizes.xs),
        Text(
          posting.jobTitle,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }



  Widget _buildMetaDataSection(BuildContext context, bool isDark) {
    final List<String> location =  posting.location.split(',').map((item) => item.trim()).toList();

    return Wrap(
      spacing: JSizes.xs,
      runSpacing: JSizes.xs,
      children: [
        if(posting.location != "" )_buildMetaItem(context, Icons.location_on_outlined, location[1] ?? ''),
        if (posting.jobCategory != 'Internship' && posting.salaryRange != null)
          _buildMetaItem(context, Icons.attach_money, posting.salaryRange!),
        if (posting.jobCategory == 'Internship' && posting.duration != null)
          _buildMetaItem(context, Icons.timer_outlined, posting.duration!),
      ],
    );
  }

  Widget _buildMetaItem(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: JColors.primary),
        const SizedBox(width: JSizes.xs),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: JColors.darkGrey,
              ),
        ),
      ],
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ListView.builder(
          itemCount: 1,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            return Wrap(
              spacing: JSizes.sm,
              runSpacing: 0,
              children: posting.requiredSkills
                  .map((skill) => Chip(
                        label: Text(skill),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ))
                  .toList(),
            );
          }),
    );
  }

  String getRemainingDays() {
    final now = DateTime.now();
    final difference = posting.deadline.difference(now);
    if (difference.inHours > 24 ) {
      return "${difference.inDays} day${difference.inDays > 1 ? 's' : ''} remaining";
    } else if (difference.inHours < 24 && difference.inHours >= 1) {
      return "${difference.inHours} Hour${difference.inHours > 1 ? 's' : ''} remaining";
    } else {
      return "Expired";
    }
  }

  Widget _buildBottomRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Chip(
          label: Text(posting.opportunityType),
          backgroundColor: Colors.blueAccent.withAlpha((0.1 * 255).toInt()),
          labelStyle: const TextStyle(color: Colors.blueAccent),
        ),
        if (posting.deadline.difference(DateTime.now()).inHours < 0)
          Text(
           'Expired'
          )
        else
          SizedBox(width:125 ,child: Text("${getRemainingDays()}    ", maxLines: 1, overflow: TextOverflow.ellipsis,)),
          _buildSaveButton(context),
      ],



    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return JRoundedContainer(
        radius: 10,
        child: JSaveIcon(postingId: posting.id),
    );
  }
}
