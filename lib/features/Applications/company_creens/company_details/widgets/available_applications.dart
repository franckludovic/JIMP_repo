import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class AvailableApplications extends StatelessWidget {
  const AvailableApplications({
    super.key,
    required this.appnum
  });

  final int appnum;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(JSizes.md),
        child: ElevatedButton(
          
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(JSizes.md),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
            )
          ),
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$appnum Available Applications', style: TextStyle(fontSize: 18, fontFamily: 'Poppins', ),),
              Icon(Iconsax.arrow_right_3, size: 30, color: JColors.white,),
            ],
          )
        ),
      ),
    );
  }
}
