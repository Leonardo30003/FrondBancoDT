// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/categoria_modelo.dart';
import 'package:bancodt/constantes/const.dart';


class CategoriaApi {
  static const String baseUrl = crear_categoria;
  // Reemplaza con tu URL de Django

  static Future<void> crearCategoria(Categoria categoria) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(categoria.toJson()),
    );

    if (response.statusCode == 201) {
      print('Categoria creado exitosamente');
    } else {
      print('Error al crear el Categoria: ${response.statusCode}');
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

  static Future<List<Categoria>> obtenerCategoria() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Categoria.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Categoria: ${response.statusCode}');
    }
  }

  static Future<void> actualizarCategoria(
      int id, Categoria categoria) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(categoria.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Error al actualizar el Categoria: ${response.statusCode}');
    }
  }

  static Future<void> eliminarCategoria(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception(
          'Error al eliminar el Categoria: ${response.statusCode}');
    }
  }
}