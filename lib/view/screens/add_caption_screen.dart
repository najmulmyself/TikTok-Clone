import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/constant.dart';
import 'package:tiktok_clone/view/widgets/myTextfield.dart';
import 'package:video_player/video_player.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  AddCaptionScreen({required this.videoFile, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    videoPlayerController = VideoPlayerController.file(widget.videoFile);
    videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setLooping(true);
    videoPlayerController.setVolume(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: VideoPlayer(videoPlayerController),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextInputField(
                    controller: songController,
                    myIcon: Icons.music_note,
                    myLabelText: "Soong name",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextInputField(
                    controller: captionController,
                    myIcon: Icons.closed_caption,
                    myLabelText: "Caption",
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: buttonColor),
                    onPressed: () {},
                    child: const Text(
                      "Upload",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
