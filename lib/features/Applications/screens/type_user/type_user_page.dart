import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';

class JTypeUser extends StatelessWidget {
  const JTypeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "assets/logos/logo_dark6.png",
              height: 60,
              width: 60,
            ),
          ),

          Text("Continue as", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: JColors.black)),
          SizedBox(height: 25),


          JRoundedContainer(
            showBorder: true,
            borderColor: JColors.darkerGrey,
            padding: const EdgeInsets.all(JSizes.md),
            backgroundColor: Colors.transparent,
            margin: const EdgeInsets.only(bottom: JSizes.spaceBtwItems),
            child: Row(
              children: [
                Image.asset(
                  JImages.company_user,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),

                Column(
                  children: [
                    Text("Company"),
                    Text(JTexts.compagnytText),
                  ],
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
  

