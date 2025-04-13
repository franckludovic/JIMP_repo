import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import 'package:project_bc_tuto/features/Applications/controllers/category_controller.dart';
import 'package:project_bc_tuto/common/widgets/multiselectchip/multiselectChip.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../screens/Applicaton_details/myWidgets/application_header.dart';
import '../../screens/company_details/company_details.dart';


class ReviewFieldTile extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onEdit;

  const ReviewFieldTile({
    Key? key,
    required this.label,
    required this.value,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(label, style: Theme.of(context).textTheme.bodyMedium,),
        subtitle: Text(value.isEmpty ? "Not provided" : value, style: Theme.of(context).textTheme.bodyLarge,),
        trailing: IconButton(
          icon: const Icon(Iconsax.edit, color: Colors.blue),
          onPressed: onEdit,
        ),
      ),
    );
  }
}

/// This review page shows key posting fields allowing the company to review and modify their posting.
class ReviewPostingPage extends StatelessWidget {
  final PostingController controller = Get.find<PostingController>();

  ReviewPostingPage({Key? key}) : super(key: key);

  static const List<String> academicCreditOptions = [
    "Available",
    "Not Available"
  ];

  static const List<String> returnOfferOptions = ["Yes", "No"];
  static const List<String> trainingOptions = [
    "Technical Workshops",
    "Soft Skills Training",
    "Both",
    "None"
  ];

  static const List<String> educationLevels = [
    "High School",
    "Bachelor's",
    "Master's",
    "PhD",
    "None Required"
  ];

  static const List<String> projectPortfolioOptions = ["Yes", "No"];

