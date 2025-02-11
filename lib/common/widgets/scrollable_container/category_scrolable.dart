import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../utils/constants/colors.dart';

class JCategoryTab extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const JCategoryTab({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return JRoundedContainer(
      width: MediaQuery.of(context).size.width * 0.9,
      //width: JSizes.mobileScreenSize.toDouble(),
      height: 100,
      showBorder: true,
      backgroundColor: JColors.lightGrey,
      radius: 25,
      borderWidth: 3,
      borderColor:dark ? JColors.darkGrey : JColors.grey,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: categories.map((category) {
            return GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: category["color"],
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Icon(
                        category["icon"],
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      category["name"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}