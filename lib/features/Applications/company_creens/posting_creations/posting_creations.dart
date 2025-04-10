import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/customTextfileds.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/tagInpusts.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_wigets/jcustom_dropdown.dart';

import '../../../../common/widgets/date picker/customdatepicker.dart';
import '../../screens/Applicaton_details/application_details.dart';
import '../quiz_creation/QuizMainpage.dart';

class JobCreationPage extends StatefulWidget {
  const JobCreationPage({super.key});

  @override
  State<JobCreationPage> createState() => _JobCreationPageState();
}

class _JobCreationPageState extends State<JobCreationPage> {
  // Standard field controllers
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeFrameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _preferredReqController = TextEditingController();
  final TextEditingController _minReqController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();

  // Date fields for Job Details
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  // Additional fields for compensation & benefits
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _benefitsController = TextEditingController();

  // Additional Application Process fields
  final TextEditingController _requiredDocsController = TextEditingController();
  final TextEditingController _applicationQuotaController =
      TextEditingController();
  final TextEditingController _selectionProcessController =
      TextEditingController();

  // Additional Company Additional Info fields
  final TextEditingController _equalOppStatementController =
      TextEditingController();
  final TextEditingController _workAuthRequirementsController =
      TextEditingController();
  final TextEditingController _internalRefCodeController =
      TextEditingController();
  final TextEditingController _contactEmailController = TextEditingController();

  // Additional text field for Language Requirements
  final TextEditingController _languageRequirementsController =
      TextEditingController();

  // For internship duration field
  final TextEditingController _durationController = TextEditingController();

  // Reactive variables for dropdowns using GetX RxString
  final RxString _opportunityType =
      ''.obs; // Opportunity Type: Job, Internship, Contract
  final RxString _locationType =
      ''.obs; // Location Type: Remote, Onsite, Hybrid
  final RxString _experienceLevel = ''.obs; // Experience Level
  final RxString _frequency = ''.obs; // Frequency for salary etc.
  final RxString _educationLevel = ''.obs; // Education level
  final RxString _howToApply = ''.obs; // How to apply

  // Options for dropdowns
  static const List<String> opportunityOptions = [
    'Job',
    'Internship',
    'Contract'
  ];
  static const List<String> locationTypes = ["Remote", "Onsite", "Hybrid"];
  static const List<String> experienceLevels = [
    "Entry Level",
    "Mid Level",
    "High Level"
  ];
  static const List<String> frequencyOptions = [
    "Weekly",
    "Monthly",
    "Annually"
  ];
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
  static List<String> _tags = [];
  static List<String> _requiredSkills = [];

  // Internship-specific fields (only shown if opportunityType == "Internship")
  final RxString _academicCredit = ''.obs; // "Available" or "Not Available"
  final RxString _returnOffer = ''.obs; // "Yes" or "No"
  final RxString _trainingProvided =
      ''.obs; // "Technical Workshops", "Soft Skills Training", "Both", "None"
  final RxString _projectPortfolio = ''.obs; // "Yes" or "No"

