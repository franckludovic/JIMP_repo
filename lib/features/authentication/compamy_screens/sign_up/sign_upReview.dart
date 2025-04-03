
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up1.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up2.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/description_page.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import '../../../../common/widgets/custom_wigets/jcustom_dropdown.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';
import '../../../Applications/company_creens/company_details/widgets/company_detail_header.dart';
import '../../screens/Sign_up/widgets/term_and_conditions.dart';

class CompanySignUpReview extends StatelessWidget {
  CompanySignUpReview({super.key});

  final CompanySignupController controller = Get.put(CompanySignupController());

  /// Opens a dialog to edit an RxString field.
  void _showEditDialog(BuildContext context, String fieldLabel, RxString rxValue) {
    final TextEditingController dialogController = TextEditingController(text: rxValue.value);
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
                controller.update();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Opens a dialog to edit a plain string field using its TextEditingController.
  void _showEditDialogString(BuildContext context, String fieldLabel, TextEditingController textController) {
    final TextEditingController dialogController = TextEditingController(text: textController.text);
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
                controller.update();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Dropdown dialog for Opportunity Type.
  void _showDropDownDialogOT(BuildContext context, String fieldLabel, RxString rxValue) {
    controller.opportunityType.value = rxValue.value;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldLabel"),
          content: Obx(() => JCustomDropDown(
            title: 'Opportunity Type:',
            items: CompanySignupScreen2.opportunityType.isEmpty
                ? ['Select an option']
                : CompanySignupScreen2.opportunityType,
            value: controller.opportunityType.value.isEmpty
                ? null
                : controller.opportunityType.value,
            hint: "Select Category",
            onChanged: (val) {
              if (val != null) controller.opportunityType.value = val;
            },
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                rxValue.value = controller.opportunityType.value;
                controller.update();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }


  void _showDropDownDialogCS(BuildContext context, String fieldLabel, RxString rxValue) {
    controller.companySize.value = rxValue.value;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldLabel"),
          content: Obx(() => JCustomDropDown(
            title: 'Company Size:',
            items: CompanySignUpScreen1.companySize.isEmpty
                ? ['Select an option']
                : CompanySignUpScreen1.companySize,
            value: controller.companySize.value.isEmpty
                ? null
                : controller.companySize.value,
            hint: "Select Company Size",
            onChanged: (val) {
              if (val != null) controller.companySize.value = val;
            },
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                rxValue.value = controller.companySize.value;
                controller.update();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Dropdown dialog for Opportunity Category.
  void _showDropDownDialogOC(BuildContext context, String fieldLabel, RxString rxValue) {
    controller.opportunityCategory.value = rxValue.value;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit $fieldLabel"),
          content: Obx(() => JCustomDropDown(
            title: 'Category offered:',
            items: CompanySignupScreen2.opportunityCategory.isEmpty
                ? ['Select an option']
                : CompanySignupScreen2.opportunityCategory,
            value: controller.opportunityCategory.value.isEmpty
                ? null
                : controller.opportunityCategory.value,
            hint: "Select Category",
            onChanged: (val) {
              if (val != null) controller.opportunityCategory.value = val;
            },
          )),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                rxValue.value = controller.opportunityCategory.value;
                controller.update();
                Navigator.of(context).pop();
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  /// Builds a review row that displays "Field Label: Value" with an edit icon.
  /// For RxString fields, pass the RxString; for plain string fields, pass the string value and the controller.
  Widget _buildReviewRow(String fieldLabel, dynamic value, {TextEditingController? controllerForString}) {
    final String displayValue;
    final VoidCallback editCallback;

    if (value is RxString && fieldLabel == "Opportunity Type") {
      displayValue = value.value;
      editCallback = () => _showDropDownDialogOT(Get.context!, fieldLabel, value);

    } else if (value is RxString && fieldLabel == "Opportunity Category") {
    displayValue = value.value;
    editCallback = () => _showDropDownDialogOC(Get.context!, fieldLabel, value);
    } else if (value is RxString && fieldLabel == "Company Size") {
    displayValue = value.value;
    editCallback = () => _showDropDownDialogCS(Get.context!, fieldLabel, value);
    } else if (value is RxString) {
    displayValue = value.value;
    editCallback = () => _showEditDialog(Get.context!, fieldLabel, value);
    } else if (value is String && controllerForString != null) {
    displayValue = value;
    editCallback = () => _showEditDialogString(Get.context!, fieldLabel, controllerForString);
    } else {
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

  /// Card for main company info.
  Widget _buildMainInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Company Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("Company Name", controller.companyName.text, controllerForString: controller.companyName),
            // Assuming DescriptionEditor is a widget that edits description and updates controller.description.
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

  /// Card for additional info.
  Widget _buildSecondInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Additional Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  /// Card for HR information.
  Widget _buildHRInfoCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("HR Contact Information", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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

  /// Card for branches.
  Widget _buildBranchesCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(JSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Branches", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                      "${branch.address.city}, ${branch.address.street}\nEmail: ${branch.contactEmail}\nPhone: ${branch.phoneNumber}";
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text("Branch ${index + 1}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(branchInfo),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.edit, color: Colors.blue),
                        onPressed: () {
                          // Navigate to branch detail page for editing
                          // Example: Get.to(() => BranchDetailPage(branchIndex: index));
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
      body: GetBuilder<CompanySignupController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CompagnyDetailsHeader(
                  title: "Review Your Information",

                  companyName: controller.logoUrl.text,
                  companyLogo: JImages.google,
                  companyProfileImage: "",
                ),
                SizedBox(height: JSizes.spaceBtwSections * 0.6),
                Padding(
                  padding: const EdgeInsets.all(JSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMainInfoCard(),
                      _buildSecondInfoCard(),
                      _buildHRInfoCard(),
                      _buildBranchesCard(),
                      TermandConditions(),
                      const SizedBox(height: JSizes.spaceBtwSections),
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
          );
        },
      ),
    );
  }
}