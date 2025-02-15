import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/companies/desciption_info_tile.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/Info_row.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/available_applications.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_header.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_rating_subtitle.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../application_reviews/product_reviews.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

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

            SizedBox(height: JSizes.spaceBtwSections * 0.6,),

            CompanyRatingSubTitle(
                rating: '4.5',
                companyName: 'Google',
                country: 'Cameroon',
                region: 'Littoral',
                town: 'Douala',
                quater: 'Bonanjo',
            ),

            SizedBox(height: JSizes.spaceBtwSections),

            ContactInfo(),

            SizedBox(height: JSizes.spaceBtwSections),

            InfoTile(
              title: "About the Company : ",
              titleSize: 25,
              spacing: JSizes.sm,
              textBody: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
            ),


            SizedBox(height: JSizes.spaceBtwSections),

            Divider(thickness: 3, indent: 20, endIndent: 20,),

            const SizedBox(height: JSizes.spaceBtwItems,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: JSizes.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  JSectionHeading(title: "Review (199)",showActonButton: false,),
                  IconButton(icon: const  Icon(Iconsax.arrow_right_3), onPressed: () => Get.to(() => ApplicationReviewScreen()) )
                ],
              ),
            ),
            const SizedBox(height: JSizes.spaceBtwItems,),



          ],
          
        ),

      ),
      bottomNavigationBar:SizedBox(height : 90  ,child: AvailableApplications(appnum: 12,)) ,
    );
  }
}

