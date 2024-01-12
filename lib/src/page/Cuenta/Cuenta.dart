import 'package:bancodt/src/page/Cuenta/numbers_witget.dart';
import 'constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bancodt/src/utils/colores.dart';
import 'package:bancodt/src/utils/fondo_login.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'dart:convert';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CuentaScreen(),
    );
  }
}

class CuentaScreen extends StatefulWidget {
  const CuentaScreen({super.key});

  @override
  State<CuentaScreen> createState() => _CuentaScreenState();
}

class _CuentaScreenState extends State<CuentaScreen> {

  final double coverHeight = 280;
  final double profileHeight = 144;

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = FOOD_DATA;
    List<Widget> listItems = [];
    responseList.forEach((post) {
      listItems.add(Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.white, boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
          ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      post["name"],
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      post["brand"],
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "\$ ${post["price"]}",
                      style: const TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/${post["image"]}",
                  height: double.infinity,
                )
              ],
            ),
          )));
    });
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }


  // @override
  // void initState() {
  //   super.initState();
  //   getPostsData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          //padding: EdgeInsets.zero,
          children: <Widget>[
            buildTop(),
            buildContent(),
            Expanded(
                child: ListView.builder(
                    controller: controller,
                    itemCount: itemsData.length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      double scale = 1.0;
                      if (topContainer > 0.5) {
                        scale = index + 0.5 - topContainer;
                        if (scale < 0) {
                          scale = 0;
                        } else if (scale > 1) {
                          scale = 1;
                        }
                      }
                      return Opacity(
                        opacity: scale,
                        child: Transform(
                          transform:  Matrix4.identity()..scale(scale,scale),
                          alignment: Alignment.bottomCenter,
                          child: Align(
                              heightFactor: 0.7,
                              alignment: Alignment.topCenter,
                              child: itemsData[index]),
                        ),
                      );
                    })),

          ],
        ),
      )



    );
  }


// class CuentaScreen extends StatelessWidget {
//   final double coverHeight = 280;
//   final double profileHeight = 144;
//
//   @override
//   void initState(){
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         //padding: EdgeInsets.zero,
//         children: <Widget>[
//           buildTop(),
//           buildContent(),
//
//         ],
//       ),
//     );
//   }

  Widget buildTop() {
    final bottom = profileHeight; // Aumenté el valor de bottom

    final top = coverHeight - profileHeight / 2;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }


  Widget buildContent() =>
      Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Santiago Japon',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Estudiante de TICS',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildSocialIcon(FontAwesomeIcons.instagram),
              buildSocialIcon(FontAwesomeIcons.whatsapp),
              buildSocialIcon(FontAwesomeIcons.twitter),
            ],
          ),
          const SizedBox(height: 16),
          Divider(),
          const SizedBox(height: 16),
          const SizedBox(height: 32),
          NumberWitget(),


        ],

      );

  Widget buildCoverImage() =>
      Container(
        color: Colors.grey,
        child: Image.network(
          'https://cdn.pixabay.com/photo/2023/11/21/07/02/girl-8402582_1280.jpg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() =>
      CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: NetworkImage(
          'https://cdn.pixabay.com/photo/2023/11/07/10/06/girl-8371776_1280.png',
        ),
      );

  Widget buildSocialIcon(IconData icon) =>
      CircleAvatar(
        radius: 25,
        child: Center(child: Icon(icon, size: 32)),
      );

}

 //container
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Banco del Tiempo'),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: SingleChildScrollView(
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             // Foto de perfil
  //             Center(
  //                 child: WidgetCircularAnimator(
  //                   child: Container(
  //                     decoration: BoxDecoration(
  //                         shape: BoxShape.circle, color: Colors.grey[200]),
  //                     child: Icon(
  //                       Icons.person_outline,
  //                       color: Colors.deepOrange[200],
  //                       size: 60,
  //                     ),
  //                   ),
  //                 )),
  //
  //             // Información personal
  //             Text(
  //               'Nombre: Santiago',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             Text(
  //               'Apellido: Japon',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             Text(
  //               'Carrera: Arquitectura',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             Text(
  //               'Ciclo: 4',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             SizedBox(height: 16),
  //
  //             // Estadísticas
  //             Text(
  //               'Horas obtenidas: 100',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             Text(
  //               'Ofertas realizadas: 10',
  //               style: TextStyle(fontSize: 18),
  //             ),
  //             SizedBox(height: 16),
  //
  //             // Descripción
  //             Container(
  //               padding: EdgeInsets.all(16),
  //               decoration: BoxDecoration(
  //                 border: Border.all(color: Colors.grey),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               child: Text(
  //                 'Estudiante de arquitectura apasionado por el diseño y la planificación de espacios. Busco oportunidades para aplicar mis habilidades en proyectos emocionantes.',
  //                 style: TextStyle(fontSize: 18),
  //                 textAlign: TextAlign.center,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }



