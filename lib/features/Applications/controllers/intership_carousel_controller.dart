

import 'package:get/get.dart';

import '../../../utils/popups/loaders.dart';

class IntershipCarouselController extends GetxController {
  final carouselCurrentIndex = 0.obs;

  void updatePageIndicator(index){
    carouselCurrentIndex.value = index;
  }

  final isLoading = false.obs;

  ///Fetch Internships
  Future<void> fetchInternships() async {
    try{
      // show loader
      isLoading.value = true;

     }catch(e) {
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }finally {
      isLoading.value = false;
    }
  }

}