import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//package
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final mainProvider = ChangeNotifierProvider(
  ((ref) =>  MainModel()
));

class MainModel extends ChangeNotifier{
  User? currentUser;

  MainModel(){
    init();
  }

  Future<void> init() async{
    currentUser = FirebaseAuth.instance.currentUser;
  }
}