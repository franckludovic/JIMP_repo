import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/appbar/appbar.dart';
import 'package:project_bc_tuto/common/widgets/documents_cad/file_picker_card.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';

import '../../../../common/widgets/texts/textArea.dart';

class AddRecruiterForm extends StatelessWidget {
  const AddRecruiterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: JAppbar(
        title: Text("Recruiter Info"),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(JSizes.defaultSpace),
        child: Column(
          children: [
            JTextArea(
                label: Text("Recruiter's Full name"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Iconsax.user,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            JTextArea(
                label: Text("ID"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Iconsax.personalcard,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            JTextArea(
                label: Text("Recruiter's Position"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Iconsax.tag_user,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            JTextArea(
                label: Text("Email"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Icons.mail,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            JTextArea(
                label: Text("Recruiter's Address line 1"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Iconsax.call,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            JTextArea(
                label: Text("Recruiter's Address line 2"),
                maxAreaHeight: 1,
                minAreaHeight: 1,
                prefixIcon: Icon(
                  Iconsax.call,
                )),

            SizedBox(
              height: JSizes.spaceBtwSections * 0.8,
            ),

            DocumentUploadWidget(title: "Profile Picture", documentType: "Document Type : PNG",),

            SizedBox(
              height: JSizes.spaceBtwSections,
            ),
            ///save button
            SizedBox(
              child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: JSizes.md, vertical: JSizes.md * 0.8)
                  ),
                  child: Text("Save", style: Theme.of(context).textTheme.headlineMedium,)
              ),
            )
          ],
        ),
      )),
    );
  }
}
