import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class CategoriesSelector extends StatefulWidget {
  const CategoriesSelector({super.key});

  @override
  State<CategoriesSelector> createState() => _CategoriesSelectorState();
}

class _CategoriesSelectorState extends State<CategoriesSelector> {
  int selectedIndex = 0;
  final List<String> categories = ['Message', 'Online', 'Teams', 'Requests'];

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 80.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(JSizes.md),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Text(
                categories[index],
                style: TextStyle(
                    fontSize: 22.0,
                    fontFamily: 'Poppins',
                    color: index == selectedIndex
                        ? JColors.primary
                        : dark
                            ? JColors.grey
                            : JColors.darkGrey,
                    fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),

              ),
            ),
          );
        },
      ),
    );
  }
}
