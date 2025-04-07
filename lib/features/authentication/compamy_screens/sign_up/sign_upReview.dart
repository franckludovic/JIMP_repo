import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:project_bc_tuto/common/widgets/custom_shapes/container_shapes/rounded_container.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up1.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/sign_up2.dart';
import 'package:project_bc_tuto/features/authentication/compamy_screens/sign_up/widget/description_page.dart';
import 'package:project_bc_tuto/utils/constants/sizes.dart';
import 'package:project_bc_tuto/utils/helpers/helper_functions.dart';
import '../../../../common/image_picker/imagepickerDialog.dart';
import '../../../../common/widgets/Images/rounded_image.dart';
import '../../../../common/widgets/custom_wigets/jcustom_dropdown.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../Applications/company_creens/company_details/widgets/company_details_appbar.dart';
import '../../../Applications/models/company_model.dart';
import '../../controllers.onboarding/company_signup_controller/company_sign_up_controller.dart';
import '../../../Applications/company_creens/company_details/widgets/company_detail_header.dart';
import '../../screens/Sign_up/widgets/term_and_conditions.dart';

class CompanySignUpReview extends StatelessWidget {
  CompanySignUpReview({super.key});

  final CompanySignupController controller = Get.put(CompanySignupController());

  /// Opens a dialog to edit an RxString field.
  void _showEditDialog(
      BuildContext context, String fieldLabel, RxString rxValue) {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: JSizes.md, horizontal: JSizes.md)),
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

  Widget _buildProfilePlaceholder() {
    return Container(
      width: double.infinity,
      height: 300,
      color: JColors.grey,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('No Profile Image', style: TextStyle(color: Colors.black)),
          Icon(Icons.image_not_supported_rounded, color: Colors.black),
        ],
      ),
    );
  }

  Widget _buildLogoPlaceholder() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Logo', style: TextStyle(color: Colors.black)),
        Icon(Icons.image_not_supported_rounded, color: Colors.black),
      ],
    );
  }

  /// Opens a dialog to edit a plain string field using its TextEditingController.
  void _showEditDialogString(BuildContext context, String fieldLabel,
      TextEditingController textController) {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: JSizes.md, horizontal: JSizes.md)),
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
  void _showDropDownDialogOT(
      BuildContext context, String fieldLabel, RxString rxValue) {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: JSizes.md, horizontal: JSizes.md)),
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

  void _showDropDownDialogCS(
      BuildContext context, String fieldLabel, RxString rxValue) {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: JSizes.md, horizontal: JSizes.md)),
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
  void _showDropDownDialogOC(
      BuildContext context, String fieldLabel, RxString rxValue) {
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      vertical: JSizes.md, horizontal: JSizes.md)),
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
  Widget _buildReviewRow(String fieldLabel, dynamic value,
      {TextEditingController? controllerForString}) {
    final String displayValue;
    final VoidCallback editCallback;

    if (value is RxString && fieldLabel == "Opportunity Type") {
      displayValue = value.value;
      editCallback =
          () => _showDropDownDialogOT(Get.context!, fieldLabel, value);
    } else if (value is RxString && fieldLabel == "Opportunity Category") {
      displayValue = value.value;
      editCallback =
          () => _showDropDownDialogOC(Get.context!, fieldLabel, value);
    } else if (value is RxString && fieldLabel == "Company Size") {
      displayValue = value.value;
      editCallback =
          () => _showDropDownDialogCS(Get.context!, fieldLabel, value);
    } else if (value is RxString) {
      displayValue = value.value;
      editCallback = () => _showEditDialog(Get.context!, fieldLabel, value);
    } else if (value is String && controllerForString != null) {
      displayValue = value;
      editCallback = () =>
          _showEditDialogString(Get.context!, fieldLabel, controllerForString);
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
            const Text("Company Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("Company Name", controller.companyName.text,
                controllerForString: controller.companyName),
            // Assuming DescriptionEditor is a widget that edits description and updates controller.description.
            DescriptionEditor(descriptionController: controller.description),
            _buildReviewRow("Official Email", controller.officialEmail.text,
                controllerForString: controller.officialEmail),
            _buildReviewRow("Phone Number1", controller.phoneNumber1.text,
                controllerForString: controller.phoneNumber1),
            _buildReviewRow("Phone Number2", controller.phoneNumber2.text,
                controllerForString: controller.phoneNumber2),
            _buildReviewRow("Country", controller.country.text,
                controllerForString: controller.country),
            _buildReviewRow("Region", controller.region.text,
                controllerForString: controller.region),
            _buildReviewRow("City", controller.city.text,
                controllerForString: controller.city),
            _buildReviewRow("Postal Code", controller.postalCode.text,
                controllerForString: controller.postalCode),
            _buildReviewRow("Local Address", controller.localAddress.text,
                controllerForString: controller.localAddress),
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
            const Text("Additional Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("Company Size", controller.companySize),
            _buildReviewRow("Opportunity Type", controller.opportunityType),
            _buildReviewRow(
                "Opportunity Category", controller.opportunityCategory),
            _buildReviewRow("Industry", controller.industry),
            _buildReviewRow(
                "Registration Number", controller.registrationNumber.text,
                controllerForString: controller.registrationNumber),
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
            const Text("HR Contact Information",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: JSizes.sm),
            _buildReviewRow("HR Name", controller.hrName.text,
                controllerForString: controller.hrName),
            _buildReviewRow("HR Title", controller.hrTitle.text,
                controllerForString: controller.hrTitle),
            _buildReviewRow("HR Email", controller.hrEmail.text,
                controllerForString: controller.hrEmail),
            _buildReviewRow("HR Phone", controller.hrPhone.text,
                controllerForString: controller.hrPhone),
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
            const Text("Branches",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: JSizes.sm),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      title: Text("Branch ${index + 1}",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          "${branch.address.city}, ${branch.address.street}\n"
                          "${branch.contactEmail}\n"
                          "Phone: ${branch.phoneNumber}"),
                      trailing: IconButton(
                        icon: const Icon(Iconsax.edit, color: Colors.blue),
                        onPressed: () =>
                            _showEditDialogBox(context, index, branch),
                      ),
                    ),
                  );
                },
              );
            }),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: JSizes.md, vertical: JSizes.md * 0.6),
                ),
                onPressed: () => controller.addNewBranch(),
                icon: const Icon(Icons.add),
                label: const Text("Add Branch"),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showEditDialogBox(
      BuildContext context, int index, CompanyBranch branch) {
    final controller = Get.find<CompanySignupController>();

    // Create controllers with current values
    final countryController =
        TextEditingController(text: branch.address.country);
    final regionController = TextEditingController(text: branch.address.region);
    final cityController = TextEditingController(text: branch.address.city);
    final streetController = TextEditingController(text: branch.address.street);
    final postalController =
        TextEditingController(text: branch.address.postalCode);
    final emailController = TextEditingController(text: branch.contactEmail);
    final phoneController = TextEditingController(text: branch.phoneNumber);
    final nameController = TextEditingController(text: branch.contactName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Edit Branch"),
            JRoundedContainer(
              backgroundColor: Colors.red.withAlpha((0.2 * 255).toInt()),
              child: IconButton(
                onPressed: () {
                  controller.removeBranch(index);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            )
          ],
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Contact Name"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: countryController,
                      decoration: const InputDecoration(labelText: "Country"),
                    ),
                  ),
                  const SizedBox(width: JSizes.md),
                  Expanded(
                    child: TextFormField(
                      controller: regionController,
                      decoration: const InputDecoration(labelText: "Region"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(labelText: "City"),
                    ),
                  ),
                  const SizedBox(width: JSizes.md),
                  Expanded(
                    child: TextFormField(
                      controller: streetController,
                      decoration: const InputDecoration(labelText: "Street"),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: postalController,
                decoration: const InputDecoration(labelText: "Postal Code"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Contact Email"),
              ),
              const SizedBox(height: JSizes.spaceBtwInputFields),
              TextFormField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(
                      horizontal: JSizes.md, vertical: JSizes.md * 0.6),
                ),
                onPressed: () {
                  final updatedBranch = CompanyBranch(
                    address: CompanyAddress(
                      country: countryController.text,
                      region: regionController.text,
                      city: cityController.text,
                      street: streetController.text,
                      postalCode: postalController.text,
                    ),
                    contactEmail: emailController.text,
                    phoneNumber: phoneController.text,
                    contactName: nameController.text,
                  );
                  controller.updateBranch(index, updatedBranch);
                  Navigator.pop(context);
                },
                child: const Text("Save Changes"),
              ),
            ],
          ),
          // TextButton(
          //   onPressed: () {
          //     controller.removeBranch(index);
          //     Navigator.pop(context);
          //   },
          //   child: const Text("Delete", style: TextStyle(color: Colors.red)),
          // ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = JHelperFunctions.isDarkMode(context);
    return Scaffold(
      body: GetBuilder<CompanySignupController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    // Background Profile Image or Placeholder
                    controller.profileUrl.text.isNotEmpty
                        ? SizedBox(
                            width: double.infinity,
                            height: 300,
                            child: Image.network(
                              controller.profileUrl.text,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  _buildProfilePlaceholder(),
                            ),
                          )
                        : _buildProfilePlaceholder(),

                    // Foreground Elements
                    Column(
                      children: [
                        CompanyDetailsAppBar(
                            title: controller.companyName.text),

                        // Positioned Logo & Edit Icon
                        Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 140, left: 16),
                              width: 113,
                              height: 113,
                              decoration: BoxDecoration(
                                color: dark ? JColors.darkGrey : JColors.grey,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                child: controller.logoUrl.text.isNotEmpty
                                    ? JRoundedImage(
                                        isNetworkImage: true,
                                        imageUrl: controller.logoUrl.text,
                                        applyImageRadius: true,
                                        fit: BoxFit.contain,
                                      )
                                    : _buildLogoPlaceholder(),
                              ),
                            ),

                            // Edit Icon for Logo
                            Positioned(
                              bottom: -10,
                              left: 85,
                              child: IconButton(
                                icon: const Icon(Iconsax.edit,
                                    color: JColors.primary, size: 30),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (_) => ImageUploadDialog(
                                    title: "Upload Logo",
                                    onUploadConfirmed: (url) {
                                      controller.logoUrl.text = url;
                                      controller.update();
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Edit Icon for Profile Banner
                    Positioned(
                      bottom: 60,
                      right: 10,
                      child: IconButton(
                        icon: const Icon(Iconsax.edit,
                            color: JColors.primary, size: 30),
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => ImageUploadDialog(
                            title: "Upload Profile Image",
                            onUploadConfirmed: (url) {
                              controller.profileUrl.text = url;
                              controller.update();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                        margin:
                            const EdgeInsets.symmetric(horizontal: JSizes.sm),
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
