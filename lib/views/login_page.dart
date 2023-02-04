import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:like_sns/models/login_model.dart';

import 'package:like_sns/routes/routes.dart' as routes;

class LoginPage extends ConsumerWidget{
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref ){
    final LoginModel loginModel = ref.watch(loginProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('ログインページ')
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loginModel.errorMessage,
            style: TextStyle(
              color: Colors.red
            )
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "メールアドレス"
            ),
            onChanged: (email) => loginModel.email = email,
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "パスワード"
            ),
            onChanged: (password) => loginModel.password = password,
          ),
          ElevatedButton(
            onPressed: () {
              if(loginModel.currentUser == null){
                if(loginModel.password == "" || loginModel.email == ""){
                  loginModel.requiredError();
                }else{
                  loginModel.login(context: context);
                }
              }else{
                loginModel.logout();
              }
            },
            child: loginModel.currentUser == null
            ? Text("ログイン")
            : Text("ログアウト"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green
            ),
            onPressed: () => routes.toSignupPage(context: context),
            child: Text("新規登録"),
          ),
        ],

      ),
    );
  }
}