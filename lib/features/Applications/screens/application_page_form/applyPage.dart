import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import 'package:project_bc_tuto/common/widgets/texts/text_fields.dart';
import 'package:project_bc_tuto/features/Applications/screens/application_page_form/widgets/apply_buttons.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/companies/desciption_info_tile.dart';
import '../../../../common/widgets/documents_cad/additonal_file_checkbox_picker.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../Applicaton_details/myWidgets/application_header.dart';
import '../company_details/company_details.dart';

class ApplyPage extends StatefulWidget {
  const ApplyPage({super.key, required this.requiresVerification});

  final bool requiresVerification;

  @override
  State<ApplyPage> createState() => ApplyFormState();
}

class ApplyFormState extends State<ApplyPage> {
  bool isSkillsVerified = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text(
          'Apply Form',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(JSizes.defaultSpace / 2),
          child: Column(
            children: [
              JApplicationHeader(
                onTapLogo: () => Get.to(() => CompanyDetails()),
                companyLogo: JImages.google,
                companyName: "Google",
                internshipName: "Software Engineer",
              ),
              JDivider(),
              SizedBox(height: JSizes.spaceBtwItems / 2),

              InfoTile(
                title: 'Your Role :',
                textBody:"You will be working on the Infrastructure  team and contributing to the development of our systems",
              ),

              SizedBox(height: JSizes.spaceBtwSections),

              DocumentUploadWidget(),

              AdditionalFilesWidget(),

              SizedBox(height: JSizes.spaceBtwItems * 2),

              JTestField(labelText: 'Cover letter'),

              SizedBox(height: JSizes.spaceBtwSections),


              SizedBox(height: JSizes.spaceBtwSections),

              JApplyButtons()
            ],
          ),
        ),
      ),
    );
  }
}
