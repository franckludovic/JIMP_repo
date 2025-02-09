import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class SelectionCard extends StatefulWidget {
  const SelectionCard({super.key, 
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTapNavigate, // Callback for navigation
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTapNavigate;

  @override
  _SelectionCardState createState() => _SelectionCardState();
}

class _SelectionCardState extends State<SelectionCard> {
  double scale = 1.0; // Default scale

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        // When the user presses down, smoothly enlarge the card
        setState(() {
          scale = 1.1;
        });
      },
      onTapUp: (_) {
        // When the user releases, smoothly return to normal and navigate
        setState(() {
          scale = 1.0;
        });

        Future.delayed(const Duration(milliseconds: 150), () {
          if (widget.onTapNavigate != null) {
            widget.onTapNavigate!();
          }
        });
      },
      onTapCancel: () {

        setState(() {
          scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200), // Animate shadow as well
          curve: Curves.easeOut,
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: JColors.grey,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: scale > 1.0 ? 15 : 10,
                spreadRadius: scale > 1.0 ? 2 : 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Image.asset(
                      widget.image, width: 90, height: 90
                  )
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: JColors.secondary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(fontSize: 14, color: JColors.darkerGrey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
