import 'package:flutter/material.dart';

class Colores {
  static const COLOR_PRIMARY = Color.fromRGBO(12, 137, 225, 1.0);
  static const COLOR_TRANSPARENT = Color.fromRGBO(1, 1, 1, 0);
  static const COLOR_BLANCO = Color.fromRGBO(255, 255, 255, 1);
  static const COLOR_BLANCO_TRANSPARENT = Color(0x4cffffff);
  static const COLOR_GRIS_FONDO = Color.fromRGBO(247, 248, 250, 1.0);
  static const COLOR_GRIS_TRANSPARENTE = Color.fromRGBO(247, 248, 250, 0.5);
  static const COLOR_GRIS_BORDER = Color.fromRGBO(244, 244, 244, 1.0);
  static const COLOR_GRIS_HINT = Color.fromRGBO(180, 180, 180, 1.0);
  static const COLOR_ICON_GREY = Color.fromRGBO(154, 153, 154, 1.0);
  static const COLOR_SPLASH = Color.fromRGBO(84, 117, 187, 1.0);

  static const COLOR_VERDE_BOTON = Color.fromRGBO(3, 49, 87, 1.0);
  static const COLOR_ROJO_BOTON = Color.fromRGBO(245, 82, 70, 1.0);
  static const COLOR_VERDE_DESABILITADO = Color.fromRGBO(27, 185, 220, 1.0);

  //GRADIENTE
  static const COLOR_GRADIENTE_1 = Color.fromRGBO(64, 72, 74, 1.0);
  static const COLOR_GRADIENTE_2 = Color.fromRGBO(80, 95, 92, 0.5);

  Color obtenerColorCategoriaProximamente(int idServSelected) {
    switch (idServSelected) {
      case 1:
        {
          return COLOR_BLANCO;
        }
        break;
      case 2:
        {
          return COLOR_GRIS_BORDER;
        }
        break;
      default:
        {
          return COLOR_GRIS_BORDER;
        }
        break;
    }
  }
}
