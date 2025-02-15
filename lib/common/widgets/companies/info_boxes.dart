import 'package:flutter/material.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../custom_shapes/container_shapes/rounded_container.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class StatsBox extends StatelessWidget {
  final double matchPercentage;
  final double rating;
  final int placesLeft;

  const StatsBox({
    super.key,
    required this.matchPercentage,
    required this.rating,
    required this.placesLeft,
  });

  @override
  Widget build(BuildContext context) {

    bool isLargeScreen = JHelperFunctions.screenWidth() >= JSizes.tabletScreenSize;

    return LayoutBuilder(
      builder: (context, constraints) {
        return isLargeScreen
            ? _buildHorizontalLayout(context)
            : _buildVerticalLayout(context);
      },
    );
  }

  /// Horizontal Layout (For screens >= 768px)
  Widget _buildHorizontalLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: StatsInfo(context, "$matchPercentage%", "Match")),
        const SizedBox(width: 10),
        Expanded(child: StatsInfo(context, "$rating", "Rating")),
        const SizedBox(width: 10),
        Expanded(child: StatsInfo(context, "$placesLeft", "Place Left")),
      ],
    );
  }

  /// Vertical Layout (For screens < 768px)
  Widget _buildVerticalLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// First Row - Match & Rating
        Row(
          children: [
            Expanded(child: StatsInfo(context, "$matchPercentage%", "Match")),
            const SizedBox(width: 10),
            Expanded(child: StatsInfo(context, "$rating", "Rating")),
          ],
        ),

        const SizedBox(height: 10),


        StatsInfo(context, "$placesLeft", "Place Left", fullWidthOnSmall: true),
      ],
    );
  }


  Widget StatsInfo(BuildContext context, String value, String label, {bool fullWidthOnSmall = false}) {
    final dark = JHelperFunctions.isDarkMode(context);
    return JRoundedContainer(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      backgroundColor: dark ? JColors.darkGrey : JColors.grey,
      width: fullWidthOnSmall ? double.infinity : null,
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: dark ? JColors.secondary
                : JColors.black),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: dark ? JColors.white : JColors.black),
          ),
        ],
      ),
    );
  }
}
