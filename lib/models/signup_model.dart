import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//domain
import 'package:like_sns/domain/firestore_user.dart';

final signupProvider = ChangeNotifierProvider(
  (ref) => SignupModel()
);

class SignupModel extends ChangeNotifier{
  int counter = 0;
  User? currentUser;
  // auth
  String email = "";
  String password = "";
  bool isObscure = true;
  String errorMessage = "";

  Future<void> createFirestoreUser({required BuildContext context,required String uid}) async {
    final Timestamp now = Timestamp.now();
    final FirestoreUser firestoreUser = FirestoreUser(
      createdAt: now,
      email: email,
      uid: uid,
      updatedAt: now,
      userName: "hogehoge",
    );
    final Map<String,dynamic> userData = firestoreUser.toJson();
    await FirebaseFirestore.instance.collection("users").doc(uid).set(userData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('ユーザーが作成できました')));
    notifyListeners();
  }

  Future<void> createUser({required BuildContext context}) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final User? user = result.user;
      final String uid = user!.uid;
      await createFirestoreUser(context: context,uid: uid);
    } on FirebaseAuthException catch(e) {
      debugPrint(e.code);
      errorMessage = createUserErrorMessage(e.code);
      notifyListeners();
    }
  }

  //ユーザー登録時のエラーメッセージ
  String createUserErrorMessage(String errorCode){
    String message = "";
    switch(errorCode) {
      case 'invalid-email':
        message = "メールアドレスの形式が不正です";
        break;
      case 'email-already-in-use':
        message = "このメールアドレスは既に使われています";
        break;
      case 'weak-password':
        message = "パスワードは少なくとも6文字以上で入力してください";
        break;
      case 'operation-not-allowed':
        message = "指定したメールアドレス・パスワードは現在使用できません";
        break;
      default:
        message = "不正なエラーが検出されました。";
        break;
    }

    return message;
  }

  void requiredError(){
    errorMessage = "メールアドレスとパスワードは必須です";
    notifyListeners();
  }

}