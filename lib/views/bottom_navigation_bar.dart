// flutter
import 'package:flutter/material.dart';
// constants
import 'package:like_sns/constants/bottom_navigation_bar.dart';
// model
import 'package:like_sns/models/bottom_navigation_bar_model.dart';
 
class LikeSnsBottomNavigationBar extends StatelessWidget {
  const LikeSnsBottomNavigationBar({
    Key? key,
    required this.bottomNavigationBarModel
  }) : super(key: key);
 
  final BottomNavigationBarModel bottomNavigationBarModel;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: bottomNavigationBarElements,
      currentIndex: bottomNavigationBarModel.currentIndex,
      onTap: (index) => bottomNavigationBarModel.onTabTapped(index: index),
    );
  }
}