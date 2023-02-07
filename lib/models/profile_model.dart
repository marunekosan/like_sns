// dart
import 'dart:io';

// packages
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:like_sns/constants/others.dart';

final profileProvider = ChangeNotifierProvider(
  ((ref) => ProfileModel())
);

class ProfileModel extends ChangeNotifier {
  File? croppedFile;
 
  Future<String> uploadImageAndGetURL({required String uid,required File file}) async {
    final String fileName = this.uniqueFileName();
    final Reference storageRef = FirebaseStorage.instance.ref().child("users").child(uid).child(fileName);
    // users/uid/ファイル名 にアップロード
    await storageRef.putFile(file);
    // users/uid/ファイル名 のURLを取得している
    return storageRef.getDownloadURL();
  }
 
  Future<void> uploadUserImage({required DocumentSnapshot<Map<String,dynamic>> currentUserDoc}) async {

    final XFile xFile = await returnXFile();
    final File file = File(xFile.path);
    final String uid = currentUserDoc.id;

    croppedFile = (await returnCroppedFile(xFile: xFile)) as File?;

    final String url = await uploadImageAndGetURL(uid: uid, file: file);
    await currentUserDoc.reference.update({
      'userImageURL': url,
    });
    notifyListeners();
  }

  String uniqueFileName(){
    const Uuid uuid = Uuid();
    return uuid.v4();
  }

}