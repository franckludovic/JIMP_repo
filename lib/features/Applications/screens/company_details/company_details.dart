import 'package:flutter/material.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_header.dart';
import 'package:project_bc_tuto/features/Applications/screens/company_details/widgets/company_detail_rating_subtitle.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../utils/constants/sizes.dart';

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



          ],
        ),
      ),
    );
  }
}
