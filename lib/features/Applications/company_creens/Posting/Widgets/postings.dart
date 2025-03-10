import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

class JobPostCard extends StatelessWidget {
  const JobPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return JRoundedContainer(
      height: 250,
      backgroundColor: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                JRoundedContainer(
                  height: 80,
                  width: 80,
                  backgroundColor: JColors.primary,
                  child: Icon(
                    Iconsax.briefcase,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: JSizes.sm,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 225,
                      child: Text(
                        "Software Engineering Intern",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),

                    Text(
                      "Created on 12-05-2022",
                      style: TextStyle(color: JColors.darkGrey),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: JSizes.sm,),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Posting ends in 5 days",
                    style: TextStyle(color: JColors.black, fontSize: 18),
                  ),
                  Text(
                    "10 people have applied to this post",
                    style: TextStyle(color: JColors.black, fontSize: 18),
                  ),
                ],
              ),
            ),

            SizedBox(height: JSizes.spaceBtwSections,),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.sm),
                      backgroundColor: Colors.red,
                      side: BorderSide(color: Colors.red)
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("DROP", style: TextStyle(fontSize:20, fontFamily: 'Poppins', fontWeight: FontWeight.bold,  ),),
                        Icon(Icons.delete_forever,  size: 30, color: Colors.black,)
                      ],
                    ),
                  ),

                  SizedBox(width: JSizes.xl,),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.lg, vertical: JSizes.sm),
                      backgroundColor: JColors.primary,

                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Text("EDIT", style: TextStyle(fontSize:20, fontFamily: 'Poppins', fontWeight: FontWeight.bold,  ),),
                        Icon(Iconsax.edit,  size: 30, color: Colors.black,)
                      ],
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
