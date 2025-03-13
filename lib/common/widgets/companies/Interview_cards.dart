
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../features/Applications/company_creens/applicant_details/applicants_details.dart';

class JUserInterviewCards extends StatelessWidget {
  const JUserInterviewCards({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ApplicantsDetails(isSheduled: true,)),
      child: JRoundedContainer(
        padding: EdgeInsets.symmetric(horizontal: JSizes.md * 0.8, ),
        showBorder: true,
        borderColor: Colors.black,
        backgroundColor: JColors.lightGrey,
        width: double.infinity,
        child: Row(
          children: [
            JRoundedImage(imageUrl: JImages.user3, border: Border.all(color: Colors.black, width: 2.5), borderRadius: 80 ,  width: 80, height: 80,),

            SizedBox(width: JSizes.sm,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 15,),
                Text("Franck Lucien", style: TextStyle(color: JColors.black, fontSize: 23, fontWeight: FontWeight.bold),),
                Text("Software engineer intern",  style: TextStyle(color: JColors.darkGrey, fontWeight: FontWeight.bold),),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [
                        Text("10pm", style: TextStyle(color: JColors.darkerGrey, fontSize: 15),),
                        Icon(Iconsax.clock, color: JColors.darkerGrey, size: 20,),
                      ],
                    ),

                    SizedBox(width: JSizes.spaceBtwSections * 2.5,),

                    Text("12-08-2023", style: TextStyle(color: JColors.darkerGrey, fontSize: 15),),

                  ],
                )

              ],
            )
          ],
        ),
      ),
    );
  }
}
