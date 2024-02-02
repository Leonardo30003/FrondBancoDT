import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bancodt/src/modelos/mensaje_modelo.dart'; // Asegúrate de importar tu modelo de mensaje de chat
import 'package:bancodt/constantes/const.dart';

class ChatApi {
  static const String baseUrl = canal_mensajes; // Reemplaza con la URL de tu API de chat

  static Future<void> enviarMensaje(ChatMessage mensaje) async {
    final response = await http.post(
      Uri.parse('$baseUrl/mensajes'), // Ajusta la URL para crear mensajes
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mensaje.toJson()),
    );

    if (response.statusCode == 201) {
      print('Mensaje enviado exitosamente');
    } else {
      print('Error al enviar el mensaje: ${response.statusCode}');
    }
  }

  static Future<List<ChatMessage>> obtenerMensajes() async {
    final response = await http.get(Uri.parse('$baseUrl/mensajes'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => ChatMessage.fromJson(e)).toList();
    } else {
      throw Exception('Error al obtener mensajes: ${response.statusCode}');
    }
  }

  static Future<void> actualizarMensaje(String id, ChatMessage mensaje) async {
    final response = await http.put(
      Uri.parse('$baseUrl/mensajes/$id'), // Ajusta la URL para actualizar mensajes
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(mensaje.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el mensaje: ${response.statusCode}');
    }
  }

  static Future<void> eliminarMensaje(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/mensajes/$id')); // Ajusta la URL para eliminar mensajes

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar el mensaje: ${response.statusCode}');
    }
  }
}