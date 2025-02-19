import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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

    return SizedBox(
      height: 100,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return  VertivalImageText(image: FontAwesomeIcons.robot, textColor: dark ? JColors.white : JColors.black , title: "AI", onTap: () => Get.to(() => SubCategoryScreen() ),);
        },
      ),
    );
  }
}
