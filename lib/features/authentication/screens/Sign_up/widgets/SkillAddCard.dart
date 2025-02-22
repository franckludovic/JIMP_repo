import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class SkillAddCard extends StatelessWidget {
  const SkillAddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.sm),
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(color: dark ? JColors.grey : JColors.black),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5),
          topRight: Radius.circular(5),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Colors.transparent,
      ),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                flex: 10,
                child: Row(
                  children: [
                    const Icon(Iconsax.arrow_right_4, size: 30,),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type to search",
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(onPressed: () {}, icon: Icon(Iconsax.trush_square, size: 35,))
            ],
          ),
          Divider(thickness: 3,),
          SizedBox(height: JSizes.md,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Level : ", style: Theme.of(context).textTheme.headlineSmall,),

              SizedBox(width: JSizes.sm,),
              
              GestureDetector(
                child: JRoundedContainer(width: 30, height: 30, backgroundColor: Colors.transparent ,borderColor: JColors.darkGrey, showBorder: true, borderWidth: 3 ,child: Center(child: Text("1")),),
              ),
              SizedBox(width: JSizes.md,),

              GestureDetector(
                child: JRoundedContainer(width: 30, height: 30, backgroundColor: Colors.transparent ,borderColor: JColors.darkGrey, showBorder: true, borderWidth: 3 ,child: Center(child: Text("2")),),
              ),
              SizedBox(width: JSizes.md,),

              GestureDetector(
                child: JRoundedContainer(width: 30, height: 30, backgroundColor: Colors.transparent ,borderColor: JColors.darkGrey, showBorder: true, borderWidth: 3 ,child: Center(child: Text("3")),),
              ),
              SizedBox(width: JSizes.md,),

              GestureDetector(
                child: JRoundedContainer(width: 30, height: 30, backgroundColor: Colors.transparent ,borderColor: JColors.darkGrey, showBorder: true, borderWidth: 3 ,child: Center(child: Text("4")),),
              ),
              SizedBox(width: JSizes.md,),

              GestureDetector(
                child: JRoundedContainer(width: 30, height: 30, backgroundColor: Colors.transparent ,borderColor: JColors.darkGrey, showBorder: true, borderWidth: 3 ,child: Center(child: Text("5")),),
              ),

            ],
          )

          
        ],
      ),
    );
  }
}
