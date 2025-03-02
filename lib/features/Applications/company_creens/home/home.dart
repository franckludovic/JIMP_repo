import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/home/widgets/company_home_header.dart';
import 'package:project_bc_tuto/features/Applications/company_creens/home/widgets/home_stats_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class CompanyHome extends StatelessWidget {
  const CompanyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CompanyHomeHeader(),
            Padding(
              padding: EdgeInsets.all(JSizes.defaultSpace),
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            JRoundedContainer(height: 150, width: 162),
                            JRoundedContainer(height: 150, width: 162),
                          ],
                        ),
                        SizedBox(
                          height: JSizes.md,
                        ),
                        JRoundedContainer(
                          height: 150,
                          width: double.infinity,
                        ),
                        JRoundedContainer(
                          margin: EdgeInsets.symmetric(vertical: JSizes.md),
                            width: double.infinity,
                            height: 350,
                            backgroundColor: JColors.grey,
                            child: CompanyStatsBox())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
