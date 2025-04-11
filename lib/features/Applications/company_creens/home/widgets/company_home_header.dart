import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project_bc_tuto/features/personilization/controllers/company_controller.dart';
import '../../../../../common/widgets/Images/rounded_image.dart';
import '../../../../../common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import '../../../../../common/widgets/notifications/notifications_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personilization/controllers/user_controller.dart';


class CompanyHomeHeader extends StatelessWidget {
  const CompanyHomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompanyController());
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          ClipPath(
            clipper: OvalBottomBorderClipper(),
            child: Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.yellow,
                image: DecorationImage(
                  image: NetworkImage(controller.user?.profileUrl.toString() ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: JRoundedContainer(
                padding: EdgeInsets.symmetric(horizontal: JSizes.md),
                backgroundColor:
                JColors.primary.withAlpha((0.6 * 255).toInt()),
                margin: EdgeInsets.only(
                    top: JSizes.defaultSpace * 1.8,
                    left: JSizes.defaultSpace,
                    right: JSizes.defaultSpace),
                height: 60,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.user?.companyName ?? '', style: Theme.of(context).textTheme.headlineLarge,),
                        NotificationCounterIcon(onPressed: () {})

                      ],
                    )
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: JRoundedImage(applyImageRadius: true, width: 100, height: 100, borderRadius: 100 ,isNetworkImage: true, imageUrl: controller.user?.logoUrl ?? ''),
            ),
          ),
        ],
      ),
    );
  }
}
