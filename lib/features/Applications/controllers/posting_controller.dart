import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../data/repositories/postings/posting_repository.dart';
import '../../Applications/models/posting_model.dart';
import '../models/sub_categorie_model.dart';

class PostingController extends GetxController {
  static PostingController get instance => Get.find();

  // TextEditingControllers for standard fields
  final jobTitle = TextEditingController();
  final jobDescription = TextEditingController();
  final location = TextEditingController();

  // Observable strings for dropdown fields
  final employmentMode = ''.obs; // e.g., "Remote", "Onsite", "Hybrid"
  final experienceLevel = ''.obs; // e.g., "Entry Level", "Mid Level", "High Level"

  final salaryRange = TextEditingController();
  final benefits = TextEditingController();

  // Date fields using TextEditingController so they work with CustomDatePickerField.
  // (You will need to convert these to DateTime when submitting.)
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final deadline = TextEditingController();

  // Application process fields
  final howToApply = ''.obs;
  final requiredDocuments = TextEditingController();
  final applicationQuota = TextEditingController();
  final selectionProcess = TextEditingController();


  // Additional posting fields
  final equalOpportunityStatement = TextEditingController();
  final workAuthorizationRequirements = TextEditingController();
  final expectedStartDate = TextEditingController();
  final postingExpirationDate = TextEditingController();
  final internalReferenceCode = TextEditingController();
  final contactEmail = TextEditingController();

  // Internship-specific fields
  final duration = TextEditingController();
  final academicCredit = false.obs;
  final returnOfferPotential = false.obs;
  final trainingProvided = TextEditingController();
  final projectPortfolio = false.obs;

  // Opportunity type: "Job", "Internship", "Contract"
  final opportunityType = ''.obs;

  // Additional fields
  final jobCategory = ''.obs;
  final RxList<String> selectedSubCategories = <String>[].obs;
  final RxList<SubCategoryModel> filteredSubCategories = <SubCategoryModel>[].obs;
  final timeFrame = TextEditingController();
  final educationLevel = ''.obs;
  final languageRequirements = TextEditingController();
  final tags = RxList<String>();         // For job categories/keywords (tags)
  final requiredSkills = RxList<String>(); // For required skills
  final preferredRequirements = TextEditingController();
  final minimumRequirements = TextEditingController();
  final additionalInfo = TextEditingController();
  final frequency = ''.obs;               // For frequency dropdown (e.g., Weekly, Monthly, Annually)

  // Global key for form validation
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// Validates the entire form.
  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  /// Final Submission: Constructs a PostingModel and uses the repository to save it.
  Future<void> submitPosting() async {
    if (!validateForm()) return;

    try {
      // Parse the date fields (implement your own parsing logic or use a date formatter)
      DateTime? parsedStartDate = DateTime.tryParse(startDate.text.trim());
      DateTime? parsedEndDate = DateTime.tryParse(endDate.text.trim());
      DateTime parsedDeadline = DateTime.tryParse(deadline.text.trim()) ?? DateTime.now();
      DateTime? parsedExpectedStartDate = DateTime.tryParse(expectedStartDate.text.trim());
      DateTime? parsedPostingExpirationDate = DateTime.tryParse(postingExpirationDate.text.trim());

      // Construct the PostingModel using data from the controller.
      final posting = PostingModel(
        id: '', // Firestore can generate an ID if desired
        companyId: 'your_company_id_here', // Replace with company ID from auth/profile.
        opportunityType: opportunityType.value,
        jobTitle: jobTitle.text.trim(),
        subcategories: selectedSubCategories,
        jobDescription: jobDescription.text.trim(),
        location: location.text.trim(),
        employmentMode: employmentMode.value,
        experienceLevel: experienceLevel.value,
        salaryRange: salaryRange.text.trim(),
        benefits: benefits.text.trim(),
        startDate: parsedStartDate,
        endDate: parsedEndDate,
        deadline: parsedDeadline,
        howToApply: howToApply.value.trim(), // Use .text here instead of .value
        requiredDocuments: requiredDocuments.text.trim(),
        applicationQuota: int.tryParse(applicationQuota.text.trim()),
        selectionProcess: selectionProcess.text.trim(),
        equalOpportunityStatement: equalOpportunityStatement.text.trim(),
        workAuthorizationRequirements: workAuthorizationRequirements.text.trim(),
        expectedStartDate: parsedExpectedStartDate,
        postingExpirationDate: parsedPostingExpirationDate,
        internalReferenceCode: internalReferenceCode.text.trim(),
        contactEmail: contactEmail.text.trim(),
        duration: duration.text.trim(),
        academicCredit: academicCredit.value,
        returnOfferPotential: returnOfferPotential.value,
        trainingProvided: trainingProvided.text.trim(),
        projectPortfolio: projectPortfolio.value,
        verificationStatus: VerificationStatus.pending,
        jobCategory: jobCategory.value,
        timeFrame: timeFrame.text.trim(),
        educationLevel: educationLevel.value,
        languageRequirements: languageRequirements.text.trim(),
      );

      // Save the posting using the repository.
      await PostingRepository.instance.createPosting(posting);

      Get.snackbar(
        'Success',
        'Posting created successfully!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
