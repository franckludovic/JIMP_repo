import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/enums.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import 'compagny_title_text.dart';

class JCompagnyTittleVerifications extends StatelessWidget {
  const JCompagnyTittleVerifications({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textColor,
    this.iconColor = JColors.primary,
    this.textAlign = TextAlign.center,
    this.compagnyTextSize = TextSizes.medium, 
    this.isVerified = true,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes compagnyTextSize;
  final bool isVerified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: JCompagnyTitleText(
            title: title,
            color: textColor,
            maxLines: maxLines,
            textAlign: textAlign,
            compagnyTextSize: compagnyTextSize,
          ),
        ),
        const SizedBox(width: JSizes.xs),
        isVerified ? Icon(Iconsax.verify5, color: iconColor, size: JSizes.iconSm) : Text(""),
      ],

    );
  }
}

