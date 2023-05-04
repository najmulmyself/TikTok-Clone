import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({super.key});

  videoPick(ImageSource source, context) async {
    final video = await ImagePicker().pickVideo(source: source);
    if (video != null) {
      Get.snackbar("Video Selected", video.path);
    } else {
      Get.snackbar(
          "Error In Selecting Video", "Please Choose A Different Video File");
    }
  }

  showDialogOpt(context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text("Choose uploading method"),
        children: [
          SimpleDialogOption(
            onPressed: () => videoPick(ImageSource.gallery, context),
            child: const Text("Gallery"),
          ),
          SimpleDialogOption(
            onPressed: () => videoPick(ImageSource.camera, context),
            child: const Text("Camera"),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Close"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOpt(context),
          child: Container(
            width: 150,
            height: 50,
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
