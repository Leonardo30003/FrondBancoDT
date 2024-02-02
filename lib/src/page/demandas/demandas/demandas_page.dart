import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/constantes/widgets/widgets_personalizados.dart';
import 'package:bancodt/src/modelos/servicio_modelo.dart';
import 'package:bancodt/src/page/chat/chat.dart';


class DemandasHome extends StatefulWidget {
  const DemandasHome({super.key});

  @override
  _DemandasHome createState() => _DemandasHome();
}

class _DemandasHome extends State<DemandasHome> {
  List<dynamic> servicios = [];

  Future<void> listaDeServicios() async {
    final response = await http.get(Uri.parse(crear_servicio));

    if (response.statusCode == 200) {
      setState(() {
        servicios = jsonDecode(response.body);
      });
      print(servicios);
    } else {
      print('Error al obtener la lista de servicios: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    listaDeServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          cabecera("Banco del Tiempo - Demandas"), // Utiliza el widget 'cabecera' personalizado
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Últimas Demandas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                servicios.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: servicios.length,
                  itemBuilder: (context, index) {
                    final servicioMap = servicios[index];
                    final servicio = Servicio.fromJson(servicioMap);
                    return GestureDetector(
                      onTap: () => _showDetailsDialog(context, servicio.titulo,
                          servicio.descripcion_actividad, servicio),
                      child: DemandCard(
                        servicio: servicio,
                      ),
                    );
                  },
                )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDetailsDialog(BuildContext context, String title, String descripcion, dynamic servicio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(descripcion),
                Text('Fecha de Creacion: ${servicio.fecha_creacion}'),
                Text('Fecha vigente: ${servicio.fecha_vigente}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              child: Text('Aplicar'),
              onPressed: () {
                // Acción del botón
                Navigator.of(context).pop();
                showDialog(context: context, builder: (BuildContext context){
                  return AlertDialog(
                    content: ChatPage(),
                  );
                },
                );
              },
            ),
          ],
        );
      },
    );
  }
}

class DemandCard extends StatelessWidget {

  final Servicio servicio;

  const DemandCard({Key? key, required this.servicio}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Aquí puedes agregar la imagen si tu servicio tiene una URL de imagen
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    servicio.titulo,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    servicio.descripcion_actividad,
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  // Aquí puedes agregar más detalles del servicio si es necesario
                ],
              ),
            ),
          ),
          // Otros elementos que desees agregar, como botones o iconos
        ],
      ),
    );
  }
}