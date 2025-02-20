import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';

import '../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

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

              JAppbar(
                title: Column(
                  children: [
                    Text('Result', style: Theme.of(context).textTheme.headlineMedium,),
                    Text('45 results', style: TextStyle(fontSize: 10))
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
