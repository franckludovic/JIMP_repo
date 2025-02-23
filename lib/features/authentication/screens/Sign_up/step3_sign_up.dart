import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/step4_sign_up.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/SkillAddCard.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/device/device_utility.dart';

class CandidateRegisterScreen3 extends StatefulWidget {
  const CandidateRegisterScreen3({super.key});

  @override
  State<CandidateRegisterScreen3> createState() => _CandidateRegisterScreen3State();
}

class _CandidateRegisterScreen3State extends State<CandidateRegisterScreen3> {
  int currentStep = 2;
  List<SkillAddCard> skillCards = [];

  @override
  void initState() {
    super.initState();

    _addSkillCard();
  }

  void _addSkillCard() {
    setState(() {
      skillCards.add(SkillAddCard(
        onRemove: () => _removeSkillCard(skillCards.length - 1),
      ));
    });
  }


  void _removeSkillCard(int index) {
    setState(() {
      if (index >= 0 && index < skillCards.length) {
        skillCards.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title:Text(
        "Skills and Experience",
        style: Theme.of(context).textTheme.headlineMedium,
      ),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Job Preference Input
                  const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_2_rounded),
                      labelText: "Job Preference",
                      border: OutlineInputBorder(),
                    ),
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
                        style: ElevatedButton.styleFrom(padding: EdgeInsets.symmetric(vertical: JSizes.sm * 1.65)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Add Skill",
                              style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                            ),
                            SizedBox(width: JSizes.sm),
                            Icon(Icons.add, size: 30),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: JSizes.spaceBtwSections),

                  // Navigation Buttons (Previous & Next)
                  SignUpNavigationButtons(onPressed: () => Get.to(() => CandidateRegisterScreen4()),),

                  const SizedBox(height: JSizes.spaceBtwSections),
                  JDivider(),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Step Indicator
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections, top: JSizes.md),
        child: StepIndicator(currentIndex: currentStep, totalSteps: 5),
      ),
    );
  }
}

