import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/constantes/colores.dart';
import 'package:bancodt/constantes/widgets/widgets_personalizados.dart';
import 'package:xen_popup_card/xen_popup_card.dart';
import 'package:bancodt/src/page/chat/chat.dart';

class PruebaChat extends StatefulWidget {
  const PruebaChat({super.key});

  @override
  State<PruebaChat> createState() => _PruebaChatState();
}

class _PruebaChatState extends State<PruebaChat> {
  List<dynamic> mensajes = [];

  @override
  void initState() {
    super.initState();
    listaDeMensajes();
  }

  Future<void> listaDeMensajes() async {
    final response = await http.get(Uri.parse(canal_mensajes));

    if (response.statusCode == 200) {
      setState(() {
        mensajes = jsonDecode(response.body);
      });
    } else {
      print('Error al obtener la lista de mensajes: ${response.statusCode}');
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
          cabecera("Historial"),
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
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              itemCount: mensajes.length,
              itemBuilder: (context, index) {
                final mensaje = mensajes[index];
                return Card(
                  elevation: 1.0,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: azulUide,
                      child: Icon(Icons.access_time,
                          color: Colors.white), // Ícono de tiempo
                    ),

                    title: Text(
                      'usuario: ${mensaje['usuario']}',
                      style: TextStyle(color: primaryTextColor),
                    ),
                    subtitle: Text(
                      'texto: ${mensaje['texto']}',
                      style: TextStyle(color: primaryTextColor),
                    ),
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            content: ChatPage(),
                          );
                        }
                      );
                    },
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