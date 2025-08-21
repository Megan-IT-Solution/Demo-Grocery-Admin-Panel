import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier {
  int _currentIndex = 0;
  Widget? _categoryWidget;
  int get currentIndex => _currentIndex;
  Widget? get categoryWidget => _categoryWidget;
  int _clientListingIndex = 0;
  int get clientListingIndex => _clientListingIndex;
  int _creativeListingIndex = 0;
  int get creativeListingIndex => _creativeListingIndex;

  updateSideBarIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  updateClientListingIndex(int index) {
    _clientListingIndex = index;
    notifyListeners();
  }

  updateCreativeListingIndex(int index) {
    _creativeListingIndex = index;
    notifyListeners();
  }

  updateCategoryScreen(screen) {
    _categoryWidget = screen;
    notifyListeners();
  }
}
