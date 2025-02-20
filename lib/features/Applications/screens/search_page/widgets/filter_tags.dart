import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';

class JSearchFilterTag extends StatelessWidget {
  const JSearchFilterTag({
    super.key,
    required this.tags,
    this.textColor = JColors.white,
    this.borderColor,
    this.backgroundColor = JColors.darkGrey,
    this.fontSize = 17,
    this.title,
    this.minWidth = 70,
  });

  final List<String> tags;
  final Color textColor;
  final double fontSize;
  final Color? borderColor;
  final Color backgroundColor;
  final String? title;
  final double minWidth;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: JDeviceUtils.getScreenWidth(context),
      child: Column(
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
      ),
    );
  }

  Widget _buildTag(BuildContext context,String tag) {

    final dark = JHelperFunctions.isDarkMode(context);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: minWidth),
      child: JRoundedContainer(
        padding: const EdgeInsets.only(right: 10, left: 3, top: 3, bottom: 3),
        margin: const EdgeInsets.only(bottom: 5),
        backgroundColor: backgroundColor,
        showBorder: true,
        radius: 50,
        width: null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundColor: dark ? JColors.grey : JColors.secondary,
                child: Center(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.close,
                          color: JColors.black,
                        )
                    )
                )
            ),
            SizedBox(
              width: JSizes.xs,
            ),
            Text(
              tag,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
