import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:flutter/material.dart';

class Cuenta {
  final int? id;
  final int? usuario;
  final String fecha_creacion;
  final String fecha_actualizacion;
  final int? numero_horas;

  const Cuenta({
    this.id,
    required this.usuario,
    required this.fecha_creacion,
    required this.fecha_actualizacion,
    required this.numero_horas,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'usuario': usuario, // Convertir el objeto Usuario a JSON
      'fecha_creacion': fecha_creacion,
      'fecha_actualizacion': fecha_actualizacion,
      'numero_horas': numero_horas,
    };
  }

  /* factory Cuenta.fromJson(Map<String, dynamic> json) {
    return Cuenta(
      id: json['id'],
      usuario: json['usuario'], // Cambiar 'id_usuario' a 'usuario'
      fecha_creacion: json['fecha_creacion'],
      fecha_actualizacion: json['fecha_actualizacion'],
      numero_horas: json['numero_horas'],
    );
  } */

  factory Cuenta.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      return Cuenta(
        id: json['id'],
        usuario: json['usuario'], // Cambiar 'id_usuario' a 'usuario'
        fecha_creacion: json['fecha_creacion'] ?? '',
        fecha_actualizacion: json['fecha_actualizacion'] ?? '',
        numero_horas: json['numero_horas'],
      );
    } else {
      // Manejar el caso en el que los datos son una lista o cualquier otro formato
      throw FormatException('Formato de datos incorrecto para la cuenta');
    }
  }
}
