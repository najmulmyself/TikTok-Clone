import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/view/screens/add_video.dart';

getRandomColor() => [
      Colors.blueAccent,
      Colors.redAccent,
      Colors.greenAccent,
    ][Random().nextInt(3)];

// COLORS
const backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;

var pageIndex = const [
  Text("Home"),
  Text("Search"),
  AddVideoScreen(),
  Text("Messages"),
  Text("Profile"),
];
