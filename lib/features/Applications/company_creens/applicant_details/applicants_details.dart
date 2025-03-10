import 'package:flutter/material.dart';
import 'package:project_bc_tuto/common/widgets/Images/rounded_image.dart';
import 'package:project_bc_tuto/common/widgets/Percentage%20indicator/line_percentage_indicator.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/companies/desciption_info_tile.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/image_strings.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/device/device_utility.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class ApplicantsDetails extends StatelessWidget {
  const ApplicantsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: JAppbar(
          showBackArrow: true,
          title: Text(
            "Applicant Details",
            style: Theme.of(context).textTheme.headlineMedium,
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace * 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("SoftWare Engineer",
                  style: TextStyle(
                      color: dark ? JColors.white : JColors.black,
                      fontSize: 30,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: JSizes.spaceBtwSections * 0.6,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: JDeviceUtils.getScreenWidth(context) - 170,
                          child: Text("Elsa Ravenswoth",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                  color: dark ? JColors.white : JColors.black,
                                  fontSize: 25,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold))),
                      Text("Applied 5 days ago",
                          style: TextStyle(
                              color: JColors.darkGrey,
                              fontSize: 15,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: JSizes.md * 1.5,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  vertical: JSizes.md * 0.7,
                                  horizontal: JSizes.md)),
                          onPressed: () {},
                          child: Text(
                            "View Resume",
                            style: TextStyle(
                                color: JColors.grey, fontFamily: 'Poppins'),
                          ))
                    ],
                  ),
                  JRoundedImage(
                    imageUrl: JImages.user2,
                    height: 125,
                    width: 125,
                  )
                ],
              ),
              SizedBox(
                height: JSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Matched",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text("75%", style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              SizedBox(
                  child: LinePercentageIndidctor(
                percent: 0.75,
                width: JDeviceUtils.getScreenWidth(context) - 40,
              )),
              SizedBox(
                height: JSizes.spaceBtwSections,
              ),
              JRoundedContainer(
                padding: EdgeInsets.all(JSizes.md),
                child: SizedBox(
                    child: InfoTile(
                        numberLines: 18,
                        title: "Cover Letter :",
                        TextColor: JColors.black,
                        titleColor: JColors.black,
                        textBody:
                            "      Metatron is the unseen force behind creation, the silent executor of God’s plan. He is not bound by the facets of God nature for he embodies God’s pure will, unshaped and infinite. He alone wields the Akashic Records, accessing its infinite knowledge to guide creation and ensure the divine plan unfolds as God intended. To the Seven Primordial Angels, Metatron is a mystery. They feel his presence, a shadow of authority that surpasses their own divinity, but they do not know his name or his purpose. He is the voice that whispers in moments of doubt, the hand that intervenes when the balance is threatened, and the protector of secrets too great for even the angels to bear. Metatron’s power is limitless, for he acts as the direct extension of God’s will. Yet, even he does not fully know the mind of God. The Akashic Records, though vast, do not reveal the infinite Creator’s ultimate purpose. This mystery humbles Metatron, reminding him that he,too, is but a servant of a greater design.")),
              ),
              SizedBox(
                height: JSizes.spaceBtwSections,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.md * 0.9, vertical: JSizes.md * 0.8),
                      backgroundColor: Colors.green,
                      side: BorderSide(color: Colors.green),
                    ),
                    onPressed: () {},
                    child: Text("Message", style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),)
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.md * 0.9, vertical: JSizes.md * 0.8),
                      backgroundColor: JColors.grey,
                      side: BorderSide(color: JColors.grey),
                    ),
                    onPressed: () {},
                    child: Text("Schedule Interview", style: TextStyle(fontSize: 20, color: JColors.black, fontFamily: 'Poppins'),)
                  ),
                ],
              ),

              SizedBox(
                height: JSizes.spaceBtwItems,
              ),

              Center(
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: JSizes.xxl * 1.5 , vertical: JSizes.md * 0.8),
                      backgroundColor: JColors.primary,
                      side: BorderSide(color: JColors.primary),
                    ),
                    onPressed: () {},
                    child: Text("ACCEPT", style: TextStyle(fontSize: 20, color: JColors.black, fontFamily: 'Poppins'),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
