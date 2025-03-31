//
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:project_bc_tuto/features/Applications/models/user_model.dart';
// import 'package:project_bc_tuto/utils/popups/loaders.dart';
//
// class UserController extends GetxController{
//   static UserController get instance => Get.find();
//
//   ///Save user Record from any registration Provider
//   Future<void> saveUserRecord(UserCredential? userCredentials) async {
//     try{
//       if(userCredentials != null) {
//         //Convert name ot first and last name
//         final nameParts = UserModel.nameParts(userCredentials.user!.displayName ?? '');
//         final username = UserModel.GenerateUsername(userCredentials.user!.displayName ?? '');
//       }
//
//       final user = UserModel(
//           id: userCredentials?.user!.uid,
//           firstName: firstName,
//           lastName: lastName,
//           username: username,
//           email: email,
//           phoneNumber: phoneNumber,
//           password: password,
//           country: country,
//           region: region,
//           city: city,
//           localAddress: localAddress,
//           educationLevel: educationLevel,
//           schoolAttended: schoolAttended
//       )
//
//     }catch(e) {
//       TLoaders.warningSnackBar(title: 'Data not saved', message: 'Something went wrong while saving your information. you can re-save your data in your Profile.');
//     }
//   }
// }