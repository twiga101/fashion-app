import 'package:flutter/cupertino.dart';
import 'package:fashon_app/data/app_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_view_model.dart';

class SearchViewModel extends BaseViewModel {
  final TextEditingController _controller = TextEditingController();
  bool isFirstTry = true;
  TextEditingController getSearchTextContrrollerValue() {
    return _controller;
  }

  void clearSearchTextField() {
    _controller.text = "";
    FocusManager.instance.primaryFocus?.unfocus();
    notifyListeners();
  }

  void searchFunction(String searchValue) {
    itemSearchList = mainList
        .where(
          (element) => element.name.toLowerCase().contains(searchValue),
        )
        .toList();

    notifyListeners();
  }
}

final searchViewModelProvider =
    ChangeNotifierProvider.autoDispose<SearchViewModel>(
  (ref) => SearchViewModel(),
);
