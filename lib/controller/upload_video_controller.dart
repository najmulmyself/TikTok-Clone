import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  var uuid = Uuid();
  uploadVideo(String songName, String caption, String videoPath) {
    // video should be uploaded with a unique id | we can do it many ways by creaing firebase instances and get a uid by :
    // uid = FirebaseAuth.instance.currentUser!.uid;

    // but we will do it by a package name uuid

    String id = uuid.v1(); // uuid instansiated before

    uploadVideoToStorage(id, videoPath);
    uploadVideoThumbToStorage(id, videoPath);
  }

  Future<String> uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child("videos").child(id);
    //first chlid will be folder name
    // second chlid will be file name- here is id will be the file name

    UploadTask upload = ref.putFile(await compressVideo(videoPath));
    // compressVideo(videoPath) returns a Future<File> object.
    // Therefore, using await before calling this method waits for the compression to complete and returns a File object

    // OR WE CAN DO LIKE THIS

    //     File compressedVideoFile = await compressVideo(videoPath);
    // UploadTask upload = ref.putFile(compressedVideoFile);

    TaskSnapshot snapshot = await upload;
    String downURL = await snapshot.ref.getDownloadURL();
    return downURL;
  }

  compressVideo(String videoPath) async {
    final compressVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.MediumQuality);
    return compressVideo!.file;
  }

  Future<String> uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference ref = FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask upload = ref.putFile(await getThumb(videoPath));
    TaskSnapshot snapshot = await upload;
    String downThumbURL = await snapshot.ref.getDownloadURL();
    return downThumbURL;
  }

  Future<File> getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }
}
