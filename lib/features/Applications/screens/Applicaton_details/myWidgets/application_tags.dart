import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';

class JApplicatonTags extends StatelessWidget {
  const JApplicatonTags({
    super.key,
    required this.tags,
    this.textColor = JColors.white,
    this.borderColor = JColors.secondary,
    this.backgroundColor = JColors.darkGrey,
    this.fontSize = 17,
    this.title,
    this.minWidth = 70,
  });

  final List<String> tags;
  final Color textColor;
  final double fontSize;
  final Color borderColor;
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
          children: tags.map((tag) => _buildTag(tag)).toList(),
        ),
      ],
    );
  }


  Widget _buildTag(String tag) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: JRoundedContainer(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        backgroundColor: backgroundColor,
        borderColor: borderColor,
        showBorder: true,
        borderWidth: 1.5,
        radius: 20,
        width: null,
        child: Text(
          tag,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
