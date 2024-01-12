
import 'package:bancodt/src/modelos/transaccion_modelo.dart';

class Calificacion {
  final int id;
  final int puntuacion;
  final String comentarios;
  final TransaccionTiempo transaccioncalificacion;

  const Calificacion({
    required this.id,
    required this.puntuacion,
    required this.comentarios,
    required this.transaccioncalificacion,
  });
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'puntuacion':puntuacion,
      'comentarios':comentarios,
      'password':transaccioncalificacion,
    };
  }
  factory Calificacion.fromJson(Map<String,dynamic>json){
    return Calificacion(
        id:json['id'],
        puntuacion:json['puntuacion'],
        comentarios:json['comentarios'],
        transaccioncalificacion:json['transaccioncalificacion']
    );
  }

}