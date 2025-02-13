import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';

class JRatingProgressIndicator extends StatelessWidget {
  const JRatingProgressIndicator({
    super.key,
    required this.text,
    required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded( flex: 1, child: Text(text, style: Theme.of(context).textTheme.bodyMedium)),
        Expanded(
          flex: 11,
          child: SizedBox(
            width: JDeviceUtils.getScreenWidth(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: JColors.grey,
              valueColor: AlwaysStoppedAnimation(JColors.primary),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        )
      ],
    );
  }
}
