import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationIndex extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    notifyListeners();
  }
}