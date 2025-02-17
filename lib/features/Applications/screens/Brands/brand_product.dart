import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/applications/sortable/sortable_application.dart';
import 'package:project_bc_tuto/common/widgets/companies/compagny_cards.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class BrandProduct extends StatelessWidget {
  const BrandProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(title: Text('Nike'),),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(JSizes.defaultSpace),
          child: Column(
            children: [
              ///Brand Details
              JCompagnyCard(showBorder: true),
              SizedBox(height: JSizes.spaceBtwSections,),

              JSortableApplications(),

            ],
          ),
        ),
      )
    );
  }
}
