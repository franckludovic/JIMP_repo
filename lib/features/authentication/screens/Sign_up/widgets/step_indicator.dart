import 'package:flutter/material.dart';

class StepIndicator extends StatelessWidget {
  final int currentIndex;
  final int totalSteps;

  const StepIndicator({
    super.key,
    required this.currentIndex,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: index == currentIndex ? 70 : 30,
          height: 8,
          decoration: BoxDecoration(
            color: index == currentIndex ? Colors.purple : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
