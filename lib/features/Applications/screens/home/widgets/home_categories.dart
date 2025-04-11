import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/shimmer/categoryShimmerloader.dart';
import 'package:project_bc_tuto/features/Applications/controllers/category_controller.dart';
import 'package:project_bc_tuto/features/Applications/screens/sub_category/sub_category.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';

class JhomeCategories extends StatelessWidget {
  const JhomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (categoryController.isLoading.value) return JCategoryShimmer();

      if (categoryController.featuredCategories.isEmpty) {
        return Center(
          child: Text(
            'No Data Found',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.white),
          ),
        );
      }

      return SizedBox(
        height: 100,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: categoryController.featuredCategories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            final category = categoryController.featuredCategories[index];
            return VerticalImageText(
              icon:  Icon(category.iconData, color: category.iconColor, size: 35),
              textColor: dark ? JColors.white : JColors.black,
              title: category.name,
              onTap: () => Get.to(() => SubCategoryScreen()),
            );
          },
        ),
      );
    });
  }
}
