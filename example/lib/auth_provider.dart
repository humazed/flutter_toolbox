import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthProvider extends ChangeNotifier {
  static AuthProvider of(BuildContext context, {bool listen = true}) =>
      Provider.of<AuthProvider>(context, listen: listen);

  User _user;

  User getUserCashed() => _user;

  void login() {
    _user = User();
    notifyListeners();
  }

  void logout() {
    _user = null;
    notifyListeners();
  }
}

class User {}
