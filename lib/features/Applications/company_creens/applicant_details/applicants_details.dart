import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/Percentage%20indicator/line_percentage_indicator.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/companies/desciption_info_tile.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/personilization/controllers/user_controller.dart';
import 'package:project_bc_tuto/features/personilization/screens/settings/resume_page.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../../../data/repositories/applicant/applicant_repository.dart';
import '../../controllers/applicant_controller.dart';
import '../../models/applicant_model.dart';
import '../../models/user_model.dart';

/// Helper function to compute elapsed time in a friendly format.
String getTimeAgo(DateTime date) {
  final diff = DateTime.now().difference(date);
  if(diff.inDays >= 1) {
    return "${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago";
  } else if(diff.inHours >= 1) {
    return "${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago";
  } else if(diff.inMinutes >= 1) {
    return "${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago";
  } else {
    return "Just now";
  }
}

/// Function to fetch job title from Firestore given a jobId.
Future<String?> getJobTitleById(String jobId) async {
  try {
    final doc = await FirebaseFirestore.instance
        .collection('postings') // Change the collection name if needed.
        .doc(jobId)
        .get();
    if (doc.exists && doc.data() != null) {
      final data = doc.data()!;
      return data['jobTitle'] as String?;
    } else {
      return null;
    }
  } catch (e) {
    print("Error fetching job title: $e");
    return null;
  }
}

class ApplicantsDetails extends StatelessWidget {
  final ApplicantModel applicant;
  final bool isSheduled;

  const ApplicantsDetails({
    Key? key,
    required this.applicant,
    this.isSheduled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    // Determine match percentage: if matchScore is provided use it, otherwise default to 0.75.
    final double matchPercent = (applicant.matchScore ?? 0.75);

    return Scaffold(
      appBar: JAppbar(
          showBackArrow: true,
          title: Text(
            "Applicant Details",
            style: Theme.of(context).textTheme.headlineMedium,
          )
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace * 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Fetch and display the job title from the jobId:
              FutureBuilder<String?>(
                future: getJobTitleById(applicant.jobId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "Loading job title...",
                      style: TextStyle(
                        color: dark ? JColors.white : JColors.black,
                        fontSize: 15,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (snapshot.hasError || snapshot.data == null) {
                    return Text(
                      "Job Title Not Found",
                      style: TextStyle(
                        color: dark ? JColors.white : JColors.black,
                        fontSize: 30,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text(
                      snapshot.data!,
                      style: TextStyle(
                        color: dark ? JColors.white : JColors.black,
                        fontSize: 25,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: JSizes.spaceBtwSections * 0.6),
              // Display applicant name and applied time
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column with textual info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Applicant Name
                        Text(
                          applicant.fullName,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: dark ? JColors.white : JColors.black,
                            fontSize: 25,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Applied time (calculated from appliedAt)
                        Text(
                          "Applied ${getTimeAgo(applicant.appliedAt.toDate())}",
                          style: TextStyle(
                            color: JColors.darkGrey,
                            fontSize: 15,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: JSizes.md * 1.5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                vertical: JSizes.md * 0.7,
                                horizontal: JSizes.md),
                          ),
                          onPressed: () async {
                            try {
                              final userDoc = await FirebaseFirestore.instance
                                  .collection("candidates") // or "companies" if applicable
                                  .doc(applicant.userId)
                                  .get();

                              if (userDoc.exists) {
                                final userModel = UserModel.fromSnapshot(userDoc);
                                Get.to(() => ResumePage(user: userModel));
                              } else {
                                Get.snackbar("User not found", "Unable to load resume.");
                              }
                            } catch (e) {
                              Get.snackbar("Error", "Failed to load resume: $e");
                            }
                          },
                          child: Text(
                            "View Resume",
                            style: TextStyle(
                              color: JColors.grey,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Applicant image
                  JRoundedImage(
                    isNetworkImage: true,
                    imageUrl: applicant.profileImageUrl ?? JImages.user2,
                    height: 125,
                    width: 125,
                  )
                ],
              ),
              SizedBox(height: JSizes.spaceBtwSections),
              // Display Match Percentage
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Matched",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    "${(matchPercent * 100).toStringAsFixed(0)}%",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
              SizedBox(
                child: LinePercentageIndidctor(
                  percent: matchPercent,
                  width: JDeviceUtils.getScreenWidth(context) - 40,
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections),
              // Cover Letter Section
              JRoundedContainer(
                padding: EdgeInsets.all(JSizes.md),
                child: SizedBox(
                  child: InfoTile(
                    numberLines: 18,
                    title: "Cover Letter:",
                    textColor: JColors.black,
                    titleColor: JColors.black,
                    textBody: applicant.coverLetterUrl != null && applicant.coverLetterUrl!.isNotEmpty
                        ? applicant.coverLetterUrl!
                        : "No cover letter provided.",
                  ),
                ),
              ),
              SizedBox(height: JSizes.spaceBtwSections),
              // Message and Schedule/Cancel Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: JSizes.md * 0.9,
                        vertical: JSizes.md * 0.8,
                      ),
                      backgroundColor: Colors.green,
                      side: BorderSide(color: Colors.green),
                    ),
                    onPressed: () {
                      // Navigate to messaging screen or open chat functionality
                    },
                    child: Text(
                      "Message",
                      style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: JSizes.md * 0.9,
                        vertical: JSizes.md * 0.8,
                      ),
                      backgroundColor: JColors.grey,
                      side: BorderSide(color: JColors.grey),
                    ),
                    onPressed: () {
                      // Schedule or Cancel Interview action
                    },
                    child: isSheduled
                        ? Text(
                      "Cancel Interview",
                      style: TextStyle(
                        fontSize: 20,
                        color: JColors.error,
                        fontFamily: 'Poppins',
                      ),
                    )
                        : Text(
                      "Schedule Interview",
                      style: TextStyle(
                        fontSize: 20,
                        color: JColors.black,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: JSizes.spaceBtwItems),
              // Accept Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: JSizes.xxl * 1.5,
                      vertical: JSizes.md * 0.8,
                    ),
                    backgroundColor: JColors.primary,
                    side: BorderSide(color: JColors.primary),
                  ),
                  onPressed: () {
                    final controller = ApplicantController.instance;
                    controller.updateApplicationStatus(applicant.id, ApplicantApplicationStatus.accepted);
                  },

                  child: Text(
                    "ACCEPT",
                    style: TextStyle(
                      fontSize: 20,
                      color: JColors.black,
                      fontFamily: 'Poppins',
                    ),
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
