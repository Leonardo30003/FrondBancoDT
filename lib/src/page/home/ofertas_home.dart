import 'package:bancodt/src/page/chat/prueba_chat.dart';
import 'package:bancodt/src/page/home/MyClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/src/modelos/servicio_modelo.dart';
import 'package:bancodt/src/page/chat/chat.dart';
import 'package:shared_preferences/shared_preferences.dart';


class OfertasHome extends StatefulWidget {
  const OfertasHome({super.key});

  @override
  _OfertasHome createState() => _OfertasHome();
}

class _OfertasHome extends State<OfertasHome> {
  List<dynamic> servicios = [];


  Future<void> listaDeServicios() async {
    final response = await http.get(Uri.parse(crear_servicio));

    if (response.statusCode == 200) {
      setState(() {
        servicios = jsonDecode(response.body);
        //
      });
      print(servicios);
    } else {
      // Manejar errores según sea necesario
      print('Error al obtener la lista de servicios: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listaDeServicios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              padding: EdgeInsets.only(top: 20),
              height: 270,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color(0xFF0F2027),
                    Color(0xFF203A43),
                    Color(0xFF2C5364),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Text(
                      //   "Banco del Tiempo",
                      //   style: TextStyle(
                      //     color: Colors.white,
                      //     fontSize: 30,
                      //   ),
                      // ),

                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    margin: EdgeInsets.symmetric(
                        vertical: 9.0, horizontal: 9.0),
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF080808),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Row(
                      children: <Widget>[
                        //DESDE AQUI SE MUESTRA LA PARTE DE ARRIBA DONDE SE VISUALIZA LA MAJOR PUNTUADA
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Cindy Nero",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "Es el/la mejor puntuada",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              "Felicidades",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 400),
                        Image.asset(
                          'assets/images/linkedin.png',
                          fit: BoxFit.fitHeight,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Ultimas Ofertas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
                servicios.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  itemCount: servicios.length,
                  itemBuilder: (context, index){
                    final servicioMap = servicios[index];
                    final servicio = Servicio.fromJson(servicioMap);
                    return GestureDetector(
                      onTap: () => _showDetailsDialog(context, servicio.titulo,
                          servicio.descripcion_actividad, servicio),
                      child: BookCard(
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
                Text('Fecha vigente:  ${servicio.fecha_vigente}'),
                Text('Cuenta:${servicio.propietario}'),
                Text('Horas:${servicio.tiempo_requerido}')
                // Más detalles aquí
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
                //Este metodo permite pasar los datos entre paginas
                void guardarDatosEnSharedPreferences() async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  Map<String, dynamic> datos = {
                    'servicio':servicio.id,
                    'horas':servicio.tiempo_requerido,
                    'propietario':servicio.propietario
                  };
                  prefs.setString('datos', json.encode(datos));
                }
                guardarDatosEnSharedPreferences();
                print(context);
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

class BookCard extends StatelessWidget {
  final Servicio servicio;

  const BookCard({Key? key, required this.servicio}) : super(key: key);  // final String? title;
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
            color: Colors.blueAccent.withOpacity(0.5),
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