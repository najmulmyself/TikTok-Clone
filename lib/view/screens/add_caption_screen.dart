import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AddCaptionScreen extends StatefulWidget {
  File videoFile;
  String videoPath;

  AddCaptionScreen({required this.videoFile, required this.videoPath});

  @override
  State<AddCaptionScreen> createState() => _AddCaptionScreenState();
}

class _AddCaptionScreenState extends State<AddCaptionScreen> {
  late VideoPlayerController videoPlayerController =
      VideoPlayerController.file(widget.videoFile);

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
      body: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: VideoPlayer(videoPlayerController),
        )
      ]),
    );
  }
}
