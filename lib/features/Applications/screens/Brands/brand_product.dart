import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/applications/sortable/sortable_application.dart';
import 'package:project_bc_tuto/features/Applications/models/company_model.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/companies/compagny_cardsV2.dart';
import '../../../personilization/controllers/company_controller.dart';

class BrandProduct extends StatelessWidget {
   BrandProduct({super.key, required this.company});

  final Controller = Get.put(CompanyController());
  final CompanyModel company;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Text(company.fullName.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium,), showBackArrow: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Brand Details
              JCompagnyCard2(showBorder: true, company: company,),
              SizedBox(height: JSizes.spaceBtwSections,),

              JSortableApplications(company: company,),

            ],
          ),
        ),
      )
    );
  }
}
