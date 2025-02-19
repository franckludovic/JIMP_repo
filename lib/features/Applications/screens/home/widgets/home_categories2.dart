import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';


class homeCategories extends StatelessWidget {
  const homeCategories({
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
          return  VertivalImageText(image: FontAwesomeIcons.robot, title: "Phones", onTap: () {},);
        },
      ),
    );
  }
}
