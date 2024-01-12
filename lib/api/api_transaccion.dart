// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/transaccion_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class TransaccionApi {
  static const String baseUrl = crear_calificaciones;
  // Reemplaza con tu URL de Django

  static Future<void> crearTransaccionTiempo(TransaccionTiempo transaccionTiempo) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaccionTiempo.toJson()),
    );

    if (response.statusCode == 201) {
      print('TransaccionTiempo creado exitosamente');
    } else {
      print('Error al crear el TransaccionTiempo: ${response.statusCode}');
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

  static Future<List<TransaccionTiempo>> obtenerTransaccionTiempo() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => TransaccionTiempo.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener TransaccionTiempo: ${response.statusCode}');
    }
  }

  static Future<void> actualizarTransaccionTiempo(
      int id, TransaccionTiempo transaccionTiempo) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(transaccionTiempo.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el TransaccionTiempo: ${response.statusCode}');
    }
  }

  static Future<void> eliminarTransaccionTiempo(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el TransaccionTiempo: ${response.statusCode}');
    }
  }
}