import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/applicants/widget/applicant_tile.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../screens/Applicaton_details/myWidgets/application_tags.dart';
import '../../screens/search_page/widgets/SearchTextField.dart';

class ApplicantsScreens extends StatelessWidget {
  const ApplicantsScreens({super.key});

  @override
  Widget build(BuildContext context) {

    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: JAppbar(title: Text("Applicants", style: Theme.of(context).textTheme.headlineMedium,)),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.spaceBtwItems / 2),
          child: Column(
            children: [
              SizedBox(child: SearchTextField(isFilter: true,)),

              SizedBox(height: JSizes.spaceBtwSections *1.5,),

              SizedBox(
                height: 80,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(

                      child: SizedBox(
                        height: 20,
                        child: JApplicatonTags(
                          tags: [
                            'Applied', "Interviews", "Best Match", "All positions"
                          ],
                        ),
                      ),
                    );
                }
                ),
              ),

              SizedBox(
                height: JDeviceUtils.getScreenHeight(),
                child: Container(
                  padding: EdgeInsets.all(JSizes.sm),

                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: dark ? Colors.white : JColors.dark, width: 3)),
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))
                  ),

                  child: SizedBox(
                    child: ListView.builder( itemCount: 10 ,itemBuilder: (BuildContext context, int index){
                      return ApplicantTile();
                    }
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
