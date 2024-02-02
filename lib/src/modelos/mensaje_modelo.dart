import'package:bancodt/src/modelos/mensaje_modelo.dart';

class ChatMessage {
  final String id;// Puedes utilizar un identificador único
  final String tiempo;
  final String texto; // El remitente del mensaje
  final String usuario; // Fecha y hora del mensaje

  ChatMessage({
    required this.id,
    required this.tiempo,
    required this.texto,
    required this.usuario,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'].toString(), // Asegúrate de que esto se convierte correctamente a String.
      tiempo: json['tiempo'] ?? '',
      texto: json['texto'] ?? '',
      usuario: json['usuario'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tiempo': tiempo,
      'texto': texto,
      'usuario': usuario,
    };
  }
}
