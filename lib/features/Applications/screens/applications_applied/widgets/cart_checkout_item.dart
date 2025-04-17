import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/shimerEffect.dart';
import '../../../../../data/repositories/applicant/applicant_repository.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../models/applicant_model.dart';

class ApplicationCard extends StatelessWidget {
  const ApplicationCard({super.key, required this.application});

  final ApplicantModel application;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: JSizes.sm,
        horizontal: JSizes.md * 0.3,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo
            FutureBuilder<String?>(
              future: ApplicantRepository.instance.getCompanyLogoById(application.companyId ?? ''),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Icon(Icons.business_rounded, color: JColors.primary, size: 40);
                } else {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(JSizes.borderRadiusLg),
                    child: CachedNetworkImage(
                      imageUrl: snapshot.data!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const JShimmerEffect(
                        width: 55,
                        height: 55,
                        radius: 55,
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.business_rounded,
                        color: JColors.primary,
                        size: 40,
                      ),
                    ),
                  );
                }
              },
            ),

            const SizedBox(width: 12),

            // Text info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: ApplicantRepository.instance.getJobTitleById(application.jobId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          "Loading job title...",
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        );
                      } else if (snapshot.hasError || !snapshot.hasData) {
                        return const Text(
                          "Job not found",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        );
                      } else {
                        return Text(
                          snapshot.data!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Status: ${application.status.name.capitalizeFirst}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  if (application.status == ApplicantApplicationStatus.interviewScheduled &&
                      application.interviewSchedule != null)
                    Text(
                      'Interview on: ${DateFormat('EEEE, MMM d, y • h:mm a').format(application.interviewSchedule!)}',
                      style: const TextStyle(fontSize: 14),
                    ),
                  Text(
                    'Applied on: ${DateFormat.yMMMd().format(application.appliedAt!)}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            // Status Icon
            _statusIcon(application.status),
          ],
        ),
      ),
    );
  }
}

Icon _statusIcon(ApplicantApplicationStatus status) {
  switch (status) {
    case ApplicantApplicationStatus.accepted:
      return const Icon(Icons.check_circle, color: Colors.green);
    case ApplicantApplicationStatus.rejected:
      return const Icon(Icons.cancel, color: Colors.red);
    case ApplicantApplicationStatus.interviewScheduled:
      return const Icon(Icons.calendar_today, color: Colors.blue);
    default:
      return const Icon(Icons.hourglass_empty, color: Colors.orange);
  }
}

