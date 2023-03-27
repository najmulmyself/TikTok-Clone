import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/user.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proImg;
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    final img = File(image!.path);
    proImg = img;
  }

  SignUp(String username, String email, String password, File? img) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          img != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        String dwnloadURL = await uploadImage(img);

        myUser user = myUser(
          name: username,
          email: email,
          profilePhoto: dwnloadURL,
          uid: credential.user!.uid,
        );

        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set(
              user.toJson(),
            );
      } else {
        Get.snackbar(
            "Error Creating User", "Please Enter All the Required Field");
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
