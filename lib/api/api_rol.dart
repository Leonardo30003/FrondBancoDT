// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/rol_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class RolApi {
  static const String baseUrl = crear_calificaciones;
  // Reemplaza con tu URL de Django

  static Future<void> crearRol(Rol rol) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(rol.toJson()),
    );

    if (response.statusCode == 201) {
      print('Rol creado exitosamente');
    } else {
      print('Error al crear el Rol: ${response.statusCode}');
    }
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

  static Future<List<Rol>> obtenerRol() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Rol.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Rol: ${response.statusCode}');
    }
  }

  static Future<void> actualizarRol(
      int id, Rol rol) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(rol.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el Rol: ${response.statusCode}');
    }
  }

  static Future<void> eliminarRol(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el Rol: ${response.statusCode}');
    }
  }
}