
import 'package:bancodt/src/modelos/usuarios_modelo.dart';

class Servicio {
  final String ROL_CHOICES;
  final String titulo;
  final String descripcion_actividad;

  final int tiempo_requerido;
  final String fecha_creacion;
  final String fecha_vigente;
  final int propietario;

  final String estadoVigencia;
  final String estadoServicio;


  const Servicio({
    required this.ROL_CHOICES,
    required this.titulo,
    required this.descripcion_actividad,
    required this.tiempo_requerido,
    required this.fecha_creacion,
    required this.fecha_vigente,
    required this.propietario,
    required this.estadoVigencia,
    required this.estadoServicio,
  });
  Map<String,dynamic>toJson(){
    return{
      'ROL_CHOICES':ROL_CHOICES,
      'titulo':titulo,
      'descripcion_actividad':descripcion_actividad,
      'tiempo_requerido':tiempo_requerido,
      'fecha_creacion':fecha_creacion,
      'fecha_vigente':fecha_vigente,
      'propietario':propietario,
      'estadoVigencia':estadoVigencia,
      'estadoServicio':estadoServicio,
    };
  }
  factory Servicio.fromJson(Map<String,dynamic>json){
    return Servicio(
        ROL_CHOICES:json['ROL_CHOICES'],
        titulo:json['titulo'],
        descripcion_actividad:json['descripcion_actividad'],
        tiempo_requerido:json['tiempo_requerido'],
        fecha_creacion:json['fecha_creacion'],
        fecha_vigente:json['fecha_vigente'],
        propietario:json['propietario'],
        estadoVigencia:json['estadoVigencia'],
        estadoServicio:json['estadoServicio']
    );
  }
}