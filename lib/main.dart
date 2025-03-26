import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'data/reposiories/authentication/authentication_repository.dart';
import 'firebase_options.dart';

Future<void> main() async {

  //add widgets binbing
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  //init local storage
  await GetStorage.init();


  //await native splash
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //init firebase
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
      (FirebaseApp value) => Get.put(AuthenticationRepository()),
  );
  //init authentication

  runApp(const App());
}


