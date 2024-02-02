import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:bancodt/constantes/const.dart';
import 'package:http/http.dart' as http;

import '../../modelos/transaccion_modelo.dart';


class VerTransaccion extends StatefulWidget {
  const VerTransaccion({super.key});

  @override
  State<VerTransaccion> createState() => _VerTransaccionState();
}

class _VerTransaccionState extends State<VerTransaccion> {

  List<dynamic> transaccion = [];


  Future<void> listaDeTransacciones() async {
    final response = await http.get(Uri.parse(crear_transacciones));
    print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);

      setState(() {
        transaccion = jsonResponse.map((item) => TransaccionTiempo.fromJson(item)).toList();
      });
      print('listadetransacciones');
      print(transaccion);
    } else {
      // Handle errors as needed
      print('Error al obtener la lista de transacciones: ${response.statusCode}');
    }
  }

  final List<Transfer> transfers = [
    Transfer(from: 'devhbcsklmx', to: 'kjcnlkdc', amount: 150.00),
    Transfer(from: 'Ajbdkj', to: 'ijfconkjufhik', amount: 250.50),
    Transfer(from: 'comida', to: 'efgiun', amount: 75.30),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listaDeTransacciones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ultimas Transacciones'),
      ),
      body: ListView.builder(
        itemCount: transaccion.length,
        itemBuilder: (context, index) {
          final trans = transaccion[index] as TransaccionTiempo;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(trans.descripcion),
              subtitle: Text('Número Horas: ${trans.numero_horas}'),

            ),
          );
        },
      ),
    );
  }
}

class Transfer {
  String from;
  String to;
  double amount;

  Transfer({required this.from, required this.to, required this.amount});
}