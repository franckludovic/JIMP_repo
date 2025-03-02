import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import 'home_stats_container.dart';

class CompanyHomeStats extends StatelessWidget {
  const CompanyHomeStats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              JRoundedContainer(
                width: 162,
                height: 150,
                backgroundColor: Colors.blueAccent,
                child: Stack(
                  children: [
                    // Background Question Mark
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Iconsax.briefcase,
                          size: 80,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Texts
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '56',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            'Postings',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

              ),
              JRoundedContainer(
                width: 162,
                height: 150,
                backgroundColor: Colors.green,
                child: Stack(
                  children: [
                    // Background Question Mark
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(
                          Iconsax.brifecase_tick,
                          size: 70,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Texts
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '36',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            'Active',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),


              ),
            ],
          ),
          SizedBox(
            height: JSizes.md,
          ),

          JRoundedContainer(
            width: double.infinity,
            height: 150,
            backgroundColor: Colors.yellow,
            child: Stack(
              children: [

                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Opacity(
                    opacity: 0.2,
                    child: Icon(
                      Iconsax.brifecase_cross,
                      size: 100,
                      color: JColors.black,
                    ),
                  ),
                ),


                // Texts
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '20',
                        style: TextStyle(
                          color: JColors.darkerGrey,
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(width: JSizes.md,),

                      Container(
                        margin: EdgeInsets.only(top: JSizes.spaceBtwItems * 1.25),
                        child: Text(
                          'Expired',
                          style: TextStyle(
                            color: JColors.darkerGrey,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          JRoundedContainer(
              margin: EdgeInsets.symmetric(vertical: JSizes.md),
              width: double.infinity,
              height: 350,
              backgroundColor: JColors.grey,
              child: CompanyStatsBox())
        ],
      ),
    );
  }
}
