import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../quiz_creation/QuizMainpage.dart';

class QuickActioons extends StatelessWidget {
  const QuickActioons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        JSectionHeading(
          title: "Quick actions :",
          TextSize: 25,
          showActonButton: false,
        ),

        SizedBox(
          height: JSizes.spaceBtwItems,
        ),


        GestureDetector(
          onTap: () {},
          child: JRoundedContainer(
            backgroundColor: Colors.purple.shade50,
            padding: EdgeInsets.all(JSizes.md),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Resume Posting Creation",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Poppins"),
                ),
                Icon(
                  Iconsax.arrow_right_3,
                  size: 30,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: JSizes.spaceBtwItems * 1.3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {},
              child: JRoundedContainer(
                backgroundColor: Colors.blue.shade100,
                padding: EdgeInsets.all(JSizes.md),
                width: 162,
                height: 150,
                child: Stack(
                  children: [

                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.8,
                        child: Icon(
                          Iconsax.briefcase,
                          size: 50,
                          color: JColors.secondary,
                        ),
                      ),
                    ),


                    Center(
                        child: Text(
                          "Create a New Posting",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Poppins",
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(() => const QuizCreationPage()),
              child: JRoundedContainer(
                backgroundColor: Colors.greenAccent.shade100,
                padding: EdgeInsets.symmetric(horizontal:  JSizes.md),
                width: 162,
                height: 150,
                child: Stack(children: [

                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.4,
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Opacity(
                      opacity: 0.4,
                      child: Icon(
                        Icons.help_outline_rounded,
                        size: 50,
                        color: Colors.green,
                      ),
                    ),
                  ),


                  Center(
                      child: Text(
                        "Create a New Quiz",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ))
                ]),
              ),
            ),
          ],
        ),

        SizedBox(height: JSizes.spaceBtwItems * 1.3),

        GestureDetector(
          onTap: () {},
          child: JRoundedContainer(
            backgroundColor: Colors.yellow.shade100,
            padding: EdgeInsets.all(JSizes.md),
            width: double.infinity,
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Send a Proposal",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "Poppins"),
                ),
                Icon(
                  Iconsax.direct_right5,
                  size: 40,
                  color: Colors.teal,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
