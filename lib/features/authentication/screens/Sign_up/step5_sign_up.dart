import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/success_screen/success_screen.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/info_Row.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/step_indicator.dart';
import 'package:project_bc_tuto/features/authentication/screens/login/login.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';

import '../../../../common/widgets/Percentage indicator/circular_pencentage_indicator.dart';
import '../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../utils/device/device_utility.dart';


class CandidateRegisterScreen5 extends StatefulWidget {
  const CandidateRegisterScreen5({super.key});

  @override
  State<CandidateRegisterScreen5> createState() => _CandidateRegisterScreen5State();
}

class _CandidateRegisterScreen5State extends State<CandidateRegisterScreen5> {
  int currentStep = 4;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: JAppbar(
          title: Text(
            'Candidate',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          showBackArrow: true,

        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(JSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

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
                            child: const Text("Profile image", style: TextStyle(color: Colors.black),),
                          ),

                          Positioned(
                            bottom: -13,
                            left: 120,
                            child: IconButton(
                              icon: const Icon(Iconsax.edit),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: JSizes.md),
                      const Text(
                        "Licht Lucieniel",
                        style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: JSizes.sm),
                      Row(
                        children: [
                          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.github, size: 35,)),
                          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.linkedin, size: 35,)),
                          IconButton(onPressed: () {}, icon: Icon(FontAwesomeIcons.folder, size: 35,)),
                        ],
                      )
                    ],
                  ),
                ),


                buildInfoCard(
                  context,
                  [
                    CandidateInfoRow(leadingIcon:Icons.person , title: "Licht Lucieniel"),
                    CandidateInfoRow(leadingIcon:Icons.email , title: "lichtlucien@gmail.com"),
                    CandidateInfoRow(leadingIcon:Icons.phone , title:"+654 78 96 38"),
                    CandidateInfoRow(leadingIcon:Icons.lock , title:"**********"),

                  ],
                ),


                buildInfoCard(
                  context,
                  [

                    CandidateInfoRow(leadingIcon: Icons.location_on, title: "Cameroon, Littoral, Douala"),
                    CandidateInfoRow(leadingIcon: Icons.school, title: "BTech CSE (in progress)"),
                    CandidateInfoRow(leadingIcon: Icons.business, title: "Institut Universitaire de la Côte"),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        "Job Preference:",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("• Bioinformatic Engineer", style: TextStyle(color: Colors.black),),
                          Text("• Biotech Engineer", style: TextStyle(color: Colors.black),),
                        ],
                      ),
                    ),
                  ],
                ),


                buildInfoCard(
                  context,
                  [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Life is a characteristic distinguishing physical entities having biological processes...",
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildUploadButton("Resume"),
                        buildUploadButton("Cover Letter"),
                      ],
                    ),
                  ],
                ),

                SizedBox(height: JSizes.spaceBtwItems     ),

                // Skills & Languages

                JRoundedContainer(
                  backgroundColor: Colors.grey.shade200,
                  child: Column(
                    children: [
                      JRoundedContainer(
                          height: 156,
                          backgroundColor: Colors.grey.shade200,
                          padding: EdgeInsets.symmetric(vertical: JSizes.md),
                          child: ListView.builder(
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index){
                                return
                                  SizedBox(child: JCircularSkillIndicator(percentage: 0.5, bottomText: 'python', ));
                              }
                          )
                      ),
                      SizedBox(height: JSizes.spaceBtwSections),
                      const Text("Languages:", style: TextStyle(fontSize: 16, color: Colors.black)),
                      SizedBox(height: JSizes.sm,),
                      const Text("🔘 French  🔘 English  🔘 Latin", style: TextStyle(color: Colors.black),),
                      SizedBox(height: JSizes.spaceBtwSections),
                    ],
                  ),
                ),

                // Finish Button
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () => Get.to(() => SuccessScreen(image: JImages.staticSuccessIllustration, title: JTexts.yourAccountCreatedTitle, subTitle: JTexts.yourAccountCreatedSubTitle, onPressed: () => Get.offAll(() => CandidateLoginScreen()),),),
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
          child: Positioned(
              bottom: JDeviceUtils.getBottomNavigationBarHeight(),
              left: 0,
              right: 0,
              child: StepIndicator(currentIndex: currentStep, totalSteps: 5)
          ),
        ),
    );
  }

  Widget buildInfoCard(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: JColors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(children: children),
    );
  }



  Widget buildUploadButton(String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[300],
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      ),
      onPressed: () {},
      child: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }

}




