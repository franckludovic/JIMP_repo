
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';


class Testimonies extends StatelessWidget {
  const Testimonies({
    super.key,
    required this.message,
    required this.author,
  });

  final String message;
  final String author;

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark? JColors.grey : JColors.primary.withAlpha((0.1 * 255).toInt()),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.start,
            style: const TextStyle(
              color: Colors.black,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              '- $author',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black,),
            ),
          ),
        ],
      ),
    );
  }
}
