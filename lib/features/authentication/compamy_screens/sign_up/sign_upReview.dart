import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/description_page.dart';
import 'package:project_bc_tuto/features/authentication/screens/Sign_up/widgets/term_and_conditions.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../Applications/company_creens/company_details/widgets/company_detail_header.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';


class CompanySignUpReview extends StatelessWidget {
  CompanySignUpReview({super.key});

  final controller = Get.put(CompanySignupController());


  void _showEditDialog(BuildContext context, String fieldLabel, RxString rxValue) {
    final TextEditingController dialogController =
    TextEditingController(text: rxValue.value);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldLabel"),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(hintText: "Enter new $fieldLabel"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                rxValue.value = dialogController.text;
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }


  void _showEditDialogString(BuildContext context, String fieldLabel, TextEditingController textController) {
    final TextEditingController dialogController =
    TextEditingController(text: textController.text);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldLabel"),
          content: TextField(
            controller: dialogController,
            decoration: InputDecoration(hintText: "Enter new $fieldLabel"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                textController.text = dialogController.text;
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }


  Widget _buildReviewRow(String fieldLabel, dynamic value, {TextEditingController? controllerForString}) {
    final String displayValue;
    final VoidCallback editCallback;


    if (value is RxString) {
      displayValue = value.value;
      editCallback = () => _showEditDialog(Get.context!, fieldLabel, value);
    }
    // If it's a string from a TextEditingController:
    else if (value is String && controllerForString != null) {
      displayValue = value;
      editCallback = () => _showEditDialogString(Get.context!, fieldLabel, controllerForString);
    }
    // If something else (fallback)
    else {
      displayValue = value?.toString() ?? '';
      editCallback = () {};
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              "$fieldLabel: $displayValue",
              style: const TextStyle(fontSize: 15),
            ),
          ),
          IconButton(
            icon: const Icon(Iconsax.edit, color: Colors.blue),
            onPressed: editCallback,
          ),
        ],
      ),
    );
  }


  Widget _buildMainInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Company Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: JSizes.sm),
            // Company Info
            _buildReviewRow("Company Name", controller.companyName.text, controllerForString: controller.companyName),
            DescriptionEditor(descriptionController: controller.description),
            _buildReviewRow("Official Email", controller.officialEmail.text, controllerForString: controller.officialEmail),
            _buildReviewRow("Phone Number1", controller.phoneNumber1.text, controllerForString: controller.phoneNumber1),
            _buildReviewRow("Phone Number2", controller.phoneNumber2.text, controllerForString: controller.phoneNumber2),
            _buildReviewRow("Country", controller.country.text, controllerForString: controller.country),
            _buildReviewRow("Region", controller.region.text, controllerForString: controller.region),
            _buildReviewRow("City", controller.city.text, controllerForString: controller.city),
            _buildReviewRow("Postal Code", controller.postalCode.text, controllerForString: controller.postalCode),
            _buildReviewRow("Local Address", controller.localAddress.text, controllerForString: controller.localAddress),

          ],
        ),
      ),
    );
  }

  Widget _buildSecondInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Additional Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("Company Size", controller.companySize),
            _buildReviewRow("Opportunity Type", controller.opportunityType),
            _buildReviewRow("Opportunity Category", controller.opportunityCategory),
            _buildReviewRow("Industry", controller.industry),
            _buildReviewRow("Registration Number", controller.registrationNumber.text, controllerForString: controller.registrationNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildHRInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("HR Contact Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
            ),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("HR Name", controller.hrName.text, controllerForString: controller.hrName),
            _buildReviewRow("HR Title", controller.hrTitle.text, controllerForString: controller.hrTitle),
            _buildReviewRow("HR Email", controller.hrEmail.text, controllerForString: controller.hrEmail),
            _buildReviewRow("HR Phone", controller.hrPhone.text, controllerForString: controller.hrPhone),
          ],
        ),
      ),
    );
  }


  Widget _buildBranchesCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Branches", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: JSizes.sm),
            Obx(() {
              if (controller.branches.isEmpty) {
                return const Text("No branches added yet.");
              }
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.branches.length,
                itemBuilder: (context, index) {
                  final branch = controller.branches[index];
                  final branchInfo =
                      "${branch.address.city}, ${branch.address.street}\n"
                      "${branch.contactEmail}\nPhone: ${branch.phoneNumber}";

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text("Branch ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(branchInfo),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.edit, color: Colors.blue),
                        onPressed: () {

                        },
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: JAppbar(title: const Text()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CompagnyDetailsHeader(
              title:"Review Your Information" ,
                companyName: controller.logoUrl.text,
                companyLogo: JImages.google,
                companyProfileImage: ''),
            SizedBox(
              height: JSizes.spaceBtwSections * 0.6,
            ),
            Padding(
              padding: const EdgeInsets.all(JSizes.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Company Info Card
                  _buildMainInfoCard(),
                  // addiyional info
                  _buildSecondInfoCard(),
                  // HR Info Card
                  _buildHRInfoCard(),
                  // Branches Card
                  _buildBranchesCard(),
                  TermandConditions(),
                  const SizedBox(height: JSizes.spaceBtwSections),
                  // Submit Button
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: JSizes.sm),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      onPressed: () => controller.signupFinal(),
                      child: const Text(
                        "Create Account",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
