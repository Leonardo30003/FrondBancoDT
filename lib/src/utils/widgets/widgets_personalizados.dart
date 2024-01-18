import 'package:flutter/material.dart';
import 'package:bancodt/src/page/home/MyClipper.dart';

Widget cabecera(String titulo) {
  final Color azulUide = Color.fromRGBO(0, 45, 114, 1.0);

  return ClipPath(
    clipper: MyClipper(),
    child: Container(
      padding: EdgeInsets.only(top: 20),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            azulUide, // Color personalizado como inicio del gradiente
            azulUide.withOpacity(0.8), // Variante más clara del color personalizado
            azulUide.withOpacity(0.6), // Variante aún más clara para un efecto de gradiente
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
              Text(
                titulo,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // Aquí puedes agregar más contenido si es necesario
        ],
      ),
    ),
  );
}
