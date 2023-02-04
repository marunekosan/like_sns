import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:like_sns/models/signup_model.dart';

//route
import 'package:like_sns/routes/routes.dart' as routes;

class SignupPage extends ConsumerWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SignupModel signupModel = ref.watch(signupProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("サインアップ")
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            signupModel.errorMessage,
            style: TextStyle(
              color: Colors.red
            )
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "メールアドレス",
            ),
            onChanged: (email) => signupModel.email = email,
            
          ),
          TextFormField(
            decoration: InputDecoration(
              hintText: "パスワード"
            ),
            onChanged: (password) => signupModel.password = password,
          ),
          ElevatedButton(
            onPressed: () => {
              if(signupModel.email != "" && signupModel.password != ""){
                signupModel.createUser(context: context),
              }else{
                signupModel.requiredError(),
              }
            },
            child: Text("新規登録")
          ),
        ],

      ),
    );
  }
}