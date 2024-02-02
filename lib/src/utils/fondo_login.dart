import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bancodt/constantes/colores.dart'; // Importing your custom colors

class Fondos {
  static Widget fondoLogin({required BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration( // Removed const from BoxDecoration
            gradient: LinearGradient(
              colors: [fondoGris, fondoGris, fondoGris], // Your custom gray color
              stops: [0.5, 0.5, 0.8],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Lottie.asset('assets/images/login.json'), // Your login animation
        ),
      ],
    );
  }

  static Widget fondoFormulario({
    required double screenWidth,
    required double screenHeight,
    required Widget formulario}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(top: 140.0, bottom: 10.0),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration( // Removed const from BoxDecoration
          color: blancoFondo, // Your custom white color
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 1.0, spreadRadius: 0.0, offset: Offset(0.0, 0.0)),
          ],
        ),
        child: formulario, // The form widget passed as a parameter
      ),
    );
  }
}
