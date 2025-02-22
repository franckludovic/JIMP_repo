import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/SkillAddCard.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import '../../../../utils/device/device_utility.dart';


class CandidateRegisterScreen3 extends StatefulWidget {
  const CandidateRegisterScreen3({super.key});

  @override
  State<CandidateRegisterScreen3> createState() => _CandidateRegisterScreen3State();
}

class _CandidateRegisterScreen3State extends State<CandidateRegisterScreen3> {
  int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: JSizes.spaceBtwSections * 2),
              child: Padding(
                padding: const EdgeInsets.all(JSizes.defaultSpace),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Skills and Experience",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineMedium,
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),

                        // Username Field
                        const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Username",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: JSizes.md),


                        // Skill Boxes
                        SkillAddCard(),


                        const SizedBox(height: 16),





                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: JColors.primary,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: JSizes.md,
                                      vertical: JSizes.sm)),
                              child: const Row(
                                children: [
                                  Icon(
                                    Iconsax.arrow_left_3, color: Colors.white,
                                    size: 35,),
                                  SizedBox(width: 5),
                                  Text("Last Step", style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 19)),

                                ],
                              ),
                            ),

                            SizedBox(width: JSizes.md),

                            ElevatedButton(
                              onPressed: () => Get.to(() => CandidateRegisterScreen3()),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: JColors.primary,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: JSizes.md,
                                      vertical: JSizes.sm)),
                              child: const Row(
                                children: [
                                  Text("Next Step", style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontSize: 19)),
                                  SizedBox(width: 5),
                                  Icon(
                                    Iconsax.arrow_right_2, color: Colors.white,
                                    size: 35,),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: JSizes.spaceBtwSections),

                        JDivider(),
                        // Bottom Step Indicator

                      ],
                    ),


                  ],
                ),
              ),
            ),



          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: JSizes.spaceBtwSections),
        child: Positioned(
            bottom: JDeviceUtils.getBottomNavigationBarHeight(),
            left: 0,
            right: 0,
            child: StepIndicator(currentIndex: currentStep, totalSteps: 5)
        ),
      ),
    );
  }

}

