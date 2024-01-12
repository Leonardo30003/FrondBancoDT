import 'package:flutter/material.dart';

class Rol{
  final int id;
  final String nombre_rol;

  const Rol({
  required this.nombre_rol,
  required this.id
  });
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'nombre_rol':nombre_rol,
    };
  }
  factory Rol.fromJson(Map<String,dynamic>json){
    return Rol(
        id:json['id'],
        nombre_rol:json['nombre_rol']
    );
  }
}