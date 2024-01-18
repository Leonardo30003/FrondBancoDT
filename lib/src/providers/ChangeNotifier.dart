import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;
}
