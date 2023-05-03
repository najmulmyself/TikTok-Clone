import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/model/user.dart';
import 'package:tiktok_clone/view/screens/auth/login_screen.dart';
import 'package:tiktok_clone/view/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  File? proImg;
  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
    final img = File(image.path);
    proImg = img;
    } else {
      Get.snackbar("No Image Selected", "Problem with selecting images");
    }
  }

  //user state persistence

  late Rx<User?> user;

  @override
  void onReady() {
    super.onReady();
    user = Rx<User?>(FirebaseAuth.instance.currentUser);
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(user, setInitialView);
  }

  setInitialView(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());

//       Get.offAll is a navigation method provided by the GetX package in Flutter. It is used to remove all previous rouFtes from the navigator stack and navigate to a new screen, so that the user cannot go back to the previous screen by pressing the back button.

// The Get.offAll method takes a widget as its argument, which is the screen to navigate to. For example, Get.offAll(() => HomeScreen()) will navigate to the HomeScreen widget.
    }
  }
  //////////////////MORE DETAIL IN NOTION////////////////
  //user state persistence

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

  login(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar("Error Logging in", "Please Enter all the fields");
      }
    } catch (e) {
      Get.snackbar("Error Logging IN", e.toString());
    }
  }

  Future<String> uploadImage(File image) async {
    // Reference ref = FirebaseStorage.instance.ref();

    //first chlid will be folder name
    // second chlid will be file name- here is uid will be the file name
    // ref
    // .child('profilePics/images')
    // .child(FirebaseAuth.instance.currentUser!.uid);
    // .child(
    //     'profilePics/images/${FirebaseAuth.instance.currentUser!.uid}'); //CHATGPT
///////////////CHATGPT SUGGESTION//////////////////////////
    // ref = FirebaseStorage.instance
    //     .ref()
    //     .child('profilePics/${FirebaseAuth.instance.currentUser!.uid}');

    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profilePics')
        .child(FirebaseAuth.instance.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image); // uploading file
    TaskSnapshot snapshot =
        await uploadTask; // wait until upload completed and return a snapshot
    String imageDownURL = await snapshot.ref
        .getDownloadURL(); // download link can be saved in storage

    return imageDownURL;
  }
}
