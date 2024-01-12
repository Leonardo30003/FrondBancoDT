import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/colores.dart';

class Fondos {
  static Widget fondoLogin({required BuildContext context}) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colores.COLOR_GRIS_FONDO, Colores.COLOR_GRIS_FONDO, Colores.COLOR_GRIS_FONDO],
                stops: [0.5, 0.5, 0.8],
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter),
          ),
        ),
        SizedBox(
          // color: Colores.COLOR_PRIMARY,
          width: double.infinity,
          //height: screenHeight / 3,
          child:Lottie.asset('assets/images/login.json'),//fondo login
        ),
      ],
    );
  }

  static Widget fondoFormulario(
      {required double screenWidth, required double screenHeigth, required Widget formulario}) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        // color: Colores.GRIS_FONDO_COLOR,
        margin: const EdgeInsets.only(top: 140.0, bottom: 10.0),
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        width: screenWidth,
        height: screenHeigth,
        decoration: const BoxDecoration(
          color: Colores.COLOR_BLANCO,
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 1.0, spreadRadius: 0.0, offset: Offset(0.0, 0.0)),
          ],
        ),
        // child: formularioLogin(),
        child: formulario,
      ),
    );
  }
}
