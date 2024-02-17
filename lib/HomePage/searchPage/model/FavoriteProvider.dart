import 'package:flutter/material.dart';

class favortitProvider extends ChangeNotifier {
  List fav_list = [];
  List get _fav_list => fav_list;
  late bool isfavorite;
  bool isExist(int index) {
    isfavorite = fav_list.contains(index);
    return isfavorite;
  }

  void toggle(int index) {
    if (isExist(index)) {
      _fav_list.remove(index);
    } else {
      _fav_list.add(index);
    }
    notifyListeners();
  }
}
