import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

Future<DateTime?> showScheduleDialog(BuildContext context, ApplicantModel applicant) async {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  return await showDialog<DateTime>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Schedule Interview"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: dateController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Pick a date"),
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now().add(Duration(days: 1)),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  selectedDate = picked;
                  dateController.text = picked.toLocal().toString().split(' ')[0];
                }
              },
            ),
            SizedBox(height: JSizes.spaceBtwInputFields),
            TextField(
              controller: timeController,
              readOnly: true,
              decoration: InputDecoration(labelText: "Pick a time"),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  selectedTime = picked;
                  timeController.text = picked.format(context);
                }
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(null), // explicitly return null
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (selectedDate != null && selectedTime != null) {
                final combined = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  selectedTime!.hour,
                  selectedTime!.minute,
                );
                Navigator.of(context).pop(combined); // return the datetime
              } else {
                Get.snackbar("Missing Info", "Please select both date and time.");
              }
            },
            child: Text("Confirm"),
          ),
        ],
      );
    },
  );
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
    final applicantController = Get.put(ApplicantController());
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
                          "Applied ${getTimeAgo(applicant.appliedAt!)}",
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
                      backgroundColor: JColors.primary,
                      side: BorderSide(color: JColors.primary),
                    ),
                    onPressed: () {
                      ApplicantController.instance.updateApplicationStatus(
                        applicantId: applicant.id,
                        newStatus: ApplicantApplicationStatus.accepted,
                      );
                      Get.snackbar('Accepted Application ', 'You successfully Accepted this application.',
                          snackPosition: SnackPosition.BOTTOM);
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

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: JSizes.md * 0.9,
                        vertical: JSizes.md * 0.8,
                      ),
                      backgroundColor: JColors.error,
                      side: BorderSide(color: JColors.error),
                    ),
                    onPressed: () {
                      ApplicantController.instance.updateApplicationStatus(
                        applicantId: applicant.id,
                        newStatus: ApplicantApplicationStatus.rejected,
                      );
                      Get.snackbar('Rejected Application', 'You successfully Rejected this application.',
                          snackPosition: SnackPosition.BOTTOM);
                    },

                    child: Text(
                      "REJECT",
                      style: TextStyle(
                        fontSize: 20,
                        color: JColors.black,
                        fontFamily: 'Poppins',
                      ),
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
                    onPressed: () async {
                      if (isSheduled) {
                        // Cancel interview
                        final controller = ApplicantController.instance;
                        controller.updateApplicationStatus(
                          applicantId: applicant.id,
                          newStatus: ApplicantApplicationStatus.pending,
                        );
                        Get.snackbar("Interview Canceled", "Status reset to Pending");
                      } else {
                        final DateTime? selectedDate = await showScheduleDialog(context, applicant);
                        if (selectedDate != null) {
                          ApplicantController.instance.scheduleInterview(
                            applicantId: applicant.id,
                            scheduledDateTime: selectedDate,
                          );
                          Get.snackbar('Interview Scheduled', 'You successfully scheduled an interview.',
                              snackPosition: SnackPosition.BOTTOM);
                        }
                      }
                    },
                    child: isSheduled
                        ? Text("Cancel Interview",
                        style: TextStyle(
                            fontSize: 20,
                            color: JColors.error,
                            fontFamily: 'Poppins'))
                        : Text("Interview",
                        style: TextStyle(
                            fontSize: 20,
                            color: JColors.black,
                            fontFamily: 'Poppins')),
                  ),
                ],
              ),
              SizedBox(height: JSizes.spaceBtwItems),
              // Accept Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: JSizes.md * 0.3,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
