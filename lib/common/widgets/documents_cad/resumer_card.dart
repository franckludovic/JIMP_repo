import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class JResumeCard extends StatelessWidget {
  const JResumeCard({
    super.key,
    required this.title,
    required this.fileName,
    this.backgroundColor = JColors.primary,
  });

  final String title;
  final String fileName;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(JSizes.md),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: JSizes.xs),
              Text(
                fileName,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          IconButton(onPressed: () {}, icon: Icon(Iconsax.more, size: 35,)),
        ],
      ),
    );
  }
}

