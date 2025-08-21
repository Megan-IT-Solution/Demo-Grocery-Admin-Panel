import 'package:flutter/cupertino.dart';

class PaginationController extends ChangeNotifier {
  int _currentPage = 0;
  int _currentIndex = 0;
  int _totalNumberPerPage = 4;

  int get currentPage => _currentPage;
  int get totalNumberPerPage => _totalNumberPerPage;
  int get currentIndex => _currentIndex;

  onBack() {
    _currentPage = (_currentPage - _totalNumberPerPage!).clamp(0, currentPage);
    if (currentIndex > 0) {
      _currentIndex--;
    }
    notifyListeners();
  }

  onNext(itemLength) {
    if ((_currentPage + _totalNumberPerPage!) < itemLength) {
      _currentPage += _totalNumberPerPage!;
      _currentIndex++;
      notifyListeners();
    }
  }

  onDecrement() {
    if (_totalNumberPerPage > 1) {
      _totalNumberPerPage--;

      _currentPage = 0;
      _currentIndex = 0;
      notifyListeners();
    }
  }

  onIncrement(int itemLength) {
    if (totalNumberPerPage < itemLength) {
      _totalNumberPerPage++;
      _currentPage = 0;
      _currentIndex = 0;
      notifyListeners();
    }
  }

  reset() {
    _currentPage = 0;
    _currentIndex = 0;
    _totalNumberPerPage = 4;
    notifyListeners();
  }
}
