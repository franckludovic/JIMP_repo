

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/categories/category_repository.dart';
import 'package:project_bc_tuto/features/Applications/models/categorie_model.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

import '../../../data/repositories/categories/sub_categories_repository.dart';
import '../models/sub_categorie_model.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  final _categoryRepository = Get.put(CategoryRepository());
  final subcategoryRepository = Get.put(SubCategoryRepository());
  final isLoading = false.obs;
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;
  RxList<SubCategoryModel> subCategories = <SubCategoryModel>[].obs;
  final RxList<SubCategoryModel> allSubCategories = <SubCategoryModel>[].obs;
  final RxList<SubCategoryModel> filteredSubCategories = <SubCategoryModel>[].obs;

  final FirebaseFirestore _db = FirebaseFirestore.instance;


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

  final RxList<SubCategoryModel> selectedSubCategories = <SubCategoryModel>[].obs;

  // A method to update the subcategories based on the selected category.
  Future<void> updateSubCategories(String parentCategory) async {
    final subCategories = await SubCategoryRepository.instance.getSubCategoriesByParent(parentCategory);
    // You can assign the result to an observable list, or filter further as needed.
    selectedSubCategories.assignAll(subCategories);
  }



  ///get all subcategory
  Future<void> fetchSubcategoriesFor(String parentCategory) async {
    try {
      isLoading.value = true;
      final snapshot = await _db.collection('subcategories').where('parentCategory', isEqualTo: parentCategory).get();

      final subs = snapshot.docs
          .map((doc) => SubCategoryModel.fromJson(doc.data(), doc.id))
          .toList();
      subCategories.assignAll(subs);
    } catch (e) {
      JLoaders.errorSnackBar(title: 'Subcategory Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  ///filter subcategory by category
  Future<void> filterSubCategoriesByCategory(String categoryName) async {
    final subs = await subcategoryRepository.getSubCategoriesByParent(categoryName);
    filteredSubCategories.assignAll(subs);
  }

///Get category or sub category
}