import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/texts/section_heading.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/widgets/application_data.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/widgets/application_image_slider.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/widgets/button_add_to_cart.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/widgets/product_attributes.dart';
import 'package:project_bc_tuto/features/Applications/screens/Applicaton_details/widgets/rating_and_share.dart';
import 'package:project_bc_tuto/features/Applications/screens/application_reviews/product_reviews.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import 'package:readmore/readmore.dart';

class ApplicationDetails extends StatelessWidget {
  const ApplicationDetails({super.key});

  @override
  Widget build(BuildContext context) {
    //final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: JBottonAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Product image slider
            JApplicationImage(),

            ///Product image
            Padding(
              padding: EdgeInsets.only(right: JSizes.defaultSpace, left: JSizes.defaultSpace, bottom: JSizes.defaultSpace),
              child: Column(
                children: [
                  ///rating and share
                  JRatingAndShare(),

                  ///--price, title, stock, brand
                  JApplicationData(),


                  ///attributes,
                  ProductAttributes(),
                  SizedBox(height: JSizes.spaceBtwSections),


                  ///check out buttons,
                  SizedBox (width: double.infinity, child :ElevatedButton(onPressed: () {}, child: Text("Checkout"))),
                  const SizedBox(height: JSizes.spaceBtwSections),

                  ///description,
                  JSectionHeading(title: "Description", showActonButton: false),
                  SizedBox(height: JSizes.spaceBtwItems),
                  ReadMoreText(
                    "Currently enrolled in a Bachelor's or Master's degree program. Experience with data analysis and visualization tools.",
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),


                  ///reviews,
                  const Divider(),
                  const SizedBox(height: JSizes.spaceBtwItems,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      JSectionHeading(title: "Review (199)",showActonButton: false,),
                      IconButton(icon: const  Icon(Iconsax.arrow_right_3), onPressed: () => Get.to(() => ApplicationReviewScreen()) )
                    ],
                  ),
                  const SizedBox(height: JSizes.spaceBtwSections,),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


