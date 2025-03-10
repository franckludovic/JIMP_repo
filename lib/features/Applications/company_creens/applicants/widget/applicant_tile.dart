import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/applicant_details/applicants_details.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ApplicantTile extends StatelessWidget {

  final double percent;

  const ApplicantTile({super.key, this.percent = 0.79});

  @override
  Widget build(BuildContext context) {

    Color progressColor;
    if (percent < 0.30) {
      progressColor = Colors.red;
    } else if (percent >= 0.31 && percent < 0.49) {
      progressColor = Colors.orangeAccent;
    } else if (percent >= 0.50 && percent < 0.80) {
      progressColor = Colors.green.shade700;
    } else {
      progressColor = JColors.primary;
    }

    return GestureDetector(
      onTap: () => Get.to(() => ApplicantsDetails()),
      child: JRoundedContainer(
        height: 115,
        padding: EdgeInsets.symmetric(horizontal: JSizes.sm),
        margin: EdgeInsets.symmetric(vertical: JSizes.sm),
        showBorder: true,
        borderColor: Colors.black,
        backgroundColor: JColors.lightGrey,
        width: double.infinity,
        child: Row(
          children: [
            JRoundedImage(
              imageUrl: JImages.user3,
              border: Border.all(color: Colors.black, width: 2.5),
              borderRadius: 70,
              width: 70,
              height: 70,
            ),
            SizedBox(width: JSizes.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Franck Lucien",
                  style: TextStyle(color: JColors.black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Software engineer intern",
                  style: TextStyle(color: JColors.darkGrey, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Match",
                      style: TextStyle(color: JColors.black, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: LinearPercentIndicator(
                        width: JDeviceUtils.getScreenWidth(context) - 225.5,
                        animation: true,
                        lineHeight: 10.0,
                        animationDuration: 2000,
                        percent: percent,
                        barRadius: Radius.circular(10),
                        progressColor: progressColor,
                      ),
                    ),

                    Text("${percent * 100}%", style: TextStyle(color: JColors.black, fontWeight: FontWeight.bold),)
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}