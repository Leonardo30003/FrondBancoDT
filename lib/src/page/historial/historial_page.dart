import 'package:flutter/material.dart';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/api/api_transaccion.dart';
import 'package:http/http.dart';
import 'package:async/async.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(HistorialPage());


class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<dynamic> transacciones = [];

  @override
  void initState() {
    super.initState();
    listaDeTransacciones();
  }

  Future<void> listaDeTransacciones() async {
    final response = await http.get(Uri.parse(crear_transacciones));

    if (response.statusCode == 200) {
      setState(() {
        transacciones = jsonDecode(response.body);
        //
      });

    } else {
      // Manejar errores según sea necesario
      print('Error al obtener la lista de usuarios: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Historial de transacciones'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.lightBlue, // Use the appropriate purple shade
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Budget Name',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  '\$25,000',
                  style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Per Month',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  '4 Days Left',
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 50.0,horizontal: 10.0),
              itemCount: transacciones.length, // Use the number of transactions you have
              itemBuilder: (context, index) {
                final transaccion = transacciones[index];
                return ListTile(
                  leading: CircleAvatar(
                    maxRadius: 100.0,
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text("T",
                    style: TextStyle(fontSize: 8.0,fontWeight: FontWeight.bold,),
                    ),
                  ),
                  title: Text('Titulo: '+transaccion['servicio']['titulo'].toString()),
                  subtitle: Text('Numero Horas: '+transaccion['numero_horas'].toString()),
                  trailing: Column(

                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(transaccion['fecha_transaccion']),
                      Text(transaccion['estadoTransaccion']),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



