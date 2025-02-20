import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import 'package:project_bc_tuto/common/widgets/layout/grid_layout.dart';
import 'package:project_bc_tuto/features/Applications/screens/search_page/widgets/filter_tags.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/job_and_internship_card/intership_cards.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../personilization/screens/settings/settings.dart';

class SearchBody extends StatelessWidget {
  const SearchBody({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(title: Text('Search'), showBackArrow: true),
      body: SingleChildScrollView(
        child:Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.only(left: JSizes.md),
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all( color: dark ? JColors.grey : JColors.black),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(5),
                        ),
                        color: Colors.transparent,
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type to search",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 5,),
                  Flexible(
                    flex: 2,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(color: JColors.white),
                        color: dark ? JColors.white : JColors.grey,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(5),
                          bottomRight: Radius.circular(20),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: IconButton(onPressed:() {}, icon: Icon(Icons.search_rounded, color: JColors.secondary ,size: 30,)),
                      )
                    ),
                ],
              ),



              SizedBox(height: JSizes.spaceBtwItems),

               Container(
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Results', style: Theme.of(context).textTheme.headlineMedium,),
                          Text('45 Internship founded', style: TextStyle(fontSize: 15, color: dark ? JColors.darkGrey : JColors.darkerGrey))
                        ],
                      ),
                     
                     IconButton(onPressed: () {}, icon: Icon(Iconsax.candle, size: 30, color: dark ? JColors.white : JColors.black,))

                   ],
                 ),
               ),

              SizedBox(height: JSizes.spaceBtwItems),

              JSearchFilterTag(
                textColor: JColors.black,
                backgroundColor: dark ? JColors.primary :JColors.primary.withAlpha((0.6 * 255).toInt()),
                tags: [
                  'Remote working','FullTime', "Flutter", "Douala"
                ]
              ),

              JDivider(),

              Container(
                child: JGridLayout(
                    itemCount: 8,
                    crossAxisCount: 1,
                    mainAxisExtend: 200,
                    itemBuilder: (_, index) {
                      return  HorizontalJIntershipCard( borderRadius: 15, iconBorderRad: 8 ,companyLogo: JImages.google,companyName: "Google",duration: "5 - 6 month",jobTitle: "SoftWare Engineer", location: "London",skills: ["python", "java", "C++"],onTap: () => (const SettingScreen()),);
                    }
                ),
                  //JCompagnyShowCase(),
              )
            ],
          ),
        )
      ),
    );
  }
}
