// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class UsuarioApi {
  static const String baseUrl = crear_usuario;
  // Reemplaza con tu URL de Django

  static Future<void> crearUsuario(Usuario usuario) async {
    print(usuario.password);
    print(baseUrl);
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );
    print(response.body);

    if (response.statusCode == 201) {
      print('Usuario creado exitosamente');
    } else {
      print('Error al crear el Usuario: ${response.statusCode}');
    }
    print(baseUrl);
  }

  // static Future<List<Map<String, dynamic>>> fetchUsuarios() async {
  //   final response = await http.get(Uri.parse(estudiantes));
  //
  //   if (response.statusCode == 200) {
  //     //setState(() {
  //       final usuarios = jsonDecode(response.body);
  //       print(usuarios);
  //       return usuarios;
  //     //});
  //   } else {
  //     // Manejar errores según sea necesario
  //     print('Error al obtener la lista de usuarios: ${response.statusCode}');
  //   }
  // }

  static Future<List<Usuario>> obtenerUsuario() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Usuario.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Usuario: ${response.statusCode}');
    }
  }

  static Future<void> actualizarUsuario(
      int id, Usuario usuario) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el Usuario: ${response.statusCode}');
    }
  }

  static Future<void> eliminarUsuario(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el Usuario: ${response.statusCode}');
    }
  }
}