  // Options for internship-specific
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
  static const List<String> projectPortfolioOptions = ["Yes", "No"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title: Text(
          "Job Form",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: JSizes.md, vertical: JSizes.sm),
            ),
            onPressed: _saveDraft,
            child: Text("Save Draft",
                style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 6),
              Obx(() => JCustomDropDown(
                    title: "Opportunity Type:",
                    items: opportunityOptions,
                    value: _opportunityType.value.isEmpty
                        ? null
                        : _opportunityType.value,
                    hint: "Select Opportunity Type",
                    onChanged: (val) {
                      if (val != null) _opportunityType.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Job Title
              const JSectionHeading(title: "Job Title", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _jobTitleController,
                hint: "Opportunity And Role",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Location
              const JSectionHeading(title: "Location", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _locationController,
                hint: "Enter Location",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Tags (Job Categories)
              TagInputWidget(
                label: "Add Tags",
                hint: "e.g. C++, Java",
                initialItems: _tags,
                onChanged: (newItems) => setState(() => _tags = newItems),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Required Skills
              TagInputWidget(
                label: "Required Skills",
                hint: "e.g. Flutter, React",
                initialItems: _requiredSkills,
                onChanged: (newItems) =>
                    setState(() => _requiredSkills = newItems),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Time Frame
              const JSectionHeading(
                  title: "Time Frame", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _timeFrameController,
                hint: "Search for a date or add a custom timeframe",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Job Description
              const JSectionHeading(
                  title: "Job Description", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _descriptionController,
                hint: "Describe the role, responsibilities, etc.",
                maxLines: 6,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Preferred Requirements
              const JSectionHeading(
                  title: "Preferred Requirements", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _preferredReqController,
                hint: "Optional, but recommended",
                maxLines: 4,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Minimum Requirements
              const JSectionHeading(
                  title: "Minimum Requirements (Optional)",
                  showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _minReqController,
                hint: "Optional field",
                maxLines: 4,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Additional Info
              const JSectionHeading(
                  title: "Additional Info (Optional)", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _additionalInfoController,
                hint: "Any extra details about the job",
                maxLines: 4,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Deadline
              const JSectionHeading(title: "Deadline", showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _deadlineController,
                hint: "Set a closing date for applications",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              const SizedBox(height: 6),
              // Location Type Dropdown
              Obx(() => JCustomDropDown(
                    title: "Location Type:",
                    items: locationTypes,
                    value: _locationType.value.isEmpty
                        ? null
                        : _locationType.value,
                    hint: "Select Location Type",
                    onChanged: (val) {
                      if (val != null) _locationType.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Experience Level Dropdown
              Obx(() => JCustomDropDown(
                    title: "Experience Level:",
                    items: experienceLevels,
                    value: _experienceLevel.value.isEmpty
                        ? null
                        : _experienceLevel.value,
                    hint: "Select Experience Level",
                    onChanged: (val) {
                      if (val != null) _experienceLevel.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Frequency Dropdown
              Obx(() => JCustomDropDown(
                    title: "Frequency:",
                    items: frequencyOptions,
                    value: _frequency.value.isEmpty ? null : _frequency.value,
                    hint: "Select Frequency",
                    onChanged: (val) {
                      if (val != null) _frequency.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Start Date Field using CustomDatePickerField widget
              CustomDatePickerField(
                controller: _startDateController,
                label: "Start Date",
                hint: "Select start date",
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // End Date Field using CustomDatePickerField widget
              CustomDatePickerField(
                controller: _endDateController,
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
                    value: _educationLevel.value.isEmpty
                        ? null
                        : _educationLevel.value,
                    hint: "Select Education Level",
                    onChanged: (val) {
                      if (val != null) _educationLevel.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Language Requirements Field
              const JSectionHeading(
                  title: "Language Requirements (Optional)",
                  showActonButton: false),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _languageRequirementsController,
                hint: "e.g. English B2+",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // How to Apply Dropdown
              Obx(() => JCustomDropDown(
                    title: "How to Apply:",
                    items: howToApplyOptions,
                    value: _howToApply.value.isEmpty ? null : _howToApply.value,
                    hint: "Select application method",
                    onChanged: (val) {
                      if (val != null) _howToApply.value = val;
                    },
                  )),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Required Documents Field
              CustomTextField(
                controller: _requiredDocsController,
                hint: "e.g. Resume, Cover Letter, Portfolio",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Application Quota Field
              CustomTextField(
                controller: _applicationQuotaController,
                hint: "Max applications allowed (if any)",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Selection Process Field
              CustomTextField(
                controller: _selectionProcessController,
                hint: "Details about interview stages, tests, timeline",
                maxLines: 3,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Additional Company Info (Optional)
              const JSectionHeading(
                  title: "Additional Company Info (Optional)",
                  showActonButton: false),
              const SizedBox(height: 6),
              // Equal Opportunity Statement Field
              CustomTextField(
                controller: _equalOppStatementController,
                hint: "e.g. We are an Equal Opportunity Employer",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Work Authorization Requirements Field
              CustomTextField(
                controller: _workAuthRequirementsController,
                hint: "State any work authorization requirements",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Internal Reference Code Field
              CustomTextField(
                controller: _internalRefCodeController,
                hint: "Optional internal reference code",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Contact Email Field
              CustomTextField(
                controller: _contactEmailController,
                hint: "Contact email for questions",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),
              // Internship-Specific Section (Conditional)
              Obx(() {
                if (_opportunityType.value == "Internship") {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Duration Field
                      const JSectionHeading(
                          title: "Duration", showActonButton: false),
                      const SizedBox(height: 6),
                      CustomTextField(
                        controller: _durationController,
                        hint: "e.g., 3 months, 6 months",
                      ),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      // Academic Credit Dropdown
                      Obx(() => JCustomDropDown(
                            title: "Academic Credit:",
                            items: academicCreditOptions,
                            value: _academicCredit.value.isEmpty
                                ? null
                                : _academicCredit.value,
                            hint: "Select Credit Option",
                            onChanged: (val) {
                              if (val != null) _academicCredit.value = val;
                            },
                          )),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      // Return Offer Dropdown
                      Obx(() => JCustomDropDown(
                            title: "Return Offer:",
                            items: returnOfferOptions,
                            value: _returnOffer.value.isEmpty
                                ? null
                                : _returnOffer.value,
                            hint: "Select option",
                            onChanged: (val) {
                              if (val != null) _returnOffer.value = val;
                            },
                          )),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      // Training Provided Dropdown
                      Obx(() => JCustomDropDown(
                            title: "Training Provided:",
                            items: trainingOptions,
                            value: _trainingProvided.value.isEmpty
                                ? null
                                : _trainingProvided.value,
                            hint: "Select Training Option",
                            onChanged: (val) {
                              if (val != null) _trainingProvided.value = val;
                            },
                          )),
                      const SizedBox(height: JSizes.spaceBtwSections),
                      // Project Portfolio Dropdown
                      Obx(() => JCustomDropDown(
                            title: "Project Portfolio:",
                            items: projectPortfolioOptions,
                            value: _projectPortfolio.value.isEmpty
                                ? null
                                : _projectPortfolio.value,
                            hint: "Select option",
                            onChanged: (val) {
                              if (val != null) _projectPortfolio.value = val;
                            },
                          )),
                      const SizedBox(height: JSizes.spaceBtwSections),
                    ],
                  );
                } else {
                  return const SizedBox();
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
                onPressed: () => Get.to(() => const JMyApplicationDetails(
                      title: "Review Post",
                      isReview: true,
                    )),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
                child: const Text("Review Posting"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method for DatePicker is contained within the CustomDatePickerField below.
  // Button callbacks
  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved")),
    );
  }

  void _skillVerificationQuizInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text(
              "You can add a skill verification quiz to evaluate candidate skills")),
    );
  }
}



