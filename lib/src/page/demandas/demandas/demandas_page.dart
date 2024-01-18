import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/src/utils/widgets/widgets_personalizados.dart'; // Asegúrate de que esta ruta sea correcta

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
                    final servicio = servicios[index];
                    return GestureDetector(
                      onTap: () {
                        _showDetailsDialog(context, servicio['titulo'], servicio['descripcion'], servicio);
                      },
                      child: DemandCard(
                        title: servicio['titulo'],
                        descripcion: servicio['descripcion'],
                        costo: servicio['costo'],
                        imgUrl: 'assets/images/google.png', // Asegúrate de que esta imagen exista en tus assets
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
    print('muestra dialogo para $title');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(descripcion),
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
              },
            ),
          ],
        );
      },
    );
  }
}

class DemandCard extends StatelessWidget {
  final String? title;
  final String? descripcion;
  final int? costo;
  final String? imgUrl;

  const DemandCard({
    this.title,
    this.descripcion,
    this.costo,
    this.imgUrl,
  });

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
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          imgUrl != null
              ? Image.network(
            imgUrl!,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )
              : Container(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title ?? 'Titulo no disponible',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    descripcion ?? 'Descripcion no disponible',
                    style: TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: costo != null
                        ? List.generate(
                      costo!,
                          (index) => Icon(
                        Icons.timelapse,
                        color: Colors.amber,
                        size: 20,
                      ),
                    )
                        : [Text('Costo no disponible')],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
