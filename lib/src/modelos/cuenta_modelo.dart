import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:flutter/material.dart';

class Cuenta{
  final int id;
  final Usuario usuario;
  final DateTime fecha_creacion;
  final DateTime fecha_actualizacion;
  final Image imagen;
  final int numero_horas;
  const Cuenta({
  required this.id,
  required this.usuario,
  required this.fecha_creacion,
  required this.fecha_actualizacion,
  required this.imagen,
  required this.numero_horas,
  });
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'usuario':usuario,
      'fecha_creacion':fecha_creacion,
      'fecha_actualizacion':fecha_actualizacion,
      'imagen':imagen,
      'numero_horas':numero_horas,
    };
  }
  factory Cuenta.fromJson(Map<String,dynamic>json){
    return Cuenta(
        id:json['id'],
        usuario:json['usuario'],
        fecha_creacion:json['fecha_creacion'],
        fecha_actualizacion:json['fecha_actualizacion'],
        imagen:json['imagen'],
        numero_horas:json['numero_horas']
    );
  }
}