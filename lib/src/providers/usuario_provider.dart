// usuario_provider.dart
import 'package:flutter/material.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';

class UsuarioProvider extends ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUserDetails(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }
}
