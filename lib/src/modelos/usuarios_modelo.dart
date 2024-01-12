import 'package:flutter/material.dart';

class Usuario {

  final String first_name;
  final String last_name;
  final String username;
  final String password;
  final String confirm_password;
  final String genero;
  final String documento_identificacion;
  final String email;
  final String telefono;
  final String direccion;
  final bool is_staff;
  final bool is_active;

  const Usuario({
    required this.first_name,
    required this.last_name,
    required this.username,
    required this.password,
    required this.confirm_password,
    required this.genero,
    required this.documento_identificacion,
    required this.email,
    required this.telefono,
    required this.direccion,
    required this.is_staff,
    required this.is_active,
  });

  Map<String, dynamic> toJson() {
    return {
      'first_name': first_name,
      'last_name': last_name,
      'username': username,
      'password': password,
      'confirm_password':confirm_password,
      'genero': genero,
      'documento_identificacion': documento_identificacion,
      'email': email,
      'telefono': telefono,
      'direccion': direccion,
      'is_staff': is_staff,
      'is_active':is_active,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic>json){
    return Usuario(
        first_name: json['first_name'],
        last_name: json['last_name'],
        username: json['username'],
        password: json['password'],
        confirm_password:json['confirm_password'],
        genero: json['genero'],
        documento_identificacion: json['documento_identificacion'],
        email: json['email'],
        telefono: json['telefono'],
        direccion: json['direccion'],
        is_staff:json['is_staff'],
        is_active:json['is_active'],
        );
    }
}
