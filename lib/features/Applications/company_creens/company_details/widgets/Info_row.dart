import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/utils/constants/colors.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key,
    required this.title,
    required this.subTitle,
    required this.logo});

  final String title;
  final String subTitle;
  final IconData logo;


  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: JSizes.sm),
      padding: EdgeInsets.symmetric(horizontal: JSizes.md),
      child: Row(
        children: [
         Container(
           width: 55,
           height: 55,
           decoration: BoxDecoration(
             color: JColors.grey,
             borderRadius: BorderRadius.circular(70)
           ),
           child: Icon(logo, size: 35, color: JColors.black,),
          ),

          SizedBox(width: JSizes.spaceBtwItems,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 15, color: dark ? JColors.grey : JColors.darkerGrey)),
              Text(subTitle, style: Theme.of(context).textTheme.headlineMedium),
            ],
          ),

        ],
      ),
    );
  }
}

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        InfoRow(title: "Telephone", subTitle: "+237 654 78 96 56", logo: Iconsax.call),
        SizedBox(height: JSizes.lg,),
        InfoRow(title: "E-mail", subTitle: "SkyCorp@gmail.com", logo: Iconsax.sms),
        SizedBox(height: JSizes.lg,),
        InfoRow(title: "WebSite", subTitle: "SkyCorp.com", logo: Iconsax.global_search),

      ],
    );
  }
}



