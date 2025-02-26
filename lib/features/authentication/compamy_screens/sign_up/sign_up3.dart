import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/textArea.dart';
import '../../../../common/widgets/sign_upButtons/signUpNavButtons.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../compamy_screens/sign_up/widget/step_indicator.dart';

class CompanySignupScreen3 extends StatefulWidget {
  const CompanySignupScreen3({super.key});

  @override
  State<CompanySignupScreen3> createState() => _CompanyRegisterScreenState3();
}

class _CompanyRegisterScreenState3 extends State<CompanySignupScreen3> {
  int currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Security & Authentication",
            style: Theme.of(context).textTheme.headlineMedium),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  JTextArea(
                      label: Text('Password'),
                      maxAreaHeight: 1,
                      minAreaHeight: 1,
                      prefixIcon: Icon(Iconsax.password_check)),
                  SizedBox(
                    height: JSizes.spaceBtwSections * 0.8,
                  ),
                  JTextArea(
                      label: Text('Confirm Password'),
                      maxAreaHeight: 1,
                      minAreaHeight: 1,
                      prefixIcon: Icon(Iconsax.repeat)),
                  SizedBox(
                    height: JSizes.spaceBtwSections * 0.8,
                  ),
                  JTextArea(
                      label: Text('Enter Postal Code'),
                      maxAreaHeight: 1,
                      minAreaHeight: 1,
                      prefixIcon: Icon(Iconsax.personalcard)),

                  SizedBox(height: JSizes.spaceBtwSections * 4),


                  Center(
                    child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(JSizes.md),
                          ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Send Verification Request", style: Theme.of(context).textTheme.titleLarge,),
                                SizedBox(width: JSizes.sm,),
                                Icon(Iconsax.tick_circle, color: Colors.green, size: 25,),
                              ],
                            )
                        ),
                  ),


                  SizedBox(height: JSizes.spaceBtwSections),

                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SignUpNavigationButtons(
            onPressed: () {},
          ),

          SizedBox(height: JSizes.md,),

          Padding(
            padding: const EdgeInsets.only(
                bottom: JSizes.spaceBtwSections, top: JSizes.md),
            child: Positioned(
                bottom: JDeviceUtils.getBottomNavigationBarHeight(),
                left: 0,
                right: 0,
                child: StepIndicator(currentIndex: currentStep, totalSteps: 4)),
          ),
        ],
      ),
    );
  }
}
