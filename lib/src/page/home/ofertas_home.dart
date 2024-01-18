import 'dart:html';
import 'dart:math';

import 'package:bancodt/src/page/home/MyClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bancodt/constantes/const.dart';

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
                        color: Colors.grey,
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
                    final servicio = servicios[index];
                    final titulo = servicio['titulo'] as String?;
                    final descripcion = servicio['descripcion'] as String?;
                    return GestureDetector(
                      onTap: () => _showDetailsDialog(context, titulo!, descripcion!, servicio),
                      child: BookCard(
                        title: servicio['titulo'] ?? 'No hay titulo',
                        descripcion: servicio['descripcion'] ?? 'No hay descripcion',
                        costo: servicio['costo'],
                        imgUrl: 'assets/images/google.png',
                      ),
                    );
                  },
                )
                    : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),

          // ListView(
          //   children: [
          //     Expanded(
          //       child:ListView.builder(
          //           itemCount: servicios.length,
          //           itemBuilder: (context, index) {
          //             final servicio = servicios[index];
          //             return  ListTile(
          //               title: Text(servicio['ROL_CHOICES']),
          //               subtitle: Text(servicio['titulo']),
          //             );
          //           }
          //       ),
          //     ),
          //   ],
          // ),
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
                // Acción del botón
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text(title),
    //       content: SingleChildScrollView(
    //         child: ListBody(
    //           children: <Widget>[
    //             Text(descripcion),
    //             Text('Detalle adicional: ${servicio['detalleAdicional']}'),
    //             // Más detalles aquí
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         TextButton(
    //           child: Text('Cerrar'),
    //           onPressed: () => Navigator.of(context).pop(),
    //         ),
    //         ElevatedButton(
    //           child: Text('Aplicar'),
    //           onPressed: () {
    //             // Acción del botón
    //             Navigator.of(context).pop();
    //           },
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}

class BookCard extends StatelessWidget {
  final String? title;
  final String? descripcion;
  final int? costo;
  final String? imgUrl;

  const BookCard({
    this.title,
    this.descripcion,
    this.costo,
    this.imgUrl,
    // required this.title,
    // required this.descripcion,
    // required this.costo,
    // required this.imgUrl,
  });
  @override
  Widget build(BuildContext context){
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
            imgUrl !,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ) : Container(),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  title != null? Text(descripcion!) : Container(),
                ],
              ),
            ),
          ),

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
                        :[Text('Costo no disponible')],
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

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) {
//           return LeerOferta();
//         }));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 5.0),
//         padding: EdgeInsets.symmetric(horizontal: 5.0),
//         height: 170,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey,
//               blurRadius: 8,
//             ),
//           ],
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   descripcion,
//                   style: TextStyle(
//                     fontSize: 15,
//                   ),
//                 ),
//                 Row(
//                   children: <Widget>[
//                     for (int i = 0; i < costo; i++)
//                       Text(
//                         '${i + 1}', // Puedes ajustar la lógica según tus necesidades
//                         style: TextStyle(
//                           color: Colors.amber,
//                           fontSize: 18.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//             Image.asset(
//               imgUrl,
//               width: 160,
//               fit: BoxFit.fitWidth,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }