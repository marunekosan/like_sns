import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavigationBarProvider = ChangeNotifierProvider(
  (ref) => BottomNavigationBarModel()
);
class BottomNavigationBarModel extends ChangeNotifier {
  int currentIndex = 0;
  late PageController pageController;
 
  BottomNavigationBarModel() {
    init();
  }
  void init() {
    pageController = PageController(
      initialPage: currentIndex
    );
    notifyListeners();
  }
 
  void onPageChanged({required int index}) {
    currentIndex = index;
    notifyListeners();
  }
 
  void onTabTapped({required int index}) {
    pageController.animateToPage(
      index, 
      duration: const Duration(milliseconds: 10), 
      curve: Curves.easeIn
    );
  }
 
  void setPageController() {
    pageController = PageController(
      initialPage: currentIndex
    );
    notifyListeners();
  }
}