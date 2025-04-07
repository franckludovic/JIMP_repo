import 'dart:core';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/layout/matrix_layout.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/skillAddDialog.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';

import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';


import '../../../../common/image_picker/imagepickerDialog.dart';
import '../../../../common/widgets/custom_wigets/custom_dropDown.dart';
import '../../../../common/widgets/custom_wigets/customdropdow_dialog.dart';
import '../../../../common/widgets/documents_cad/file_picker_dialog.dart';
import '../../../Applications/models/company_model.dart';
import '../../../Applications/models/user_model.dart';
import '../../controllers.onboarding/sign_up/sign_up_controller.dart';


class CandidateRegisterScreen5 extends StatefulWidget {
  const CandidateRegisterScreen5({super.key});

  @override
  State<CandidateRegisterScreen5> createState() => _CandidateRegisterScreen5State();
}

class _CandidateRegisterScreen5State extends State<CandidateRegisterScreen5> {
  int currentStep = 4;
  final SignupController controller = Get.find<SignupController>();


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
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.md * 0.6)
            ),
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

  void showCustomDropdownDialog({
    required BuildContext context,
    required String initialValue,
    required List<String> options,
    required Function(String selectedValue) onSave,
  }) {
    String selected = initialValue;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select an Option'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return CustomDropDown(
                label: "Choose",
                value: selected,
                items: options,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selected = value;
                    });
                  }
                },
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                onSave(selected); // Send selected value to controller
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<List<SkillEntry>?> showSkillDialog(BuildContext context) {
    return showDialog<List<SkillEntry>>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: SkillDialogContent(),
        );
      },
    );
  }


  /// Helper widget for an editable info row.
  Widget buildEditableInfoRow({
    required IconData leadingIcon,
    required String label,
    required String value,
    required VoidCallback onEdit,
    bool isOneLine = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(leadingIcon, size: 20, color: Colors.deepPurple),
          const SizedBox(width: 10),
          Expanded(
            child: isOneLine
                ?Text(overflow: TextOverflow.ellipsis, maxLines: 1, "$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black),)

                :Text("$label: $value", style: const TextStyle(fontSize: 14, color: Colors.black),),
          ),
          IconButton(
            icon: const Icon(Iconsax.edit, size: 18, color: JColors.primary),
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
                          backgroundImage: NetworkImage(controller.profileUrl.text),
                          backgroundColor: Colors.grey[300],
                          child: controller.profileUrl.text.isNotEmpty ? null : const Text("No Image", style: TextStyle(color: Colors.black),),
                        ),
                        Positioned(
                          bottom: -10,
                          right: 0,
                          child: // Where you want to trigger the image upload
                          IconButton(
                            icon: const Icon(Iconsax.edit, color: JColors.primary,),
                            onPressed: () => showDialog(
                              context: context,
                              builder: (_) => ImageUploadDialog(
                                title: "Upload Profile Image",
                                onUploadConfirmed: (url) {
                                  // Update your controller here
                                  controller.profileUrl.value = url as TextEditingValue;
                                },
                              ),
                            ),
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
                Obx(() => buildEditableInfoRow(
                  leadingIcon: Icons.work,
                  label: "Opportunity Type",
                  value: controller.opportunityType.value,
                  onEdit: () {
                    CustomDropdownDialog.show(
                      context: context,
                      title: "Opportunity Type",
                      label: "Select type",
                      initialValue: controller.opportunityType.value,
                      options: ['Internship', 'Job', 'Hybrid'],
                      onSave: (selectedValue) {
                        controller.opportunityType.value = selectedValue;
                      },
                    );
                  },
                )),

                Obx(() => buildEditableInfoRow(
                  leadingIcon:  Icons.category,
                  label: "Job Category",
                  value: controller.jobCategory.value,
                  onEdit: () {
                    CustomDropdownDialog.show(
                      context: context,
                      title: "Job Category",
                      label: "Select Category",
                      initialValue: controller.jobCategory.value,
                      options: ['Full Time', 'Part Time', 'Contract', 'Hybrid' ],
                      onSave: (selectedValue) {
                        controller.jobCategory.value = selectedValue;
                      },
                    );
                  },
                )),
              ]),
              const SizedBox(height: JSizes.spaceBtwItems),
              // Self Description & Resume Card
              buildInfoCard(context, [
                buildEditableInfoRow(
                  isOneLine: false,
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
                SizedBox(
                  width: double.infinity,
                  child: buildEditableInfoRow(
                    leadingIcon: Icons.upload_file,
                    label: "Resume",
                    value: controller.resume.text.isNotEmpty
                        ? controller.resume.text
                        : "Not provided",
                    onEdit: () {
                      DocumentUploadDialog.show(
                        context: context,
                        title: "Upload Resume",
                        onSave: (filePath) {
                          controller.resume.text = filePath;
                        },
                      );
                    },
                  ),
                ),
              ]),

              const SizedBox(height: JSizes.spaceBtwItems),

              buildLargeInfoCard(context, [

                Obx(() => Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: controller.skillEntries.map((entry) {
                    return InputChip(

                      label: Text("${entry.skill} (Lvl ${entry.level})", style: TextStyle(color: Colors.black, fontFamily: 'Poppins'),),
                        onDeleted: () async {
                          final shouldDelete = await showDialog<bool>(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text("Remove Skill"),
                              content: Text("Are you sure you want to remove '${entry.skill}'?"),
                              actions: [
                                OutlinedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: JSizes.md , vertical: JSizes.md * 0.6)), onPressed: () => Navigator.pop(context, false), child: const Text("Cancel", style: TextStyle(color: JColors.secondary, fontFamily: 'Poppins'),)),
                                ElevatedButton(style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: JSizes.md , vertical: JSizes.md * 0.6)), onPressed: () => Navigator.pop(context, true), child: const Text("Remove", style: TextStyle(fontFamily: 'Poppins'))),
                              ],
                            ),
                          );

                          if (shouldDelete == true) {
                            controller.skillEntries.remove(entry);
                          }
                        },
                        deleteIcon: const Icon(Icons.close, size: 16, color: Colors.red,),
                      backgroundColor: Colors.grey.shade200,
                    );
                  }).toList(),
                )),


                IconButton(
                  icon: const Icon(Iconsax.edit, size: 18, color: JColors.primary),
                    onPressed: () async {
                      final result = await showSkillDialog(context);
                      if (result != null && result.isNotEmpty) {
                        for (final newSkill in result) {
                          final index = controller.skillEntries.indexWhere(
                                (s) => s.skill.toLowerCase().trim() == newSkill.skill.toLowerCase().trim(),
                          );

                          if (index != -1) {
                            // If the skill already exists, only update if the level is different
                            if (controller.skillEntries[index].level != newSkill.level) {
                              controller.skillEntries[index] = newSkill;
                            }
                          } else {
                            // If it's a new skill, add it
                            controller.skillEntries.add(newSkill);
                          }
                        }

                        controller.skillEntries.refresh();
                      }


                    }




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
                       icon: const Icon(Iconsax.edit, size: 18, color: JColors.primary),
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
                       icon: const Icon(Iconsax.edit, size: 18, color: JColors.primary),
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
