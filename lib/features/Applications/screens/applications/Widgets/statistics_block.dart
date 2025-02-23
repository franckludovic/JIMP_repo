import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../home/widgets/pieChardStats.dart';

class StatisticsBlock extends StatelessWidget {
  const StatisticsBlock({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [

            ///-- Applications Applied
            JRoundedContainer(
              width: 164.3,
              height: 200,
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
                        Icons.send,
                        size: 100,
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
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Application deposited',
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

            SizedBox(width: JSizes.md),


            /// -- Interviews
            JRoundedContainer(
              width: 164.3,
              height: 200,
              backgroundColor: Colors.purple,
              child: Stack(
                children: [
                  // Background Question Mark
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Opacity(
                      opacity: 0.2,
                      child: Icon(
                        Icons.question_answer,
                        size: 100,
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
                          '03',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(
                          'Pending Interviews',
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

        SizedBox(height: JSizes.md),

        ///Completed internship
        JRoundedContainer(
          width: double.infinity,
          height: 120,
          backgroundColor: Colors.yellow,
          child: Stack(
            children: [
              // Background Question Mark
              Positioned(
                bottom: 0,
                right: 0,
                child: Opacity(
                  opacity: 0.2,
                  child: Icon(
                    Iconsax.tick_circle,
                    size: 100,
                    color: JColors.black,
                  ),
                ),
              ),

              // Texts
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '15',
                      style: TextStyle(
                        color: JColors.darkerGrey,
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),


                    Container(
                      margin: EdgeInsets.only(top: JSizes.spaceBtwSections),
                      child: Text(
                        'Completed internships',
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

        SizedBox(height: JSizes.md),

        ///Accepted contracts
        // Row(
        //   children: [
        //     JRoundedContainer(
        //       width: 104,
        //       height: 120,
        //       backgroundColor: Colors.greenAccent,
        //       child: Stack(
        //         children: [
        //           // Background Question Mark
        //           Positioned(
        //             bottom: 0,
        //             right: 0,
        //             child: Opacity(
        //               opacity: 0.4,
        //               child: Icon(
        //                 Iconsax.user_tick,
        //                 size: 70,
        //                 color: JColors.black,
        //               ),
        //             ),
        //           ),
        //
        //           // Texts
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   '20',
        //                   style: TextStyle(
        //                     color: JColors.darkerGrey,
        //                     fontSize: 40,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //
        //                 Text(
        //                     'Accepted internships',
        //                     style: TextStyle(
        //                       color: JColors.darkerGrey,
        //                       fontSize: 14,
        //                     ),
        //                   ),
        //
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //
        //     ),
        //
        //     SizedBox(width: JSizes.md),
        //
        //
        //     /// Applications Rejected
        //     JRoundedContainer(
        //       width: 104,
        //       height: 120,
        //       backgroundColor: Colors.redAccent,
        //       child: Stack(
        //         children: [
        //
        //           Positioned(
        //             bottom: 0,
        //             right: 0,
        //             child: Opacity(
        //               opacity: 0.4,
        //               child: Icon(
        //                 Iconsax.user_remove,
        //                 size: 70,
        //                 color: JColors.white,
        //               ),
        //             ),
        //           ),
        //
        //           // Texts
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   '16',
        //                   style: TextStyle(
        //                     color: JColors.darkerGrey,
        //                     fontSize: 40,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //
        //                 Text(
        //                   'Rejected internships',
        //                   style: TextStyle(
        //                     color: JColors.darkerGrey,
        //                     fontSize: 14,
        //                   ),
        //                 ),
        //
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //
        //     ),
        //
        //     SizedBox(width: JSizes.md,),
        //
        //
        //     ///Applications Pending
        //     JRoundedContainer(
        //       width: 104,
        //       height: 120,
        //       backgroundColor: Colors.orangeAccent,
        //       child: Stack(
        //         children: [
        //           // Background Question Mark
        //           Positioned(
        //             bottom: 0,
        //             right: 0,
        //             child: Opacity(
        //               opacity: 0.5,
        //               child: Icon(
        //                 Icons.help_outline_rounded,
        //                 size: 70,
        //                 color: JColors.white,
        //               ),
        //             ),
        //           ),
        //
        //           // Texts
        //           Padding(
        //             padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 const Text(
        //                   '05',
        //                   style: TextStyle(
        //                     color: JColors.darkerGrey,
        //                     fontSize: 40,
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //
        //                 Text(
        //                   'Pending Application',
        //                   style: TextStyle(
        //                     color: JColors.darkerGrey,
        //                     fontSize: 14,
        //                   ),
        //                 ),
        //
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //
        //     ),
        //
        //   ],
        // ),

        JRoundedContainer(
          backgroundColor: JColors.white,
          borderColor: JColors.darkGrey,
          showBorder: true,
          borderWidth: 3,
          padding: EdgeInsets.only(top : JSizes.lg * 1.3, bottom: JSizes.md, right: JSizes.md),
          child: Column(
            children: [
              SizedBox(
                height: 200,
                child: Piechardstats(),
              ),

              SizedBox(height: JSizes.lg),

              Text("APPLICATIONS STATISTICS", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, decoration: TextDecoration.underline ,fontFamily: "Poppins"),)
            ],
          ),
        ),

        
      ],
    );
  }
}