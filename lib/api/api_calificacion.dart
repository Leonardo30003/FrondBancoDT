// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/calificacion_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class CalificacionApi {
  static const String baseUrl = crear_calificaciones;
  // Reemplaza con tu URL de Django

  static Future<void> crearCalificacion(Calificacion calificacion) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(calificacion.toJson()),
    );

    if (response.statusCode == 201) {
      print('Calificacion creado exitosamente');
    } else {
      print('Error al crear el calificacion: ${response.statusCode}');
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

  static Future<List<Calificacion>> obtenerCalificacion() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Calificacion.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener calificacion: ${response.statusCode}');
    }
  }

  static Future<void> actualizarCalificacion(
      int id, Calificacion calificacion) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(calificacion.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el calificacion: ${response.statusCode}');
    }
  }

  static Future<void> eliminarCalificacion(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el calificacion: ${response.statusCode}');
    }
  }
}