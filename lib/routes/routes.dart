import 'package:flutter/material.dart';
import 'package:like_sns/models/main_model.dart';
import 'package:like_sns/views/signup_page.dart';
import 'package:like_sns/views/login_page.dart';

void toSignupPage({required BuildContext context}) => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

void toLoginPage({required BuildContext context, required MainModel mainModel}) => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));