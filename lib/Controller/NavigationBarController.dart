import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter/Controller/Auth_controller.dart';
import 'package:word_generator/word_generator.dart';

import '../Components/GradientText.dart';
import '../Components/LoaderButton.dart';
import '../Components/NeumorphismContainer.dart';
import '../Utils/Constant.dart';
import '../Utils/Global.dart';

class NavigationBarController extends GetxController {
  RxInt currentIndex = 0.obs;
}
