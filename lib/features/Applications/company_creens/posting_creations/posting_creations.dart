import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/customTextfileds.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/posting_creations/widgets/tagInpusts.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../screens/Applicaton_details/application_details.dart';
import '../quiz_creation/QuizMainpage.dart';




class JobCreationPage extends StatefulWidget {
  const JobCreationPage({super.key});

  @override
  State<JobCreationPage> createState() => _JobCreationPageState();
}

class _JobCreationPageState extends State<JobCreationPage> {

  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _timeFrameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _preferredReqController = TextEditingController();
  final TextEditingController _minReqController = TextEditingController();
  final TextEditingController _additionalInfoController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();


  List<String> _tags = [];

  List<String> _requiredSkills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        showBackArrow: true,
        title:  Text("Job Form", style: Theme.of(context).textTheme.headlineMedium,),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.sm),


            ),
            onPressed: _saveDraft,
            child:  Text("Save Draft", style: Theme.of(context).textTheme.headlineSmall),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Job Title
              const JSectionHeading(title: "Job Title", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _jobTitleController,
                hint: "Opportunity And Role",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Location
              const JSectionHeading(title: "Location", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _locationController,
                hint: "Enter Location",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Tags (like job categories)
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
                onChanged: (newItems) => setState(() => _requiredSkills = newItems),
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Time Frame
              const JSectionHeading(title: "Time Frame", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _timeFrameController,
                hint: "Search for a date or add a custom timeframe",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Job Description
              const JSectionHeading(title: "Job Description", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _descriptionController,
                hint: "Describe the role, responsibilities, etc.",
                maxLines: 6,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Preferred Requirements
              const JSectionHeading(title: "Preferred Requirements", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _preferredReqController,
                hint: "Optional, but recommended",
                maxLines: 4,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Minimum Requirements
              const JSectionHeading(title: "Minimum Requirements (Optional)", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _minReqController,
                hint: "Optional field",
                maxLines: 4,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Additional Info
              const JSectionHeading(title: "Additional Info (Optional)", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _additionalInfoController,
                hint: "Any extra details about the job",
                maxLines:4 ,
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Deadline
              const JSectionHeading(title: "Deadline", showActonButton: false,),
              const SizedBox(height: 6),
              CustomTextField(
                controller: _deadlineController,
                hint: "Set a closing date for applications",
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Skill Verification Quiz
              Row(
                children: [
                  IconButton(onPressed: _skillVerificationQuizInfo ,  icon: Icon(Icons.quiz_outlined, color: Colors.blue)),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed:()  => Get.to(() => const QuizCreationPage()),
                    child: const Text("Add a skill verification quiz"),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwSections),

              // Review Posting Button
              ElevatedButton(
                onPressed: () => Get.to(() => const JMyApplicationDetails(title: "Review Post", isReview: true,)),
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

  /// Button callbacks
  void _saveDraft() {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Draft Saved")),
    );
  }


  void _skillVerificationQuizInfo() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("You can add a skill verification Quiz to evaluate the skills of candidate")),
    );
  }
}
