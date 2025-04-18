import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../features/Applications/models/user_model.dart';
import '../../../features/personilization/screens/settings/resume_page.dart';
import '../../../features/personilization/screens/settings/resume_page2.dart';

class JResumeCard2 extends StatelessWidget {
  const JResumeCard2({
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
      padding: EdgeInsets.all(JSizes.md * 0.9),
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
          IconButton(onPressed: () => Get.to(() => ResumePage2()), icon: Icon(Icons.more_vert, size: 35,)),
        ],
      ),
    );
  }
}

