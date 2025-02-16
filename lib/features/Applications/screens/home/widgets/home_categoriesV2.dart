import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/features/Applications/screens/sub_category/sub_category.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../utils/constants/image_strings.dart';


class JhomeCategories extends StatelessWidget {
  const JhomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return  VertivalImageText(image: JImages.electronicsIcon, title: "Phones", onTap: () => Get.to(() => SubCategoryScreen() ),);
        },
      ),
    );
  }
}
