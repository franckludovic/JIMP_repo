import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class SelectionCard extends StatefulWidget {
  const SelectionCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final String image;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  SelectionCardState createState() => SelectionCardState();
}

class SelectionCardState extends State<SelectionCard> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 1.1;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 1.0;
        });

        Future.delayed(const Duration(milliseconds: 150), () {
          if (widget.onTap != null) {
            widget.onTap!();
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
          duration: const Duration(milliseconds: 200),
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

              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  widget.image,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: JColors.secondary),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.subtitle,
                      style:
                      const TextStyle(fontSize: 14, color: JColors.darkerGrey),
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
