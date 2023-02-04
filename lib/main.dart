//flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

//models
import 'package:like_sns/models/main_model.dart';
import 'package:like_sns/views/login_page.dart';

//options
import 'firebase_options.dart';

//route
import 'package:like_sns/routes/routes.dart' as routes;

import 'models/login_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final LoginModel loginModel = ref.watch(loginProvider);

    return MaterialApp(
      title: '簡易的なSNS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: loginModel.currentUser == null
      ? const LoginPage()
      : const MyHomePage(title: '簡易的なSNS'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final MainModel mainModel = ref.watch(mainProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => routes.toSignupPage(context: context),
              child: Text("サインアップページ")
            ),
            ElevatedButton(
              onPressed: () => routes.toLoginPage(context: context),
              child: Text("ログインページ")
            )
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     mainModel.createUser(context: context);
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This
    );
  }
}