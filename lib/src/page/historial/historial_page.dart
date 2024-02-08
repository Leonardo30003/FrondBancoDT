import 'package:flutter/material.dart';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/src/page/home/MyClipper.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:bancodt/constantes/widgets/widgets_personalizados.dart';

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
      });
    } else {
      print('Error al obtener la lista de usuarios: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Color personalizado
    Color azulUide = Color.fromRGBO(0, 45, 114, 1.0);
    Color primaryTextColor = Colors.black;

    return Scaffold(
      body: Column(
        children: <Widget>[
          //cabecera("Historial"),
          Container(
            padding: EdgeInsets.all(20.0),
            color: azulUide,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  '25 horas',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: primaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              itemCount: transacciones.length,
              itemBuilder: (context, index) {
                final transaccion = transacciones[index];
                return Card(
                  elevation: 1.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: azulUide,
                      child: Icon(Icons.access_time, color: Colors.white), // Ícono de tiempo
                    ),
                    title: Text(
                      'Título: ${transaccion['servicio']['titulo']}',
                      style: TextStyle(color: primaryTextColor),
                    ),
                    subtitle: Text(
                      'Número Horas: ${transaccion['numero_horas']}',
                      style: TextStyle(color: primaryTextColor),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(transaccion['fecha_transaccion'], style: TextStyle(color: primaryTextColor)),
                        Text(transaccion['estadoTransaccion'], style: TextStyle(color: primaryTextColor)),
                      ],
                    ),
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
