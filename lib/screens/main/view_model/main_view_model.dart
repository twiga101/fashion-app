import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_view_model.dart';

class MainViewModel extends BaseViewModel {
  int selectedNavigationItem = 0;
  bool isOnSearchPage = false;
  bool isFirstTry = true;

  void setOnIsSearchMode(bool value) {
    if (value) {
      isOnSearchPage = false;
    } else {
      isOnSearchPage = true;
    }
    notifyListeners();
  }

  setSelectedNavigationItem(int value) {
    selectedNavigationItem = value;
    notifyListeners();
  }

  int getSelectedNavigationItem() {
    return selectedNavigationItem;
  }
}

final mainViewModelProvider = ChangeNotifierProvider.autoDispose<MainViewModel>(
  (ref) => MainViewModel(),
);
