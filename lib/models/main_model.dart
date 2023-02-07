// flutter
import 'package:flutter/material.dart';

//package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//routes
import 'package:like_sns/routes/routes.dart' as routes;

import 'package:like_sns/domain/firestore_user.dart';

final mainProvider = ChangeNotifierProvider(
  ((ref) =>  MainModel()
));

class MainModel extends ChangeNotifier {
  bool isLoading = false;
  User? currentUser;
  late DocumentSnapshot<Map<String,dynamic>> currentUserDoc;
  late FirestoreUser firestoreUser;
  //以下がMainModelが起動した時の処理
  // ユーザーの動作を必要としないモデルの関数
  MainModel() {
    init();
  }
  // initの中でcurrentUserを更新すれば良い
  Future<void> init() async {
    startLoading();
    currentUser = FirebaseAuth.instance.currentUser;
    currentUserDoc = await FirebaseFirestore.instance.collection("users").doc(currentUser!.uid).get();
    firestoreUser = FirestoreUser.fromJson(currentUserDoc.data()!);
    endLoading();
  }
  void startLoading() {
    isLoading = true;
    notifyListeners();
  }
  void endLoading() {
    isLoading = false;
    notifyListeners();
  }
  void setCurrentUser() {
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }
 
  Future<void> logout({required BuildContext context,required MainModel mainModel}) async {
    await FirebaseAuth.instance.signOut();
    setCurrentUser();
    routes.toLoginPage(context: context, mainModel: mainModel);
  }
}