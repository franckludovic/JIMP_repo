import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';


class JApplicationTitleText extends StatelessWidget {
  const JApplicationTitleText({
    super.key,
    required this.title,
    this.smallSize = false,
    this.maxLines = 2,
    this.textAlign,
    this.textSize = 20,
  });

  final String title;
  final bool smallSize;
  final int maxLines;
  final TextAlign? textAlign;
  final double textSize;

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Text(
        title,
        style: (smallSize
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.titleSmall)
            ?.copyWith(fontSize: textSize, fontWeight: FontWeight.bold, color: JColors.dark),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
