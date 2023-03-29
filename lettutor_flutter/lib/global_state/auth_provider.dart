import 'package:flutter/cupertino.dart';
import 'package:lettutor_flutter/models/user_model/tokens_model.dart';
import 'package:lettutor_flutter/models/user_model/user_model.dart';

class AuthProvider extends ChangeNotifier {
  late User userLoggedIn;
  Tokens? _tokens;

  void logIn(User user, Tokens tokens) {
    userLoggedIn = user;
    tokens = tokens;
    notifyListeners();
  }

  void setUser(User user) {
    userLoggedIn = user;
    notifyListeners();
  }

  void logOut() {
    _tokens = null;
    notifyListeners();
  }
}
