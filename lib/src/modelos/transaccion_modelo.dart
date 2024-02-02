
class TransaccionTiempo {
  final int? id ;
  final int? servicio;
  final int? numero_horas;

  final int? numero_minutos;

  final String descripcion;
  //final String demandante;
  final int? demandanteCuenta;

  final String fecha_transaccion;
  final String estadoTransaccion;

  const TransaccionTiempo({
    required this.id,
    required this.servicio,
    required this.numero_horas,
    required this.numero_minutos,
    required this.descripcion,
    //required this.demandante,
    required this.demandanteCuenta,
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
      //'demandante':demandante,
      'demandanteCuenta': demandanteCuenta,
      'fecha_transaccion':fecha_transaccion,
      'estadoTransaccion':estadoTransaccion,

    };
  }
  factory TransaccionTiempo.fromJson(Map<String,dynamic>json){
    return TransaccionTiempo(
      id:json['id'] ,
      servicio:json['servicio'],
      numero_horas:json['numero_horas'],
      numero_minutos:json['numero_minutos'] ,
      descripcion:json['descripcion'] ?? '',
      //demandante:json['demandante'] ?? '',
      demandanteCuenta:json['demandanteCuenta'] ,
      fecha_transaccion:json['fecha_transaccion'] ?? '',
      estadoTransaccion:json['estadoTransaccion'] ?? '',
    );
  }

}