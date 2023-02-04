import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = ChangeNotifierProvider(
  (ref) => LoginModel()
);

class LoginModel extends ChangeNotifier{
  String email = "";
  String password = "";
  User? currentUser;
  String errorMessage = "";

  Future<void> login({required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      currentUser = FirebaseAuth.instance.currentUser;
    } on FirebaseAuthException catch(e) {
      errorMessage = loginUserError(e.code);
    }
    notifyListeners();
  }

  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
    currentUser = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  //ユーザー登録時のエラーメッセージ
  String loginUserError(String fireBaseErrCode){
    String message = "";
    switch(fireBaseErrCode) {
      case 'invalid-email':
        message = "メールアドレスの形式が不正です";
        break;
      case 'email-already-in-use':
        message = "このメールアドレスは既に使われています";
        break;
      case 'user-not-found':
        message = "このユーザーは登録されていません";
        break;
      case 'wrong-password':
        message = "パスワードが間違っています";
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