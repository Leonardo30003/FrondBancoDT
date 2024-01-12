import 'package:bancodt/src/page/home/MyClipper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bancodt/src/page/demandas/demandas/LeerDemanda.dart';


class DemandasHome extends StatefulWidget {
  @override
  _DemandasHome createState() => _DemandasHome();
}

class _DemandasHome extends State<DemandasHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(top: 40),
                height: 380,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Banco del Tiempo - Demandas",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    // Puedes agregar aquí el contenido específico para la sección de demandas
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
                        "Últimas Demandas",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      Icon(
                        Icons.sort,
                        color: Colors.grey,
                        size: 25,
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  // Aquí se listan las tarjetas de demandas
                  DemandCard(
                    key: UniqueKey(),
                    title: "Demanda 1",
                    descripcion: "Descripción de la demanda 1",
                    imgUrl: 'assets/images/image1.png',
                  ),
                  DemandCard(
                    key: UniqueKey(),
                    title: "Demanda 2",
                    descripcion: "Descripción de la demanda 2",
                    imgUrl: 'assets/images/image2.png',
                  ),
                  // Agrega más DemandCard según sea necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DemandCard extends StatelessWidget {
  final String title;
  final String descripcion;
  final String imgUrl;
  const DemandCard({
    required Key key,
    required this.title,
    required this.descripcion,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LeerDemanda(); // Asegúrate de tener esta página definida
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  descripcion,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                // Agrega cualquier otro detalle que necesites aquí
              ],
            ),
            Image.asset(
              imgUrl,
              width: 160,
              fit: BoxFit.fitWidth,
            ),
          ],
        ),
      ),
    );
  }
}
