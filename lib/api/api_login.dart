import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/src/providers/ChangeNotifier.dart';
import 'package:bancodt/src/providers/usuario_provider.dart';
import 'package:provider/provider.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';

// class Api {
//   static const String apiUrl = login;
//   static Future<String?> authenticate(String username, String password) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'username': username, 'password': password}),
//     );
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);
//       final String? token = data['access'];
//       return token;
//     } else {
//       throw Exception('Failed to authenticate');
//     }
//   }
//
//   static Future<void> saveToken(String token) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('token', token);
//   }
//
//   static Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('token');
//   }
//
//   static Future<void> clearToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove('token');
//   }
// }
class Api {
  static const String apiUrl = login;
  static const String busquedaUrl = buscar_usuario;
  static Future<Map<String, dynamic>?> authenticate(
      BuildContext context, String username, String password) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );
    print(response.body);
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final String? token = data['access'];
      print(token);
      final Map<String, dynamic>? user = await buscarPorCorreo(context,
          username); //= data; // Asumiendo que el usuario está directamente en el nivel superior de la respuesta
      print('user: $user');

      if (token != null && user != null) {
        // Usar el provider para actualizar el estado de autenticación y el usuario
        Provider.of<AuthProvider>(context, listen: false).setToken(token);
        Provider.of<UsuarioProvider>(context, listen: false)
            .setUserDetails(Usuario.fromJson(user));
        saveToken(token);
        // las dos lineas siguentes las agregue para pasar los datos del suuario
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(user));

        return {'token': token, 'user': user};
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> buscarPorCorreo(
      BuildContext context, String correo) async {
    final response = await http.get(
      Uri.parse(busquedaUrl + '?correo=$correo'),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> userData = json.decode(response.body);
      return userData;
    } else {
      return null;
    }
  }

  static Future<void> saveToken(String token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> clearToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
