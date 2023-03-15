import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  SignUp(String username, String email, String password, File? img) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          img != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        uploadImage(img);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error Occurred", e.toString());
    }
  }

  Future<String> uploadImage(File image) async {
    Reference ref = FirebaseStorage.instance.ref();

    //first chlid will be folder name
    // second chlid will be file name- here is uid will be the file name
    ref.child('profilePics').child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image); // uploading file
    TaskSnapshot snapshot =
        await uploadTask; // wait until upload completed and return a snapshot
    String imageDownURL = await snapshot.ref
        .getDownloadURL(); // download link can be saved in storage

    return imageDownURL;
  }
}
