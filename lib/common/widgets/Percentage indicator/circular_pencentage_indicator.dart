import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../pop_up/pop_up.dart';

class JCircularSkillIndicator extends StatelessWidget {
  const JCircularSkillIndicator({
    super.key,
    this.radius = 35,
    this.lineWidth = 11.0,
    this.animation = true,
    required this.percentage,
    this.textPercent ,
    required this.bottomText,
    this.progressColor = JColors.secondary,
    this.backgroundColor,
    this.centerTextFontSize = 15.0,
    this.bottomTextFontSize = 10.0,
    this.cardbackgroudColor
  });

  final double radius;
  final double lineWidth;
  final bool animation;
  final double percentage;
  final String? textPercent;
  final String bottomText;
  final Color progressColor;
  final Color? backgroundColor;
  final double centerTextFontSize;
  final double bottomTextFontSize;
  final Color? cardbackgroudColor;




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()  => showCustomPopup(),
      child: Container(
        padding: EdgeInsets.all(9),
        height: 150,

        margin: EdgeInsets.only(left: 18, top: 6, bottom: 2),
        decoration: BoxDecoration(
          color: cardbackgroudColor ?? (JHelperFunctions.isDarkMode(context) ? JColors.darkerGrey : JColors.white),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5, spreadRadius: 1),
          ],
        ),
        child: CircularPercentIndicator(
            radius: radius,
            lineWidth: lineWidth,
            animation: animation,
            percent: percentage,
            animationDuration: 1200,
            center:  Text(
              textPercent ?? "${percentage*100}%",
              style:
               TextStyle(fontSize: centerTextFontSize),
            ),

            footer:  Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: JSizes.sm * 1.2),
                Text(
                  bottomText,
                  style:
                   TextStyle(fontWeight: FontWeight.bold, fontSize: bottomTextFontSize),
                ),
              ],
            ),
            circularStrokeCap: CircularStrokeCap.round,
            progressColor: progressColor,
            backgroundColor: backgroundColor ?? (JHelperFunctions.isDarkMode(context) ? JColors.white : JColors.darkGrey),
          ),
      ),
    );

  }

}
