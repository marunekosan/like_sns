// dart
import 'dart:io';
// flutter
import 'package:flutter/material.dart';
// package
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


Future<XFile> returnXFile() async {
  final ImagePicker picker = ImagePicker();
  final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  return image!;
}

Future<CroppedFile?> returnCroppedFile({ required XFile? xFile }) async {
  final instance = ImageCropper();
  final CroppedFile? result = await instance.cropImage(
    sourcePath: xFile!.path,
    aspectRatioPresets: [CropAspectRatioPreset.square],
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: "Cropper",
        toolbarColor: Colors.green,
        initAspectRatio: CropAspectRatioPreset.square,
        lockAspectRatio: false
      ),
      IOSUiSettings(
        title: "Cropper"
      )
    ]
  );
  return result;
}