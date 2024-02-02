// api.dart en tu aplicación Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/servicio_modelo.dart';
import 'package:bancodt/constantes/const.dart';

class ServicioApi {
  static const String baseUrl = crear_servicio;
  static const String buscar = buscar_servicio;
  // Reemplaza con tu URL de Django

  static Future<void> crearServicio(Servicio servicio) async {
    print(servicio.ROL_CHOICES);
    print(servicio.propietario);
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(servicio.toJson()),
    );
    print(response.body);

    if (response.statusCode == 201) {
      print('Cuenta creado exitosamente');
    } else {
      print('Error al crear el Servicio: ${response.statusCode}');
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

  static Future<List<Servicio>> c() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Servicio.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener Cuenta: ${response.statusCode}');
    }
  }

  static Future<void> actualizarServicio(int id, Servicio usuario) async {
    final response = await http.put(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el Cuenta: ${response.statusCode}');
    }
  }

  static Future<void> eliminarServicio(int id) async {
    final response = await http.delete(Uri.parse(baseUrl));

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el Cuenta: ${response.statusCode}');
    }
  }

  /* documento agregado el 25-01-2024 */

  /* static Future<List<dynamic>> obtenerServiciosPorCuentaYTipo(
      String cuenta, String tipo) async {
    final url = Uri.parse('$buscar/?cuenta=$cuenta&tipo=$tipo');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> servicios = jsonDecode(response.body);
        return servicios;
      } else {
        // Manejar errores según sea necesario
        print('Error al obtener servicios: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error en la conexión: $e');
      return [];
    }
  } */

  // ------ otro metodo para verificar si hay un servicio disponible ------
  static Future<List<dynamic>> obtenerServiciosByRolChoice(
      String rolChoice) async {
    try {
      List<dynamic> servicios = await obtenerServiciosPorCuentaYTipo(
          '1'); // Supongo que tienes un método para obtener todos los servicios
      print('servicios: $servicios');
      // Filtrar servicios según el ROL_CHOICES
      List<dynamic> serviciosFiltrados = servicios
          .where((servicio) => servicio['ROL_CHOICES'] == rolChoice)
          .toList();

      return serviciosFiltrados;
    } catch (error) {
      print('Error al obtener servicios por ROL_CHOICES: $error');
      throw error;
    }
  }

  static Future<List<dynamic>> obtenerServiciosPorCuentaYTipo(
      String cuenta) async {
    final url = Uri.parse('$buscar/?cuenta=$cuenta');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> servicios = jsonDecode(response.body);
        return servicios;
      } else {
        // Manejar errores según sea necesario
        print('Error al obtener servicios: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error en la conexión: $e');
      return [];
    }
  }

  // otra prueba de metodo para verificar si hay un servicio disponible
  static Future<List<dynamic>> obtenerServiciosCuentaTipo({
    required String cuenta,
    required String rolChoices,
  }) async {
    final url = Uri.parse('$buscar/?cuenta=$cuenta&rolChoices=$rolChoices');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> servicios = jsonDecode(response.body);
        return servicios;
      } else {
        // Manejar errores según sea necesario
        print('Error al obtener servicios: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Manejar errores de red u otros
      print('Error en la conexión: $e');
      return [];
    }
  }
}