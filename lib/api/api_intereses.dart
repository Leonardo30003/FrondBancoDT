// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/interes_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class InteresApi {
  static const String baseUrl = crear_intereses;
  // Reemplaza con tu URL de Django

  static Future<void> crearInteres(Interes interes) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(interes.toJson()),
    );

    if (response.statusCode == 201) {
      print('Interes creado exitosamente');
    } else {
      print('Error al crear el Interes: ${response.statusCode}');
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

  static Future<List<Interes>> obtenerInteres() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Interes.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Interes: ${response.statusCode}');
    }
  }

  static Future<void> actualizarInteres(
      int id, Interes interes) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(interes.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el Interes: ${response.statusCode}');
    }
  }

  static Future<void> eliminarInteres(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el Interes: ${response.statusCode}');
    }
  }
}