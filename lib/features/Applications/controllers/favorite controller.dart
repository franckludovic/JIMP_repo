import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_bc_tuto/data/repositories/postings/posting_repository.dart';
import 'package:project_bc_tuto/features/Applications/models/posting_model.dart';
import 'package:project_bc_tuto/utils/local_storage/storage_utility.dart';
import 'package:project_bc_tuto/utils/popups/loaders.dart';

class FavoriteController extends GetxController {
 static FavoriteController get instance =>Get.find();

  ///variable
  final favorite = <String, bool>{}.obs;



  @override
  void onInit() {
    super.onInit();
    initFavorite();

  }


    //Method to initialise favorite by reading from storage
   void initFavorite() {
     final json = JLocalStorage.instance().readData('favorites');
     if(json != null){
       final storedFavorite = jsonDecode(json) as Map<String, dynamic>;
       favorite.assignAll(storedFavorite.map((key, value) => MapEntry(key, value as bool)));
     }
  }

  bool isFavorite(String postingId) {
    return favorite[postingId] ?? false;
  }

  void toggleFavoritePosting(String postingId){
    if(!favorite.containsKey(postingId)){
      favorite[postingId] = true;
      saveFavoriteToStrorage();
      JLoaders.customToast(message: 'Posting has been added to the Saved postings');
    } else {
      JLocalStorage.instance().removeData(postingId);
      favorite.remove(postingId);
      saveFavoriteToStrorage();
      favorite.refresh();
      JLoaders.customToast(message: 'Posting has been removed from the Saved postings');
    }
  }

  void saveFavoriteToStrorage(){
    final encodedFavorites = json.encode(favorite);
    JLocalStorage.instance().saveData('favorites', encodedFavorites);
  }

  Future<List<PostingModel>> favoritePostings() async {
    return await PostingRepository.instance.getFavoritePostings(favorite.keys.toList());
  }

}