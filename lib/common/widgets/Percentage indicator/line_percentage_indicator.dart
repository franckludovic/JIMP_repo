import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../utils/constants/colors.dart';

class LinePercentageIndidctor extends StatelessWidget {
  const LinePercentageIndidctor({
    super.key,
    required this.percent, required this.width,

  });

  final double percent;
  final double width;


  @override
  Widget build(BuildContext context) {

    Color progressColor;
    if (percent < 0.30) {
      progressColor = Colors.red;
    } else if (percent >= 0.31 && percent < 0.49) {
      progressColor = Colors.orangeAccent;
    } else if (percent >= 0.50 && percent < 0.80) {
      progressColor = Colors.green.shade700;
    } else {
      progressColor = JColors.primary;
    }
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: LinearPercentIndicator(
        width: width,
        animation: true,
        lineHeight: 10.0,
        animationDuration: 2000,
        percent: percent,
        barRadius: Radius.circular(10),
        progressColor: progressColor,
      ),
    );
  }
}