import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step3_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/SkillAddCard.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/popups/loaders.dart';
import '../../../Applications/models/user_model.dart';
import '../../controllers.onboarding/sign_up/sign_up_controller.dart';

class CandidateRegisterScreen2 extends StatefulWidget {
  const CandidateRegisterScreen2({super.key});

  @override
  State<CandidateRegisterScreen2> createState() =>
      _CandidateRegisterScreen2State();
}

class _CandidateRegisterScreen2State extends State<CandidateRegisterScreen2> {
  int currentStep = 1;
  List<SkillAddCard> skillCards = [];

  final SignupController controller = Get.find<SignupController>();

  @override
  void initState() {
    super.initState();
    // Start with one Skill card and initialize corresponding controller entry.
    _addSkillCard();
  }

  // Modified add method to include a callback for updating the skill in the controller.
  void _addSkillCard() {
    setState(() {
      // When a new SkillAddCard is created, you pass a callback for when the skill is updated.
      skillCards.add(
        SkillAddCard(
          onRemove: () => _removeSkillCard(skillCards.length - 1),
          onSkillChanged: (String skill, int level, int index) {
            // Update or add the SkillEntry in the controller's reactive list.
            if (controller.skillEntries.length > index) {
              controller.skillEntries[index] =
                  SkillEntry(skill: skill, level: level);
            } else {
              controller.skillEntries.add(
                SkillEntry(skill: skill, level: level),
              );
            }
          },
          cardIndex: skillCards.length, // Pass current index
        ),
      );
    });
  }

  void _removeSkillCard(int index) {
    setState(() {
      if (index >= 0 && index < skillCards.length) {
        skillCards.removeAt(index);
        // Remove corresponding entry from the controller's reactive list.
        if (controller.skillEntries.length > index) {
          controller.skillEntries.removeAt(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          "Skills and Experience",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          // You can assign a separate form key here if needed.
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Job Preference Input using controller's TextEditingController.
                    TextFormField(
                      controller: controller.jobTypePreference,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person_2_rounded),
                        labelText: "Job Preference",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a job preference';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: JSizes.md),
                    // Skill Cards List
                    Column(children: skillCards),
                    const SizedBox(height: 16),
                    // Add Skill Button
                    Center(
                      child: SizedBox(
                        width: JDeviceUtils.getScreenWidth(context) * 0.5,
                        child: ElevatedButton(
                          onPressed: _addSkillCard,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: JSizes.sm * 1.65)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Add Skill",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: "Poppins"),
                              ),
                              SizedBox(width: JSizes.sm),
                              Icon(Icons.add, size: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: JSizes.spaceBtwSections),
                    JDivider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom Step Indicator and Navigation Buttons
      bottomNavigationBar: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SignUpNavigationButtons(
                onPressed: () {
                  if (controller.validateStep(2)) {
                    // Proceed to next screen.
                    Get.to(() => CandidateRegisterScreen3());
                  } else {
                    TLoaders.warningSnackBar(
                      title: 'Missing Information',
                      message: 'Please fill in all required fields before proceeding.',
                    );
                  }
                }),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: JSizes.spaceBtwSections, top: JSizes.md),
              child: Positioned(
                bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                left: 0,
                right: 0,
                child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
