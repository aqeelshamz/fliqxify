import 'package:flutter/cupertino.dart';

class BottomNavigationProvider extends ChangeNotifier {
  int currentIndex = 0;
  changeIndex(int newIndex) {
    currentIndex = newIndex;
    notifyListeners();
  }
}
