import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/companies/desciption_info_tile.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/Info_row.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_header.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_rating_subtitle.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/recuiter_info.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/text_strings.dart';

import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'add_recruiter.dart';

class CompanySignUpReview extends StatelessWidget {
  const CompanySignUpReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CompagnyDetailsHeader(
                companyName: 'Google',
                companyLogo: JImages.google,
                companyProfileImage: JImages.googleProfileImage),
            SizedBox(
              height: JSizes.spaceBtwSections * 0.6,
            ),
            CompanyRatingSubTitle(
              companyName: 'Google',
              country: 'Cameroon',
              region: 'Littoral',
              town: 'Douala',
              quater: 'Bonanjo',
              isRated: false,
            ),
            SizedBox(height: JSizes.spaceBtwSections),
            ContactInfo(),
            SizedBox(height: JSizes.spaceBtwSections),
            InfoTile(
              title: "About the Company : ",
              titleSize: 25,
              spacing: JSizes.sm,
              textBody:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),
            SizedBox(height: JSizes.spaceBtwSections),
            Divider(
              thickness: 3,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(
              height: JSizes.spaceBtwItems,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.sm),
              child: JSectionHeading(
                title: "View Recruiter Info",
                showActonButton: false,
              ),
            ),
            const SizedBox(
              height: JSizes.spaceBtwItems,
            ),
            JRoundedContainer(
              margin: EdgeInsets.all(JSizes.md),
              padding: EdgeInsets.all(JSizes.sm),
              backgroundColor: JColors.lightContainer,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          JRoundedImage(
                            imageUrl: JImages.user3,
                            width: 80,
                            height: 80,
                            borderRadius: 100,
                          ),
                          SizedBox(
                            width: JSizes.sm,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Elsa Luciens",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontFamily: "Poppins",
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Senior Engineer",
                                  style: TextStyle(
                                    color: JColors.darkGrey,
                                    fontSize: 18,
                                    fontFamily: "Poppins",
                                  )),
                              Text("ID : GNX001235",
                                  style: TextStyle(
                                    color: JColors.primary,
                                    fontSize: 15,
                                    fontFamily: "Poppins",
                                  )),
                            ],
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () => Get.to(() => RecruiterInfo()),
                          icon: Icon(
                            Iconsax.arrow_right_3,
                            size: 30,
                            color: JColors.black,
                          ))
                    ],
                  )
                ],
              ),
            ),

            ///add new recruiter and view current recruiters
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                margin: EdgeInsets.symmetric(vertical: JSizes.lg, horizontal: JSizes.md),
                child: ElevatedButton(
                  onPressed: () => Get.to(() => const AddRecruiterForm()),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(JSizes.md),
                    textStyle: TextStyle(color: JColors.black, fontSize: 18, fontFamily: "Poppins"),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Recruiter"),
                      Icon(Iconsax.add, size: 30,),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(JSizes.lg),
        child: SizedBox(
            height: 60,
            child: ElevatedButton(
                onPressed: () => Get.to(() => SuccessScreen(
                      image: JImages.staticSuccessIllustration,
                      title: JTexts.yourAccountCreatedTitle,
                      subTitle: JTexts.yourAccountCreatedSubTitle,
                    )),
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                ))),
      ),
    );
  }
}
