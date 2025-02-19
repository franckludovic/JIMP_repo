import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/other_shapes/custom_divider.dart';
import 'package:project_bc_tuto/common/widgets/texts/text_fields.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/documents_cad/additonal_file_checkbox_picker.dart';
import '../../../../common/widgets/documents_cad/file_picker_card.dart';
import '../../../../utils/constants/image_strings.dart';
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

              DocumentUploadWidget(),

              AdditionalFilesWidget(),

              SizedBox(height: JSizes.spaceBtwItems * 2),

              JTestField(labelText: 'Cover letter'),

              SizedBox(height: JSizes.spaceBtwSections),

              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: widget.requiresVerification && !isSkillsVerified
                      ? () {
                          setState(() {
                            isSkillsVerified = true;
                          });
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:  widget.requiresVerification && !isSkillsVerified
                            ? Colors.grey
                            : Colors.blue,
                  ),
                  child: Text(
                    widget.requiresVerification && !isSkillsVerified
                        ? "VERIFY SKILLS (Locked)" : "VERIFY SKILLS",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: JSizes.md)
                  ),
                  onPressed: () {},
                  child: Text(
                    'Review Application',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                  )
                ),
              )

              // APPLY INTERNSHIP Button
              // SizedBox(
              //   width: 300,
              //   child: ElevatedButton(
              //     onPressed: (widget.requiresVerification && !isSkillsVerified)
              //         ? null
              //         : () {},
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: (widget.requiresVerification && !isSkillsVerified)
              //           ? Colors.grey
              //           : Colors.purple,
              //     ),
              //     child: const Text(
              //       "APPLY INTERNSHIP",
              //       style: TextStyle(color: Colors.white),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
