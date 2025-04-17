import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../features/Applications/models/applicant_model.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../Images/rounded_image.dart';
import '../../texts/applications_title_text.dart';
import '../../texts/compagny_title_with_verified_icon.dart';
import 'add_remove_button.dart';

class JAppliedCard extends StatelessWidget {
  /// The applicant record (contains status, appliedAt, etc.)
  final ApplicantModel applicant;

  /// The job/posting title
  final String jobTitle;

  /// The company’s display name
  final String companyName;

  /// The company’s logo URL
  final String companyLogoUrl;

  /// Optional callbacks (e.g. view details, withdraw application)
  final VoidCallback? onViewDetails;
  final VoidCallback? onWithdraw;

  const JAppliedCard({
    Key? key,
    required this.applicant,
    required this.jobTitle,
    required this.companyName,
    required this.companyLogoUrl,
    this.onViewDetails,
    this.onWithdraw,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert enum to uppercase string
    final statusStr = describeEnum(applicant.status).toUpperCase();

    // Pick an icon & color for each status
    IconData statusIcon;
    Color statusColor;
    switch (applicant.status) {
      case ApplicantApplicationStatus.accepted:
        statusIcon = Iconsax.tick_circle;
        statusColor = Colors.green;
        break;
      case ApplicantApplicationStatus.rejected:
        statusIcon = Iconsax.close_circle;
        statusColor = Colors.red;
        break;
      case ApplicantApplicationStatus.interviewScheduled:
        statusIcon = Iconsax.calendar_tick;
        statusColor = Colors.blue;
        break;
      case ApplicantApplicationStatus.underReview:
        statusIcon = Iconsax.search_status;
        statusColor = Colors.orange;
        break;
      case ApplicantApplicationStatus.pending:
      default:
        statusIcon = Iconsax.clock;
        statusColor = Colors.amber;
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company logo
            JRoundedImage(
              imageUrl: companyLogoUrl,
              width: 64,
              height: 64,
              padding: const EdgeInsets.all(JSizes.sm / 2),
              backgroundColor: JHelperFunctions.isDarkMode(context)
                  ? JColors.darkerGrey
                  : JColors.grey,
            ),

            const SizedBox(width: JSizes.spaceBtwItems),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company name + verified icon
                  JCompagnyTittleVerifications(
                    title: companyName,
                    compagnyTextSize: TextSizes.large,
                  ),

                  // Job title
                  JApplicationTitleText(
                    title: jobTitle,
                    maxLines: 2,
                  ),

                  // Status row
                  Row(
                    children: [
                      Icon(statusIcon, color: statusColor, size: 20),
                      const SizedBox(width: JSizes.xs),
                      Text(
                        statusStr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: statusColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: JSizes.spaceBtwItems),

        // Action buttons (e.g. View Details, Withdraw)
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (onViewDetails != null)
              TextButton(
                onPressed: onViewDetails,
                child: const Text('View Details'),
              ),
            if (onWithdraw != null)
              TextButton(
                onPressed: onWithdraw,
                child: const Text('Withdraw'),
              ),
          ],
        ),

        const SizedBox(height: JSizes.xxs),
        const Divider(thickness: 1.5),
        const SizedBox(height: JSizes.spaceBtwSections),
      ],
    );
  }
}
