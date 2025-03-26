import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as deviceStorage;

import '../../Applications/screens/type_user/type_user_page.dart';


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

      if(kDebugMode) {
        print("=============== Get Storage Next Button=================");
        print(storage.read('isFirstTime'));
      }


      storage.write('isFirstTime', false);
      Get.offAll( const JTypeUser());

      if(kDebugMode) {
        print("=============== Get Storage Next Button=================");
        print(storage.read('isFirstTime'));
      }


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