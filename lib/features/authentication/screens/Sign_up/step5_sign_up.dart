import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/layout/matrix_layout.dart';
import 'package:project_bc_tuto/common/widgets/success_screen/success_screen.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';

import 'package:project_bc_tuto/features/authentication/screens/login/login.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';


import '../../controllers.onboarding/sign_up/sign_up_controller.dart';


class CandidateRegisterScreen5 extends StatefulWidget {
  const CandidateRegisterScreen5({super.key});

  @override
  State<CandidateRegisterScreen5> createState() => _CandidateRegisterScreen5State();
}

class _CandidateRegisterScreen5State extends State<CandidateRegisterScreen5> {
  int currentStep = 4;
  final SignupController controller = Get.find<SignupController>();

  /// Generic helper to show an edit dialog.
  /// [multiline] when true uses a multi-line TextField.
  void showEditDialog({
    required String fieldName,
    required String currentValue,
    required Function(String newValue) onUpdate,
    bool multiline = false,
  }) {
    final TextEditingController dialogController = TextEditingController(text: currentValue);
    Get.defaultDialog(
      title: "Edit $fieldName",
      content: Column(
        children: [
          TextField(
            controller: dialogController,
            maxLines: multiline ? 5 : 1,
            decoration: InputDecoration(
              labelText: fieldName,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              onUpdate(dialogController.text);
              Get.back();
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  /// Helper widget for an editable info row.
  Widget buildEditableInfoRow({
    required IconData leadingIcon,
    required String label,
    required String value,
    required VoidCallback onEdit,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(leadingIcon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              "$label: $value",
              style: const TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit, size: 18, color: JColors.primary),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  /// Helper widget to build an info card with a list of children.
  Widget buildInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: JColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget buildLargeInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: JColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: const Text(
          'Review & Finish',
          style: TextStyle(fontSize: 20),
        ),
        showBackArrow: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Section
              Container(
                padding: const EdgeInsets.all(10),
                width: 200,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundColor: Colors.grey[300],
                          child: controller.email.text.isNotEmpty
                              ? const Text(
                            "Profile",
                            style: TextStyle(color: Colors.black),
                          )
                              : const Text("No Image"),
                        ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Iconsax.edit),
                            onPressed: () {
                              showEditDialog(
                                fieldName: "Profile Picture URL",
                                currentValue: "",
                                onUpdate: (newValue) {
                                  // Update profile picture URL accordingly.
                                  Get.snackbar("Updated", "Profile picture updated");
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: JSizes.md),
                    Text(
                      "${controller.firstName.text} ${controller.lastName.text}",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: JSizes.sm),
                    // Social icons for GitHub, LinkedIn, and Portfolio.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            showEditDialog(
                              fieldName: "GitHub URL",
                              currentValue: controller.github.text,
                              onUpdate: (newValue) {
                                setState(() {
                                  controller.github.text = newValue;
                                });
                              },
                            );
                          },
                          icon: const Icon(FontAwesomeIcons.github, size: 35),
                        ),
                        IconButton(
                          onPressed: () {
                            showEditDialog(
                              fieldName: "LinkedIn URL",
                              currentValue: controller.linkedin.text,
                              onUpdate: (newValue) {
                                setState(() {
                                  controller.linkedin.text = newValue;
                                });
                              },
                            );
                          },
                          icon: const Icon(FontAwesomeIcons.linkedin, size: 35),
                        ),
                        IconButton(
                          onPressed: () {
                            showEditDialog(
                              fieldName: "Portfolio URL",
                              currentValue: controller.portfolio.text,
                              onUpdate: (newValue) {
                                setState(() {
                                  controller.portfolio.text = newValue;
                                });
                              },
                            );
                          },
                          icon: const Icon(FontAwesomeIcons.folder, size: 35),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Basic Information Card
              buildInfoCard(context, [
                buildEditableInfoRow(
                  leadingIcon: Icons.person,
                  label: "Name",
                  value: "${controller.firstName.text} ${controller.lastName.text}",
                  onEdit: () {
                    showEditDialog(
                      fieldName: "First Name",
                      currentValue: controller.firstName.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.firstName.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.email,
                  label: "Email",
                  value: controller.email.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Email",
                      currentValue: controller.email.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.email.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.phone,
                  label: "Phone",
                  value: controller.phoneNumber.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Phone",
                      currentValue: controller.phoneNumber.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.phoneNumber.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.lock,
                  label: "Password",
                  value: "********",
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Password",
                      currentValue: controller.password.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.password.text = newValue;
                        });
                      },
                    );
                  },
                ),
              ]),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Location & Education Card (with separate dialogs for each field)
              buildInfoCard(context, [
                buildEditableInfoRow(
                  leadingIcon: Icons.flag,
                  label: "Country",
                  value: controller.country.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Country",
                      currentValue: controller.country.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.country.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.map,
                  label: "Region",
                  value: controller.region.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Region",
                      currentValue: controller.region.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.region.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.location_city,
                  label: "City",
                  value: controller.city.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "City",
                      currentValue: controller.city.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.city.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.home,
                  label: "Local Address",
                  value: controller.localAddress.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Local Address",
                      currentValue: controller.localAddress.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.localAddress.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.school,
                  label: "Education",
                  value: "${controller.educationLevel.text} at ${controller.schoolAttended.text}",
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Education Level",
                      currentValue: controller.educationLevel.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.educationLevel.text = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.business,
                  label: "Job Preference",
                  value: controller.jobTypePreference.text,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Job Preference",
                      currentValue: controller.jobTypePreference.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.jobTypePreference.text = newValue;
                        });
                      },
                    );
                  },
                ),
              ]),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Opportunity Section
              buildInfoCard(context, [
                buildEditableInfoRow(
                  leadingIcon: Icons.work,
                  label: "Opportunity Type",
                  value: controller.opportunityType.value,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Opportunity Type",
                      currentValue: controller.opportunityType.value,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.opportunityType.value = newValue;
                        });
                      },
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.category,
                  label: "Job Category",
                  value: controller.jobCategory.value,
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Job Category",
                      currentValue: controller.jobCategory.value,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.jobCategory.value = newValue;
                        });
                      },
                    );
                  },
                ),
              ]),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Self Description & Resume Card
              buildInfoCard(context, [
                buildEditableInfoRow(
                  leadingIcon: Icons.text_snippet,
                  label: "Self Description",
                  value: controller.selfDescription.text.isNotEmpty
                      ? controller.selfDescription.text
                      : "Not provided",
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Self Description",
                      currentValue: controller.selfDescription.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.selfDescription.text = newValue;
                        });
                      },
                      multiline: true,
                    );
                  },
                ),
                buildEditableInfoRow(
                  leadingIcon: Icons.upload_file,
                  label: "Resume",
                  value: controller.resume.text.isNotEmpty
                      ? controller.resume.text
                      : "Not provided",
                  onEdit: () {
                    showEditDialog(
                      fieldName: "Resume URL",
                      currentValue: controller.resume.text,
                      onUpdate: (newValue) {
                        setState(() {
                          controller.resume.text = newValue;
                        });
                      },
                    );
                  },
                ),
              ]),

              const SizedBox(height: JSizes.spaceBtwItems),

              buildLargeInfoCard(context, [

                Text(
                  "Skills:",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                ),
                Text(
                  controller.skillEntries.isNotEmpty
                      ? controller.skillEntries
                      .map((s) => "${s.skill} (Lvl ${s.level})")
                      .join(" | ")
                      : "No skills provided",
                  style: const TextStyle(color: Colors.black),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, size: 18, color: JColors.primary),
                  onPressed: () {
                    // You can implement a dialog to edit skills if needed.
                    // For simplicity, we display a snackbar.
                    Get.snackbar("Edit Skills", "Implement skill editing dialog here");
                  },
                ),
              ]),


              const SizedBox(height: JSizes.spaceBtwItems),
              // Skills Section
             MatrixGrid(
               totalLenght: 2,
                 crossSpacing: 10,
                 items: [
                   buildInfoCard(context, [
                     Text(
                       "Hobbies:",
                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                     ),
                     Text(
                       controller.hobbies.isNotEmpty
                           ? controller.hobbies.join(" | ")
                           : "No hobbies provided",
                       style: const TextStyle(color: Colors.black),
                     ),
                     IconButton(
                       icon: const Icon(Icons.edit, size: 18, color: JColors.primary),
                       onPressed: () {
                         // Open dialog to edit hobbies (for simplicity, a comma-separated list)
                         showEditDialog(
                           fieldName: "Hobbies",
                           currentValue: controller.hobbies.join(", "),
                           onUpdate: (newValue) {
                             setState(() {
                               controller.hobbies.value = newValue.split(",").map((s) => s.trim()).toList();
                             });
                           },
                           multiline: true,
                         );
                       },
                     ),
                   ]),


                   // Languages Section
                   buildInfoCard(context, [
                     Text(
                       "Languages:",
                       style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.black),
                     ),
                     Text(
                       controller.languages.isNotEmpty
                           ? controller.languages
                           .map((l) => "${l.language} (Lvl ${l.proficiency})")
                           .join(" | ")
                           : "No languages provided",
                       style: const TextStyle(color: Colors.black),
                     ),
                     IconButton(
                       icon: const Icon(Icons.edit, size: 18, color: JColors.primary),
                       onPressed: () {
                         // You can implement a dialog to edit languages if needed.
                         Get.snackbar("Edit Languages", "Implement language editing dialog here");
                       },
                     ),
                   ]),
                 ]
             ),


              const SizedBox(height: JSizes.spaceBtwItems),
              // Terms & Conditions
              const TermandConditions(),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Finish Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 50),
                  ),


                  onPressed: () => controller.signupFinal(),
                  child: const Text(
                    "FINISH",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
        child: SizedBox(
          height: 50,
          child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
        ),
      ),
    );
  }
}
