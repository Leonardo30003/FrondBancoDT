
import 'dart:js_interop';

import 'package:bancodt/src/modelos/servicio_modelo.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';

class TransaccionTiempo {
  final int id;
  final Servicio servicio;
  final int numero_horas;

  final int numero_minutos;

  final String descripcion;
  final Usuario demandante;

  final DateTime fecha_transaccion;
  final String estadoTransaccion;

  const TransaccionTiempo({
    required this.id,
    required this.servicio,
    required this.numero_horas,
    required this.numero_minutos,
    required this.descripcion,
    required this.demandante,
    required this.fecha_transaccion,
    required this.estadoTransaccion,

  });
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'servicio':servicio,
      'numero_horas':numero_horas,
      'numero_minutos':numero_minutos,
      'descripcion':descripcion,
      'demandante':demandante,
      'fecha_transaccion':fecha_transaccion,
      'estadoTransaccion':estadoTransaccion,

    };
  }
  factory TransaccionTiempo.fromJson(Map<String,dynamic>json){
    return TransaccionTiempo(
        id:json['id'],
        servicio:json['servicio'],
        numero_horas:json['numero_horas'],
        numero_minutos:json['numero_minutos'],
        descripcion:json['descripcion'],
        demandante:json['demandante'],
        fecha_transaccion:json['fecha_transaccion'],
        estadoTransaccion:json['estadoTransaccion']
    );
  }

}