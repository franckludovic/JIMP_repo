import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';

import '../../../../common/widgets/Type_user/selection_type_user_card.dart';
import '../../../../navigation_menu.dart';
import '../../../../navigation_menu_company.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class JTypeUser extends StatelessWidget {
  const JTypeUser({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
        
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: JSizes.sm),
              child: Image.asset(
                dark ? JImages.logo_dark : JImages.logo_light,
                height: 380,
                width: 380,
              ),
            ),
        
        
           Container(
             margin: EdgeInsets.all(10),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
        
                  children: [
                    Text ("Continue as",
                      style: Theme.of(context).textTheme.headlineLarge!.apply(color: JColors.primary) ,
                      textAlign: TextAlign.left,
                    ),
                    Text("Here to find an Opportunity? we got you, here to find a special candidate guess what? we still got you covered",
                      style: dark ?  Theme.of(context).textTheme.bodyMedium!.apply(color: JColors.grey) : Theme.of(context).textTheme.bodyMedium ,
                      textAlign: TextAlign.left
                    ),
                  ],
              ),
           ),
            Container(
              margin: EdgeInsets.all(30),
              child: Column(
                children: [
                  SelectionCard(
                    title: "Company",
                    subtitle: JTexts.compagnytText,
                    image: JImages.company_user,
                    onTap: () => Get.offAll( const CompanyNavigationMenu()),
                  ),

                  SizedBox(height: JSizes.spaceBtwSections),
        
                  SelectionCard(
                    title: "Candidate",
                    subtitle: JTexts.candidateText,
                    image: JImages.candidate_user,
                    onTap:() => Get.offAll( const CandidateNavigationMenu()),
                  ),
        
        
                ],
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}