  Future<void> showMultiLineEditDialog(
      BuildContext context, {
        required String title,
        required String initialValue,
        required ValueChanged<String> onSaved,
      }) async {
    final TextEditingController textController =
    TextEditingController(text: initialValue);
    await Get.defaultDialog(
      title: title,
      content: TextField(
        controller: textController,
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: "Enter items separated by commas",
        ),
      ),
      textCancel: "Cancel",
      textConfirm: "Save",
      onConfirm: () {
        // Pass the entered text back via the callback
        onSaved(textController.text);
        Get.back();
      },
    );
  }

  // A simple text-editing dialog (works for one-line text fields).
  Future<void> _editTextField({
    required BuildContext context,
    required String label,
    required String initialValue,
    required Function(String) onSaved,
  }) async {
    final textController = TextEditingController(text: initialValue);
    await Get.dialog(
      AlertDialog(
        title: Text("Edit $label"),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(labelText: label),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              onSaved(textController.text.trim());
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // A multi-line dialog that allows comma-separated input.
  Future<void> _editMultiLineField({
    required BuildContext context,
    required String label,
    required String initialValue,
    required Function(List<String>) onSaved,
  }) async {
    final textController = TextEditingController(text: initialValue);
    await Get.dialog(
      AlertDialog(
        title: Text("Edit $label"),
        content: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: "$label (separate items with commas)",
          ),
          keyboardType: TextInputType.multiline,
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              // Split the input by comma and trim each entry.
              final items = textController.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              onSaved(items);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  // A dropdown dialog for choosing from a list.
  Future<void> _editDropdownField({
    required BuildContext context,
    required String label,
    required List<String> options,
    required String initialValue,
    required Function(String) onSaved,
  }) async {
    String selectedValue = initialValue;
    await Get.dialog(
      AlertDialog(
        title: Text("Select $label"),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: options.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: selectedValue,
                onChanged: (val) {
                  if (val != null) {
                    selectedValue = val;
                    onSaved(selectedValue);
                    Navigator.pop(context);
                  }
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // A dialog that uses a date picker.
  Future<void> _editDateField({
    required BuildContext context,
    required String label,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    required Function(DateTime) onSaved,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (picked != null) {
      onSaved(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ComController = Get.put(CompanyController());
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title: const Text(
          "Review Your Posting",
          style: TextStyle(fontSize: 24, fontFamily: "Poppins"),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(JSizes.md),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Stack(
                children: [
                  JApplicationHeader(
                    isNetworkImage: true,
                    onTapLogo: () => Get.to(() => CompanyDetails()),
                    companyLogo:ComController.user?.logoUrl ?? "" ,
                    companyName: ComController.user?.companyName ?? "",
                    internshipName: controller.jobTitle.text ,
                  ),
                  Positioned(
                    right: 100,
                    bottom: 10,
                    child: IconButton(
                        onPressed: () => _editTextField(
                          context: context,
                          label: "Job Title",
                          initialValue: controller.jobTitle.text,
                          onSaved: (value) => controller.jobTitle.text = value,
                        ),

                        icon: const Icon(Iconsax.edit, color: Colors.blue, size: 30,)
                    ),
                  )
                ],
              ),

              ReviewFieldTile(
                label: "Opportunity Type",
                value: controller.opportunityType.value,
                onEdit: () => _editDropdownField(
                  context: context,
                  label: "Opportunity Type",
                  options: const ['Job', 'Internship', 'Contract'],
                  initialValue: controller.opportunityType.value,
                  onSaved: (value) => controller.opportunityType.value = value,
                ),
              ),
              // Category (this could be edited with a dropdown of all categories)
              ReviewFieldTile(
                label: "Job Category",
                value: controller.jobCategory.value,
                onEdit: () => _editDropdownField(
                  context: context,
                  label: "Job Category",
                  options: CategoryController.instance.allCategories
                      .map((cat) => cat.name)
                      .toList(),
                  initialValue: controller.jobCategory.value,
                  onSaved: (value) => controller.jobCategory.value = value,
                ),
              ),
              // Subcategories (displayed as chips)
              Card(
                margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                child: ListTile(
                  title: const Text("Selected Subcategories"),
                  subtitle: Wrap(
                    spacing: 8,
                    children: controller.selectedSubCategories
                        .map((sub) => Chip(label: Text(sub)))
                        .toList(),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Iconsax.edit, color: Colors.blue),
                    onPressed: () {
                      // Open a MultiSelectChip dialog for subcategories.
                      final List<String> subCatNames = CategoryController
                          .instance.subCategories
                          .map((subCat) => subCat.name)
                          .toList();

                      Get.dialog(AlertDialog(
                        title: const Text("Edit Subcategories (Max 5)"),
                        content: MultiSelectChip(
                          options: subCatNames,
                          selectedOptions:
                          controller.selectedSubCategories.toList(),
                          onSelectionChanged: (selected) {
                            if (selected.length <= 5) {
                              controller.selectedSubCategories.assignAll(selected);
                            } else {
                              Get.snackbar("Limit Reached",
                                  "You can only select up to 5 subcategories.");
                            }
                          },
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Close"),
                          ),
                        ],
                      ));
                    },
                  ),
                ),
              ),

              ReviewFieldTile(
                label: "Location",
                value: controller.selectedLocationAddress.value.isNotEmpty
                    ? controller.selectedLocationAddress.value
                    : controller.selectedLocationAddress.value,
                onEdit: () {
                  if (controller.employmentMode.value == "Onsite" ||
                      controller.employmentMode.value == "Hybrid") {
                    _editDropdownField(
                      context: context,
                      label: "Select Branch Address",
                      options: controller.availableBranchAddresses,
                      initialValue: controller.selectedBranchAddress.value,
                      onSaved: (value) {
                        controller.selectedBranchAddress.value = value;
                        controller.selectedLocationAddress.value = value;
                      },
                    );
                  } else {
                    _editTextField(
                      context: context,
                      label: "Location",
                      initialValue: controller.selectedLocationAddress.value,
                      onSaved: (value) => controller.selectedLocationAddress.value = value,
                    );
                  }
                },
              ),
              // Time Frame (free-form text; you could later implement a date range picker)

              // Job Description
              ReviewFieldTile(
                label: "Job Description",
                value: controller.jobDescription.text,
                onEdit: () => _editTextField(
                  context: context,
                  label: "Job Description",
                  initialValue: controller.jobDescription.text,
                  onSaved: (value) => controller.jobDescription.text = value,
                ),
              ),
              // Deadline (date field)
              ReviewFieldTile(
                label: "Application Deadline",
                value: controller.deadline.text,
                onEdit: () => _editDateField(
                  context: context,
                  label: "Deadline",
                  initialDate: DateTime.tryParse(controller.deadline.text) ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onSaved: (picked) {
                    controller.deadline.text = picked.toIso8601String();
                  },
                ),
              ),
              // Start Date
              ReviewFieldTile(
                label: "Expected Start Date",
                value: controller.startDate.text,
                onEdit: () => _editDateField(
                  context: context,
                  label: "Start Date",
                  initialDate: DateTime.tryParse(controller.startDate.text) ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onSaved: (picked) {
                    controller.startDate.text = picked.toIso8601String();
                  },
                ),
              ),
              // End Date
              ReviewFieldTile(
                label: "Expected End Date",
                value: controller.endDate.text,
                onEdit: () => _editDateField(
                  context: context,
                  label: "End Date",
                  initialDate: DateTime.tryParse(controller.endDate.text) ?? DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onSaved: (picked) {
                    controller.endDate.text = picked.toIso8601String();
                  },
                ),
              ),
              // Posting Expiration Date
              ReviewFieldTile(
                label: "Posting Expiration Date",
                value: controller.postingExpirationDate.text,
                onEdit: () => _editDateField(
                  context: context,
                  label: "Expiration Date",
                  initialDate: DateTime.tryParse(controller.postingExpirationDate.text) ??
                      DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onSaved: (picked) {
                    controller.postingExpirationDate.text = picked.toIso8601String();
                  },
                ),
              ),
              // Education Level
              ReviewFieldTile(
                label: "Education Level",
                value: controller.educationLevel.value,
                onEdit: () => _editDropdownField(
                  context: context,
                  label: "Education Level",
                  options: educationLevels,
                  initialValue: controller.educationLevel.value,
                  onSaved: (value) => controller.educationLevel.value = value,
                ),
              ),
              // Language Requirements
              ReviewFieldTile(
                label: "Language Requirements",
                value: controller.languageRequirements.text,
                onEdit: () => _editTextField(
                  context: context,
                  label: "Language Requirements",
                  initialValue: controller.languageRequirements.text,
                  onSaved: (value) => controller.languageRequirements.text = value,
                ),
              ),
              // How to Apply


              // Required Documents (use multiline editing dialog)
              ReviewFieldTile(
                label: "Required Documents",
                value: controller.requiredDocuments.text,
                onEdit: () => _editMultiLineField(
                  context: context,
                  label: "Required Documents",
                  initialValue: controller.requiredDocuments.text,
                  onSaved: (values) {
                    // Join the list into a comma separated string.
                    controller.requiredDocuments.text = values.join(', ');
                  },
                ),
              ),
              // Application Quota
              ReviewFieldTile(
                label: "Application Quota",
                value: controller.applicationQuota.text,
                onEdit: () => _editTextField(
                  context: context,
                  label: "Application Quota",
                  initialValue: controller.applicationQuota.text,
                  onSaved: (value) => controller.applicationQuota.text = value,
                ),
              ),
              // Selection Process
              ReviewFieldTile(
                label: "Selection Process",
                value: controller.selectionProcess.text,
                onEdit: () => _editMultiLineField(
                  context: context,
                  label: "Selection Process",
                  initialValue: controller.selectionProcess.text,
                  onSaved: (values) {
                    controller.selectionProcess.text = values.join(', ');
                  },
                ),
              ),
              // Additional Info
              ReviewFieldTile(
                label: "Additional Info",
                value: controller.additionalInfo.text,
                onEdit: () => _editMultiLineField(
                  context: context,
                  label: "Additional Info",
                  initialValue: controller.additionalInfo.text,
                  onSaved: (values) {
                    controller.additionalInfo.text = values.join(', ');
                  },
                ),
              ),
              // Work Authorization Requirements
              ReviewFieldTile(
                label: "Work Authorization Requirements",
                value: controller.workAuthorizationRequirements.text,
                onEdit: () => _editTextField(
                  context: context,
                  label: "Work Authorization Requirements",
                  initialValue: controller.workAuthorizationRequirements.text,
                  onSaved: (value) => controller.workAuthorizationRequirements.text = value,
                ),
              ),
              // Internal Reference Code

              Obx(() {
                // Get the current tags from the controller.
                final List<String> tagList = controller.tags.toList();
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const JSectionHeading(
                                title: "Custom Keywords (Optional)",
                                showActonButton: false,
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 8,
                                children: tagList.map((tag) {
                                  return Chip(label: Text(tag));
                                }).toList(),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Iconsax.edit, color: Colors.blue),
                            onPressed: () async {
                              // Open the edit dialog prefilled with comma-separated values.
                              await showMultiLineEditDialog(
                                context,
                                title: "Edit Keywords",
                                initialValue: tagList.join(", "),
                                onSaved: (enteredText) {
                                  // Split the entered text by comma, remove extra spaces and empty entries.
                                  final updatedTags = enteredText
                                      .split(",")
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList();
                                  controller.tags.assignAll(updatedTags);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              Obx(() {
                final List<String> skillsList = controller.requiredSkills.toList();
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex : 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const JSectionHeading(
                                title: "Required Skills",
                                showActonButton: false,
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 8,
                                children: skillsList.map((skill) => Chip(label: Text(skill))).toList(),
                              ),

                            ],
                          ),
                        ),
                        Expanded(
                          child: IconButton(
                            icon: const Icon(Iconsax.edit, color: Colors.blue),
                            onPressed: () async {
                              await showMultiLineEditDialog(
                                context,
                                title: "Edit Skills",
                                initialValue: skillsList.join(", "),
                                onSaved: (enteredText) {
                                  final updatedSkills = enteredText
                                      .split(",")
                                      .map((e) => e.trim())
                                      .where((e) => e.isNotEmpty)
                                      .toList();
                                  controller.requiredSkills.assignAll(updatedSkills);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Contact Email
              ReviewFieldTile(
                label: "Contact Email",
                value: controller.contactEmail.text,
                onEdit: () => _editTextField(
                  context: context,
                  label: "Contact Email",
                  initialValue: controller.contactEmail.text,
                  onSaved: (value) => controller.contactEmail.text = value,
                ),
              ),
              // Internship-Specific Section (only for Internship opportunity type)
              Obx(() {
                if (controller.opportunityType.value == "Internship") {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ReviewFieldTile(
                        label: "Duration",
                        value: controller.duration.text,
                        onEdit: () => _editTextField(
                          context: context,
                          label: "Duration",
                          initialValue: controller.duration.text,
                          onSaved: (value) => controller.duration.text = value,
                        ),
                      ),
                      ReviewFieldTile(
                        label: "Academic Credit",
                        value: controller.academicCredit.value ? "Available" : "Not Available",
                        onEdit: () => _editDropdownField(
                          context: context,
                          label: "Academic Credit",
                          options: academicCreditOptions,
                          initialValue: controller.academicCredit.value ? "Available" : "Not Available",
                          onSaved: (value) => controller.academicCredit.value = (value == "Available"),
                        ),
                      ),
                      ReviewFieldTile(
                        label: "Return Offer",
                        value: controller.returnOfferPotential.value ? "Yes" : "No",
                        onEdit: () => _editDropdownField(
                          context: context,
                          label: "Return Offer",
                          options: returnOfferOptions,
                          initialValue: controller.returnOfferPotential.value ? "Yes" : "No",
                          onSaved: (value) => controller.returnOfferPotential.value = (value == "Yes"),
                        ),
                      ),
                      ReviewFieldTile(
                        label: "Training Provided",
                        value: controller.trainingProvided.text,
                        onEdit: () => _editDropdownField(
                          context: context,
                          label: "Training Provided",
                          options: trainingOptions,
                          initialValue: controller.trainingProvided.text,
                          onSaved: (value) => controller.trainingProvided.text = value,
                        ),
                      ),
                      ReviewFieldTile(
                        label: "Project Portfolio",
                        value: controller.projectPortfolio.value ? "Yes" : "No",
                        onEdit: () => _editDropdownField(
                          context: context,
                          label: "Project Portfolio",
                          options: projectPortfolioOptions,
                          initialValue: controller.projectPortfolio.value ? "Yes" : "No",
                          onSaved: (value) => controller.projectPortfolio.value = (value == "Yes"),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Final submission button
              Center(
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.check),
                  label: const Text("Confirm & Submit Posting"),
                  onPressed: () {
                    controller.submitPosting();
                  },
                ),
              ),
            ],
          );
        }),


      ),
      // Optionally you can add a bottom navigation bar or other components.
    );
  }
}
