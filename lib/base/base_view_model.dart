import 'package:flutter/cupertino.dart';


class BaseViewModelOffline {
  final int id;
  final String imageUrl;
  final String name;
  final double price;
  final double review;
  final double star;

  int value;

  BaseViewModelOffline(
      {required this.id,
      required this.imageUrl,
      required this.name,
      required this.price,
      required this.review,
      required this.star,
      required this.value});
}





class BaseViewModel extends ChangeNotifier{
  bool _isLoading=false;
  bool _loadingMore=false;

  bool getLoading(){
    return _isLoading;
  }

  void setIsLoading(){
    _isLoading=true;
    notifyListeners();
  }

  void cancelIsLoading(){
    _isLoading=false;
    notifyListeners();
  }

  bool getLoadMore(){
    return _loadingMore;
  }

  void setLoadMore(){
    _loadingMore=true;
    notifyListeners();
  }

  void cancelLoadMore(){
    _loadingMore=false;
    notifyListeners();
  }


}