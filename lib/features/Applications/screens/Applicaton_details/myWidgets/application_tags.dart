import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';

class JApplicatonTags extends StatelessWidget {
  const JApplicatonTags({
    super.key,
    required this.tags,

    this.borderColor,
    this.backgroundColor = JColors.grey,
    this.fontSize = 17,
    this.title,
    this.minWidth = 70,
  });

  final List<String> tags;

  final double fontSize;
  final Color? borderColor;
  final Color backgroundColor;
  final String? title;
  final double minWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        if (title != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              title!,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

        /// Tags
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: tags.map((tag) => _buildTag(context, tag)).toList(),
        ),
      ],
    );
  }


  Widget _buildTag(BuildContext context, String tag) {

    final dark = JHelperFunctions.isDarkMode(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: GestureDetector(
        onTap: () {},
        child: JRoundedContainer(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          backgroundColor: backgroundColor,
          //borderColor: borderColor!,
          showBorder: true,
          //borderWidth: 1.5,
          radius: 20,
          width: null,
          child: Text(
            tag,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: dark ? JColors.black : JColors.black,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
