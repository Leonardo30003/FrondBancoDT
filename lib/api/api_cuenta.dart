// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/cuenta_modelo.dart';
import 'package:bancodt/constantes/const.dart';

class CuentaApi {
  static const String baseUrl = crear_cuenta;
  static const String buscarCuentaUser = burcar_cuenta_usuario;
  // Reemplaza con tu URL de Django

  static Future<void> crearCuenta(Cuenta cuenta) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cuenta.toJson()),
    );
    print(response.body);

    if (response.statusCode == 201) {
      print('Cuenta creado exitosamente');
    } else {
      print('Error al crear el Cuenta: ${response.statusCode}');
    }
  }

  static Future<List<Cuenta>> obtenerCuenta() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Cuenta.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Cuenta: ${response.statusCode}');
    }
  }

  static Future<void> actualizarCuenta(int id, Cuenta cuenta) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(cuenta.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el Cuenta: ${response.statusCode}');
    }
  }

  static Future<void> eliminarCuenta(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el Cuenta: ${response.statusCode}');
    }
  }

  // vamos a obtener la cuenta por el usuario autentificado
  /* required String cuenta,
    required String rolChoices,
  }) async {
    final url = Uri.parse('$buscar/?cuenta=$cuenta&rolChoices=$rolChoices'); */

  /* static Future<Cuenta> obtenerCuentaPorId(String usuario) async {
    final response =
        await http.get(Uri.parse('$buscarCuentaUser/?usuario=$usuario'));
    print('Respuesta del servidor: ${response.body}');

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Cuenta.fromJson(data);
    } else {
      throw Exception('Error al obtener Cuenta por ID: ${response.statusCode}');
    }
  } */

  static Future<Cuenta> obtenerCuentaPorId(String usuario) async {
    final response =
        await http.get(Uri.parse('$buscarCuentaUser/?usuario=$usuario'));

    if (response.statusCode == 200) {
      print('Respuesta del servidor: ${response.body}');
      final Map<String, dynamic> data = jsonDecode(response.body);
      return Cuenta.fromJson(data);
    } else {
      throw Exception('Error al obtener Cuenta por ID: ${response.statusCode}');
    }
  }
}
