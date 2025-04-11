

import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/categories/category_repository.dart';
import 'package:project_bc_tuto/features/Applications/models/categorie_model.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;


  @override
  void onInit() {
    fetchCategories();
    super.onInit();

  }

  ///Load category data
 Future<void> fetchCategories() async {
    try{
      // show loader
      isLoading.value = true;

      //Fetch categories from data source
      final categories = await _categoryRepository.getAllCategories();

      //update the categories
      allCategories.assignAll(categories);

      //filter featured categories
      featuredCategories.assignAll(allCategories.where((categories) => categories.isFeatured && categories.parentId.isEmpty).take(8).toList());
    }catch(e) {
      JLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }finally {
      isLoading.value = false;
    }
 }

  ///load selected category


  ///Get category or sub category
}