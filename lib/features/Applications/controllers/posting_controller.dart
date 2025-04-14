import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_bc_tuto/features/Applications/screens/proposals_page/proposal_page.dart';

import '../../../data/repositories/authentication/authentication_repositories.dart';
import '../../../data/repositories/postings/posting_repository.dart';
import '../../../data/repositories/user/company_repositories.dart';
import '../../../utils/constants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../../utils/popups/loaders.dart';
import '../../Applications/models/posting_model.dart';
import '../models/sub_categorie_model.dart';

class PostingController extends GetxController {
  static PostingController get instance => Get.find();
  final RxList<PostingModel> postings = <PostingModel>[].obs;
  final String? companyId = AuthenticationRepository.instance.authUser?.uid;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
    loadCompanyPostings(companyId!);
  }

  // TextEditingControllers for standard fields
  final jobTitle = TextEditingController();
  final jobDescription = TextEditingController();

  // Observable strings for dropdown fields
  final employmentMode = ''.obs; //
  final experienceLevel = ''.obs; //

  final salaryRange = TextEditingController();
  RxList<String> benefits = <String>[].obs;

  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final deadline = TextEditingController();

  final requiredDocuments = TextEditingController();
  final applicationQuota = TextEditingController();
  final selectionProcess = TextEditingController();

  // Additional posting fields
  final workAuthorizationRequirements = TextEditingController();
  final expectedStartDate = TextEditingController();
  final postingExpirationDate = TextEditingController();
  final contactEmail = TextEditingController();

  // Internship-specific fields
  final duration = TextEditingController();
  final academicCredit = false.obs;
  final returnOfferPotential = false.obs;
  final trainingProvided = TextEditingController();
  final projectPortfolio = false.obs;

  final opportunityType = ''.obs;

  // Additional fields
  final jobCategory = ''.obs;
  final RxList<String> selectedSubCategories = <String>[].obs;
  final RxList<SubCategoryModel> filteredSubCategories = <SubCategoryModel>[].obs;
  final timeFrame = TextEditingController();
  final educationLevel = ''.obs;
  final languageRequirements = TextEditingController();
  final tags = RxList<String>();
  final requiredSkills = RxList<String>();
  final preferredRequirements = TextEditingController();
  final minimumRequirements = TextEditingController();
  final additionalInfo = TextEditingController();
  final frequency = ''.obs;
  RxList<String> availableBranchAddresses = <String>[].obs;
  final RxString selectedBranchAddress = ''.obs;
  final RxString selectedLocationAddress = ''.obs;

  Future<void> loadBranchesForCompany(String companyId) async {
    try {
      final company =
          await CompanyRepository.instance.fetchCompanyById(companyId);

      final hq = company.headquarters;
      final hqAddress = '${hq.street}, ${hq.city}, ${hq.region}, ${hq.country}';

      // Convert each branch to address string
      final branchAddresses = company.branches.map((branch) {
        final addr = branch.address;
        return '${addr.street}, ${addr.city}, ${addr.region}, ${addr.country}';
      }).toList();

      // Insert headquarter as top-most option
      final List<String> finalAddresses = [hqAddress, ...branchAddresses];

      // Update observable list for dropdown
      availableBranchAddresses.assignAll(finalAddresses);

      if (branchAddresses.isEmpty) {
        selectedLocationAddress.value = hqAddress;
      }
    } catch (e) {
      print("Error loading company addresses: $e");
    }
  }

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
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Parse the date fields (implement your own parsing logic or use a date formatter)
      DateTime? parsedStartDate = DateTime.tryParse(startDate.text.trim());
      DateTime? parsedEndDate = DateTime.tryParse(endDate.text.trim());
      DateTime? parsedDeadline = DateTime.tryParse(deadline.text.trim());
      DateTime? parsedExpectedStartDate =
          DateTime.tryParse(expectedStartDate.text.trim());
      DateTime? parsedPostingExpirationDate =
          DateTime.tryParse(postingExpirationDate.text.trim());

      TFullScreenLoader.openLoadingDialog(
          'We are creating you post...', JImages.docerAnimation);

      // Construct the PostingModel using data from the controller.
      final posting = PostingModel(
          id: '',
          companyId: AuthenticationRepository.instance.authUser?.uid ?? '',
          opportunityType: opportunityType.value,
          jobTitle: jobTitle.text.trim(),
          subcategories: selectedSubCategories,
          jobDescription: jobDescription.text.trim(),
          location: selectedLocationAddress.value,
          employmentMode: employmentMode.value,
          experienceLevel: experienceLevel.value,
          salaryRange: salaryRange.text.trim(),
          benefits: benefits,
          startDate: parsedStartDate,
          endDate: parsedEndDate,
          deadline: parsedDeadline!,
          requiredSkills: requiredSkills,
          tags: tags,
          requiredDocuments: requiredDocuments.text.trim(),
          applicationQuota: int.tryParse(applicationQuota.text.trim()),
          selectionProcess: selectionProcess.text.trim(),
          workAuthorizationRequirements:
              workAuthorizationRequirements.text.trim(),
          expectedStartDate: parsedExpectedStartDate,
          postingExpirationDate: parsedPostingExpirationDate,
          contactEmail: contactEmail.text.trim(),
          duration: duration.text.trim(),
          academicCredit: academicCredit.value,
          returnOfferPotential: returnOfferPotential.value,
          trainingProvided: trainingProvided.text.trim(),
          projectPortfolio: projectPortfolio.value,
          verificationStatus: VerificationStatus.pending,
          jobCategory: jobCategory.value,
          educationLevel: educationLevel.value,
          languageRequirements: languageRequirements.text.trim(),
          frequency: frequency.value,
          additionalInfo: additionalInfo.text.trim(),
          minimumRequirements: minimumRequirements.text.trim(),
          preferredRequirements: preferredRequirements.text.trim());

      final postingRepository = Get.put((PostingRepository()));
      await postingRepository.createPosting(posting);

      await CompanyRepository.instance.incrementTotalListings(
        AuthenticationRepository.instance.authUser?.uid ?? '',
      );

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your post has been completed.',
      );

      Get.to(() => ProposalPage());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }

  /// Assumes that you have fetched the current posting from Firestore and want to update it.
  Future<void> updatePosting(PostingModel currentPosting) async {
    if (!validateForm()) return;

    try {
      // Parse date fields
      DateTime? parsedStartDate = DateTime.tryParse(startDate.text.trim());
      DateTime? parsedEndDate = DateTime.tryParse(endDate.text.trim());
      DateTime parsedDeadline =
          DateTime.tryParse(deadline.text.trim()) ?? DateTime.now();
      DateTime? parsedExpectedStartDate =
          DateTime.tryParse(expectedStartDate.text.trim());
      DateTime? parsedPostingExpirationDate =
          DateTime.tryParse(postingExpirationDate.text.trim());

      TFullScreenLoader.openLoadingDialog(
          'Updating your post...', JImages.docerAnimation);

      // Use copyWith to create an updated PostingModel.
      final updatedPosting = currentPosting.copyWith(
        opportunityType: opportunityType.value,
        jobTitle: jobTitle.text.trim(),
        subcategories: selectedSubCategories.toList(),
        jobDescription: jobDescription.text.trim(),
        location: selectedLocationAddress.value,
        employmentMode: employmentMode.value,
        experienceLevel: experienceLevel.value,
        salaryRange: salaryRange.text.trim(),
        benefits: benefits.toList(),
        frequency: frequency.value,
        startDate: parsedStartDate,
        endDate: parsedEndDate,
        deadline: parsedDeadline,
        expectedStartDate: parsedExpectedStartDate,
        postingExpirationDate: parsedPostingExpirationDate,
        requiredDocuments: requiredDocuments.text.trim(),
        applicationQuota: int.tryParse(applicationQuota.text.trim()),
        selectionProcess: selectionProcess.text.trim(),
        workAuthorizationRequirements: workAuthorizationRequirements.text.trim(),
        contactEmail: contactEmail.text.trim(),
        duration: duration.text.trim(),
        academicCredit: academicCredit.value,
        returnOfferPotential: returnOfferPotential.value,
        trainingProvided: trainingProvided.text.trim(),
        projectPortfolio: projectPortfolio.value,
        jobCategory: jobCategory.value,
        educationLevel: educationLevel.value,
        languageRequirements: languageRequirements.text.trim(),
        tags: tags.toList(),
        requiredSkills: requiredSkills.toList(),
        preferredRequirements: preferredRequirements.text.trim(),
        minimumRequirements: minimumRequirements.text.trim(),
        additionalInfo: additionalInfo.text.trim(),
      );

      // Call your repository's update method
      await PostingRepository.instance.updatePosting(updatedPosting);

      TFullScreenLoader.stopLoading();
      JLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your post has successfully been updated.',
      );
    } catch (e) {
      TFullScreenLoader.stopLoading();
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }

  Future<void> deletePosting(String postingId) async {
    try {
      await PostingRepository.instance.removePosting(postingId);
      JLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your post has successfully been deleted.',
      );
    } catch (e) {
      JLoaders.errorSnackBar(title: 'OH Snap!', message: e.toString());
    }
  }


  final PostingRepository postFetch = Get.put(PostingRepository());
  RxList<PostingModel> posts = <PostingModel>[].obs;
  RxList<PostingModel> companyPosts = <PostingModel>[].obs;


  // Method to load all postings
  Future<void> fetchPosts() async {
    try {
      final postingsFetch = await PostingRepository.instance.fetchAllPostings();
      posts.assignAll(postingsFetch);
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  // To fetch postings by company:
  void loadCompanyPostings(String companyId) async {
    try {
      final companyPostsFetch = await PostingRepository.instance.fetchPostingsByCompany(companyId);
      companyPosts.assignAll(companyPostsFetch);
    } catch (e) {
      // Handle error
    }
  }


}
