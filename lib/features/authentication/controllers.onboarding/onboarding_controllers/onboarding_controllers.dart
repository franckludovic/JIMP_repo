import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Applications/guess_screens/main_landing_page/main_landing_page.dart';


class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();

  ///Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  ///update Current Index when page Scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;


  ///jump to the spacific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }


  ///update current index & jump to next page
  void nextPage() {
    if (currentPageIndex.value == 2){
      final storage = GetStorage();
      storage.write('isFirstTime', false);
      Get.offAll( const LandingGuestPage());
    }else{
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }


  ///update current index & jump to last page
  void skipPage() {
    currentPageIndex.value = 2;
    pageController.jumpToPage(2);
  }

}