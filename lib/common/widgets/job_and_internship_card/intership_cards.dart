import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import 'package:intl/intl.dart';

import '../../../features/Applications/screens/Applicaton_details/application_details.dart';

class HorizontalJIntershipCard extends StatelessWidget {
  const HorizontalJIntershipCard({
    super.key,
    required this.companyLogo,
    required this.companyName,
    required this.jobTitle,
    required this.location,
    required this.duration,
    required this.skills,
    this.salary,
    this.jobType,
    this.backgroundColor,
    this.onTap,
    this.saved = false,
    this.isCompleted = false,
    this.deadline,
    this.borderRadius = JSizes.borderRadiusLg,
    this.iconBorderRad = JSizes.md,
  });

  final String companyLogo;
  final String companyName;
  final String jobTitle;
  final String location;
  final String duration;
  final String? salary;
  final String? jobType;
  final Color? backgroundColor;
  final List<String> skills;
  final bool saved;
  final VoidCallback? onTap;
  final bool isCompleted;
  final DateTime? deadline;
  final double borderRadius;
  final double iconBorderRad;

  @override
  Widget build(BuildContext context) {
    final isDark = JHelperFunctions.isDarkMode(context);
    final now = DateTime.now();
    final daysRemaining =
    deadline?.difference(now).inDays;

    return GestureDetector(
      onTap: onTap ?? () => Get.to(() => const JMyApplicationDetails()),
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(
            vertical: JSizes.spaceBtwItems / 2),
        decoration: BoxDecoration(
          color: backgroundColor ??
              (isDark ? JColors.darkerGrey : JColors.light),
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
                        // Company & Job Title
                        _buildTitleSection(context),
                        const SizedBox(
                            height: JSizes.spaceBtwItems / 2),

                        // Metadata
                        _buildMetaDataSection(context, isDark),
                        const SizedBox(
                            height: JSizes.spaceBtwItems / 2),

                        // Skills
                        _buildSkillsSection(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Save Button
            Positioned(
              top: JSizes.md,
              right: JSizes.md,
              child: _buildSaveButton(context),
            ),

            // Deadline/Days Remaining
            if (daysRemaining != null && daysRemaining > 0)
              Positioned(
                bottom: JSizes.md,
                right: JSizes.md,
                child: _buildDeadlineBadge(context, daysRemaining),
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
        borderRadius: BorderRadius.circular(JSizes.borderRadiusMd),
      ),
      padding: const EdgeInsets.all(JSizes.sm),
      child: Image.asset(
        companyLogo,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => Icon(
          Icons.business_rounded,
          color: JColors.primary,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildTitleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          companyName,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: JColors.darkGrey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: JSizes.xs),
        Text(
          jobTitle,
          style: Theme.of(context).textTheme.titleLarge,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildMetaDataSection(BuildContext context, bool isDark) {
    return Wrap(
      spacing: JSizes.xs,
      runSpacing: JSizes.xs,
      children: [
        _buildMetaItem(context, Icons.location_on_outlined, location),
        if (jobType != null)
          _buildMetaItem(context, Icons.business_center, jobType!),
        if (salary != null)
          _buildMetaItem(context, Icons.attach_money, salary!),
        _buildMetaItem(context, Icons.timer_outlined, duration),
      ],
    );
  }

  Widget _buildMetaItem(
      BuildContext context, IconData icon, String text) {
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
    return Wrap(
      spacing: JSizes.sm,
      runSpacing: 0,
      children: skills
          .map((skill) => Chip(
        label: Text(skill),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ))
          .toList(),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        saved ? Icons.bookmark : Icons.bookmark_border,
        color: saved ? JColors.warning : JColors.darkGrey,
      ),
      onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
          Text(saved ? "Removed from saved" : "Added to saved"),
        ),
      ),
    );
  }

  Widget _buildDeadlineBadge(BuildContext context, int days) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: JSizes.sm,
        vertical: JSizes.xs,
      ),
      decoration: BoxDecoration(
        color: days < 7
            ? JColors.error.withAlpha((0.2 * 255).toInt())
            : JColors.success.withAlpha((0.2 * 255).toInt()),
        borderRadius: BorderRadius.circular(JSizes.borderRadiusSm),
      ),
      child: Text(
        "$days days left",
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: days < 7 ? JColors.error : JColors.success,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
