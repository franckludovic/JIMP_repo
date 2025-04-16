import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/data/repositories/applicant/applicant_repository.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/applicant_details/applicants_details.dart';
import 'package:project_bc_tuto/features/Applications/models/applicant_model.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ApplicantTile extends StatelessWidget {
  final double percent;
  final ApplicantModel applicant;

  const ApplicantTile({
    Key? key,
    required this.percent,
    required this.applicant,
  }) : super(key: key);

  // Function to fetch job title from Firestore based on jobId
  Future<String?> _getJobTitle(String jobId) async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('jobPostings') // Replace with your actual collection name if different
          .doc(jobId)
          .get();
      if (doc.exists && doc.data() != null) {
        final data = doc.data()!;
        return data['title'] as String?;
      }
      return null;
    } catch (e) {
      print('Error fetching job title: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine progress color based on percentage
    Color progressColor;
    if (percent < 0.30) {
      progressColor = Colors.red;
    } else if (percent >= 0.31 && percent < 0.49) {
      progressColor = Colors.orangeAccent;
    } else if (percent >= 0.50 && percent < 0.80) {
      progressColor = Colors.green.shade700;
    } else {
      progressColor = JColors.primary;
    }

    return GestureDetector(
      onTap: () => Get.to(() => ApplicantsDetails(applicant: applicant)),
      child: JRoundedContainer(
        height: 115,
        padding: EdgeInsets.symmetric(horizontal: JSizes.sm),
        margin: EdgeInsets.symmetric(vertical: JSizes.sm),
        showBorder: true,
        borderColor: Colors.black,
        backgroundColor: JColors.lightGrey,
        width: double.infinity,
        child: Row(
          children: [
            JRoundedImage(
              isNetworkImage: true,
              imageUrl: applicant.profileImageUrl ?? JImages.user3,
              border: Border.all(color: Colors.black, width: 2.5),
              borderRadius: 70,
              width: 70,
              height: 70,
            ),
            SizedBox(width: JSizes.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    applicant.fullName,
                    style: TextStyle(
                      color: JColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Display job title using a FutureBuilder
                  FutureBuilder<String?>(
                    future: ApplicantRepository.instance.getJobTitleById(applicant.jobId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          "Loading job title...",
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          "Error loading job",
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                        );
                      } else {
                        final jobTitle = snapshot.data ?? "Job not found";
                        return Text(
                          jobTitle,
                          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        "Match",
                        style: TextStyle(
                          color: JColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: LinearPercentIndicator(
                          animation: true,
                          lineHeight: 10.0,
                          animationDuration: 2000,
                          percent: percent,
                          barRadius: Radius.circular(10),
                          progressColor: progressColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        "${(percent * 100).toStringAsFixed(0)}%",
                        style: TextStyle(
                          color: JColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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
