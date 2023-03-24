import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  late String language;

  SettingProvider() {
    language = "Tiếng Việt";
  }

  void changeLanguage(String language) {
    this.language = language;
    notifyListeners();
  }
}
