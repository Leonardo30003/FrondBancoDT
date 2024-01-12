import 'package:bancodt/src/modelos/categoria_modelo.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';

class Interes{
  final int id;
  final Usuario usuario;
  final Categoria categoria;

  const Interes({
    required this.id,
    required this.usuario,
    required this.categoria
});
  Map<String,dynamic>toJson(){
    return{
      'id':id,
      'usuario':usuario,
      'categoria':categoria
    };
  }
  factory Interes.fromJson(Map<String,dynamic>json){
    return Interes(
        id:json['id'],
        usuario:json['usuario'],
        categoria:json['categoria']
    );
  }
}