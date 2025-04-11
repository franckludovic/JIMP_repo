import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/date%20picker/customdatepicker.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/customTextfileds.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/tagInpusts.dart';
import 'package:project_bc_tuto/common/widgets/custom_wigets/jcustom_dropdown.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/features/Applications/controllers/posting_controller.dart';
import '../../../../common/widgets/multiselectchip/multiselectChip.dart';
import '../../controllers/category_controller.dart';
import '../../screens/Applicaton_details/application_details.dart';
import '../quiz_creation/QuizMainpage.dart';

class JobCreationPage extends StatefulWidget {
  const JobCreationPage({super.key});

  @override
  State<JobCreationPage> createState() => _JobCreationPageState();
}

class _JobCreationPageState extends State<JobCreationPage> {
  final PostingController controller = Get.put(PostingController());
  final CategoryController categoryController = Get.put(CategoryController());

  // Dropdown options for various fields:
  static const List<String> opportunityOptions = [
    'Job',
    'Internship',
    'Contract'
  ];
  static const List<String> employmentMode = ["Remote", "Onsite", "Hybrid"];
  static const List<String> experienceLevels = [
    "Entry Level",
    "Mid Level",
    "High Level"
  ];
  static const List<String> frequencyOptions = ["Weekly", "Monthly", "Annually"];
  static const List<String> educationLevels = [
    "High School",
    "Bachelor's",
    "Master's",
    "PhD",
    "None Required"
  ];
  static const List<String> howToApplyOptions = [
    "Email",
    "Platform Form",
    "LinkedIn Easy Apply"
  ];
  static const List<String> academicCreditOptions = ["Available", "Not Available"];
  static const List<String> returnOfferOptions = ["Yes", "No"];
  static const List<String> trainingOptions = [
    "Technical Workshops",
    "Soft Skills Training",
    "Both",
    "None"
  ];
  static const List<String> projectPortfolioOptions = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title: Text("Job Form", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.sm),
            ),
            onPressed: () {
              // Optionally, add a save draft functionality via the controller.
            },
            child: Text("Save Draft", style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Opportunity Type Dropdown
                Obx(() => JCustomDropDown(
                  title: "Opportunity Type:",
                  items: opportunityOptions,
                  value: controller.opportunityType.value.isEmpty
                      ? null
                      : controller.opportunityType.value,
                  hint: "Select Opportunity Type",
                  onChanged: (val) {
                    if (val != null) controller.opportunityType.value = val;
                  },
                )),

                const SizedBox(height: JSizes.spaceBtwSections),
                // Job Category Dropdown
                Obx(() {
                  if (categoryController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final List<String> categoryNames = categoryController.allCategories
                      .map((cat) => cat.name)
                      .toList();
                  return JCustomDropDown(
                    title: "Category:",
                    items: categoryNames,
                    value: controller.jobCategory.value.isEmpty ? null : controller.jobCategory.value,
                    hint: "Select Category",
                    onChanged: (val) {
                      if (val != null) {
                        controller.jobCategory.value = val;
                        categoryController.fetchSubcategoriesFor(val);
                        controller.selectedSubCategories.clear();
                      }
                    },

                  );
                }),
                const SizedBox(height: JSizes.spaceBtwItems),
                const JSectionHeading(title: "Select Subcategories", showActonButton: false),

                Obx(() {
                  if (categoryController.subCategories.isEmpty) {
                    return const Text("No subcategories available for selected category.");
                  }

                  final subNames = categoryController.subCategories.map((e) => e.name).toList();

                  return MultiSelectChip(
                    options: subNames,
                    selectedOptions: controller.selectedSubCategories,
                    onSelectionChanged: (selected) {
                      controller.selectedSubCategories.assignAll(selected);
                    },
                  );
                }),



                const SizedBox(height: JSizes.spaceBtwSections),
                // Job Title
                const JSectionHeading(title: "Job Title", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.jobTitle,
                  hint: "Opportunity And Role",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Location
                const JSectionHeading(title: "Location", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.location,
                  hint: "Enter Location",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Tags (Job Categories/Keywords)
                TagInputWidget(
                  label: "Add Tags",
                  hint: "e.g. C++, Java",
                  initialItems: controller.tags,
                  onChanged: (newItems) => controller.tags.assignAll(newItems),
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Required Skills
                TagInputWidget(
                  label: "Required Skills",
                  hint: "e.g. Flutter, React",
                  initialItems: controller.requiredSkills,
                  onChanged: (newItems) => controller.requiredSkills.assignAll(newItems),
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Time Frame
                const JSectionHeading(title: "Time Frame", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.timeFrame,
                  hint: "Search for a date or add a custom timeframe",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Job Description
                const JSectionHeading(title: "Job Description", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.jobDescription,
                  hint: "Describe the role, responsibilities, etc.",
                  maxLines: 6,
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Preferred Requirements
                const JSectionHeading(title: "Preferred Requirements", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.preferredRequirements,
                  hint: "Optional, but recommended",
                  maxLines: 4,
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Minimum Requirements
                const JSectionHeading(title: "Minimum Requirements (Optional)", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.minimumRequirements,
                  hint: "Optional field",
                  maxLines: 4,
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Additional Info
                const JSectionHeading(title: "Additional Info (Optional)", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.additionalInfo,
                  hint: "Any extra details about the job",
                  maxLines: 4,
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Deadline
                const JSectionHeading(title: "Deadline", showActonButton: false),
                const SizedBox(height: 6),
                // Note: Ensure your CustomTextField can work with a date value or consider using a DatePicker widget.
                CustomTextField(
                  controller: controller.deadline.value != null
                      ? TextEditingController(text: controller.deadline.value.toString())
                      : TextEditingController(),
                  hint: "Set a closing date for applications",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Location Type Dropdown
                Obx(() => JCustomDropDown(
                  title: "Location Type:",
                  items: employmentMode,
                  value: controller.employmentMode.value.isEmpty
                      ? null
                      : controller.employmentMode.value,
                  hint: "Select Location Type",
                  onChanged: (val) {
                    if (val != null) controller.employmentMode.value = val;
                  },
                )),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Experience Level Dropdown
                Obx(() => JCustomDropDown(
                  title: "Experience Level:",
                  items: experienceLevels,
                  value: controller.experienceLevel.value.isEmpty
                      ? null
                      : controller.experienceLevel.value,
                  hint: "Select Experience Level",
                  onChanged: (val) {
                    if (val != null) controller.experienceLevel.value = val;
                  },
                )),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Frequency Dropdown
                Obx(() => JCustomDropDown(
                  title: "Frequency:",
                  items: frequencyOptions,
                  value: controller.frequency.value.isEmpty
                      ? null
                      : controller.frequency.value,
                  hint: "Select Frequency",
                  onChanged: (val) {
                    if (val != null) controller.frequency.value = val;
                  },
                )),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Start Date Field using CustomDatePickerField widget
                CustomDatePickerField(
                  controller: controller.startDate,
                  label: "Start Date",
                  hint: "Select start date",
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // End Date Field using CustomDatePickerField widget
                CustomDatePickerField(
                  controller: controller.endDate,
                  label: "End Date",
                  hint: "Select end date",
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Education Level Dropdown
                Obx(() => JCustomDropDown(
                  title: "Education Level:",
                  items: educationLevels,
                  value: controller.educationLevel.value.isEmpty
                      ? null
                      : controller.educationLevel.value,
                  hint: "Select Education Level",
                  onChanged: (val) {
                    if (val != null) controller.educationLevel.value = val;
                  },
                )),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Language Requirements Field
                const JSectionHeading(title: "Language Requirements (Optional)", showActonButton: false),
                const SizedBox(height: 6),
                CustomTextField(
                  controller: controller.languageRequirements,
                  hint: "e.g. English B2+",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // How to Apply Dropdown
                Obx(() => JCustomDropDown(
                  title: "How to Apply:",
                  items: howToApplyOptions,
                  value: controller.howToApply.value.isEmpty ? null : controller.howToApply.value,
                  hint: "Select application method",
                  onChanged: (val) {
                    if (val != null) controller.howToApply.value = val;
                  },
                )),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Required Documents Field
                CustomTextField(
                  controller: controller.requiredDocuments,
                  hint: "e.g. Resume, Cover Letter, Portfolio",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Application Quota Field
                CustomTextField(
                  controller: controller.applicationQuota,
                  hint: "Max applications allowed (if any)",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Selection Process Field
                CustomTextField(
                  controller: controller.selectionProcess,
                  hint: "Details about interview stages, tests, timeline",
                  maxLines: 3,
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Additional Company Info (Optional)
                const JSectionHeading(title: "Additional Company Info (Optional)", showActonButton: false),
                const SizedBox(height: 6),
                // Equal Opportunity Statement Field
                CustomTextField(
                  controller: controller.equalOpportunityStatement,
                  hint: "e.g. We are an Equal Opportunity Employer",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Work Authorization Requirements Field
                CustomTextField(
                  controller: controller.workAuthorizationRequirements,
                  hint: "State any work authorization requirements",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Internal Reference Code Field
                CustomTextField(
                  controller: controller.internalReferenceCode,
                  hint: "Optional internal reference code",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Contact Email Field
                CustomTextField(
                  controller: controller.contactEmail,
                  hint: "Contact email for questions",
                ),
                const SizedBox(height: JSizes.spaceBtwSections),

                // Internship-Specific Section (Conditional)
                Obx(() {
                  if (controller.opportunityType.value == "Internship") {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const JSectionHeading(title: "Duration", showActonButton: false),
                        const SizedBox(height: 6),
                        CustomTextField(
                          controller: controller.duration,
                          hint: "e.g., 3 months, 6 months",
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        Obx(() => JCustomDropDown(
                          title: "Academic Credit:",
                          items: academicCreditOptions,
                          value: controller.academicCredit.value ? "Available" : "Not Available",
                          hint: "Select Credit Option",
                          onChanged: (val) {
                            if (val != null) {
                              controller.academicCredit.value = (val == "Available");
                            }
                          },
                        )),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        Obx(() => JCustomDropDown(
                          title: "Return Offer:",
                          items: returnOfferOptions,
                          value: controller.returnOfferPotential.value ? "Yes" : "No",
                          hint: "Select option",
                          onChanged: (val) {
                            if (val != null) {
                              controller.returnOfferPotential.value = (val == "Yes");
                            }
                          },
                        )),
                        const SizedBox(height: JSizes.spaceBtwSections),
                         JCustomDropDown(
                          title: "Training Provided:",
                          items: trainingOptions,
                          value: controller.trainingProvided.text.isEmpty ? null : controller.trainingProvided.text,
                          hint: "Select Training Option",
                          onChanged: (val) {
                            if (val != null) controller.trainingProvided.text = val;
                          },
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),
                        Obx(() => JCustomDropDown(
                          title: "Project Portfolio:",
                          items: projectPortfolioOptions,
                          value: controller.projectPortfolio.value ? "Yes" : "No",
                          hint: "Select option",
                          onChanged: (val) {
                            if (val != null) controller.projectPortfolio.value = (val == "Yes");
                          },
                        )),
                        const SizedBox(height: JSizes.spaceBtwSections),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Skill Verification Quiz Section
                Row(
                  children: [
                    IconButton(
                      onPressed: _skillVerificationQuizInfo,
                      icon: Icon(Icons.quiz_outlined, color: Colors.blue),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () => Get.to(() => const QuizCreationPage()),
                      child: const Text("Add a skill verification quiz"),
                    ),
                  ],
                ),
                const SizedBox(height: JSizes.spaceBtwSections),
                // Review Posting Button
                ElevatedButton(
                  onPressed: () => Get.to(() => const JMyApplicationDetails(title: "Review Post", isReview: true)),
                  style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
                  child: const Text("Review Posting"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Button callback functions
  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved")),
    );
  }

  void _skillVerificationQuizInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text("You can add a skill verification quiz to evaluate candidate skills")),
    );
  }
}
