import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/companies/desciption_info_tile.dart';
import 'package:project_bc_tuto/navigation_menu.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../company_details/company_details.dart';
import 'myWidgets/JApply_and_save_button.dart';
import 'myWidgets/application_header.dart';
import 'myWidgets/application_tags.dart';
import '../../../../common/widgets/companies/info_boxes.dart';
import '../../../../common/widgets/companies/logation_info.dart';
import 'myWidgets/time_frame.dart';

class MyApplicationDetails extends StatelessWidget {
  const MyApplicationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: JSizes.xs),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              JAppbar(
                title: Text("Details", style: TextStyle(fontFamily: "Poppins", fontSize: 30, color: dark ? JColors.primary : JColors.black)),
                leadingIcon: Iconsax.arrow_left_3,
                leadingOnPressed:() => Get.to(() => CandidateNavigationMenu() ),

              ),
              Divider(thickness: 2),

              JApplicationHeader(
                onTapLogo: () => Get.to(() => CompanyDetails()),
                companyLogo:JImages.google ,
                companyName: "Google",
                internshipName: "Senior Software Engineer",
              ),

              Divider(indent: 30, endIndent: 30, thickness: 3,),
              SizedBox(height: JSizes.spaceBtwItems,),

              Container(
                padding: EdgeInsets.symmetric(horizontal: JSizes.lg),
                child: JApplicatonTags(
                  tags: [
                    'FullTime', "Remote", "Verified"
                  ],
                ),
              ),

              SizedBox(height: JSizes.spaceBtwSections,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: JSizes.md),
                child: LocationInfo(
                  country: 'Cameroon',
                  region: 'Littoral',
                  town: 'Douala',
                  quater: 'Bonanjo',
                ),
              ),

              SizedBox(height: JSizes.spaceBtwSections,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: JSizes.md),
                child: TimeFrame(timeFrame: '5 - 6 Month',),
              ),

              SizedBox(height: JSizes.spaceBtwSections,),

              InfoTile(
                title: 'Your Role :',
                textBody:"You will be working on the Infrastructure  team and contributing to the development of our systems",
              ),

              SizedBox(height: JSizes.spaceBtwSections,),

              JApplicatonTags(
                title: "Skills Needed :",
                tags: [
                  'JAVA', 'NPL with PYTHON', 'R', 'C#', 'NPL', 'Deep Learning'
                ],
              ),

              SizedBox(height: JSizes.spaceBtwSections * 1.7),

              InfoTile(
                title: 'Minimum qualifications :',
                textBody:"Currently enrolled in a Bachelor's or Master's degree program. Experience with data analysis and visualization tools."
              ),


              SizedBox(height: JSizes.spaceBtwSections * 1.7),

              InfoTile(
                  title: 'Preferred qualifications :',
                  textBody:"Experience programming in Python and have good knowledge in Deep learning. Demonstrated ability to communicate with technical and non-technical audiences."
              ),


              SizedBox(height: JSizes.spaceBtwSections * 1.7),

              InfoTile(
                  title: 'Additional Info :',
                  textBody:"Our team is looking for interns who are passionate about data and have a strong desire to learn more about data infrastructure."
              ),


              SizedBox(height: JSizes.spaceBtwSections * 1.7),

              StatsBox(
                matchPercentage: 70.5,
                placesLeft:80,
                rating: 4.5,
              ),

              SizedBox(height: JSizes.spaceBtwItems),

              const Divider(),

              const SizedBox(height: JSizes.spaceBtwSections,),

      ],
          ),
        ),
      ),
      bottomNavigationBar: JApplySaveButton(),
    );

  }
}


