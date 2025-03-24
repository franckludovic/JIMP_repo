import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {

  //add widgets binbing
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //init local storage
  //await native splash
  //init firebase
  
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //init authentication

  runApp(const App());
}


