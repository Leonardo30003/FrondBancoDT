import 'package:auto_size_text/auto_size_text.dart';
// import 'package:bancodetiempo/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bancodt/src/utils/colores.dart';
// import '../models/demanda_model.dart';
// import '../models/miembro_model.dart';
// import '../models/oferta_model.dart';
// import '../models/usuarioaplicado_model.dart';
// import '../utils/colores.dart';
// import '../utils/variables_globales.dart';

class WidgetsPersonalizados {
  static final styleText =
      TextStyle(fontFamily: "Helvetica", fontSize: 20, color: Colores.COLOR_PRIMARY, fontWeight: FontWeight.bold);

  static final styleTextButton = TextStyle(fontFamily: "Helvetica", fontSize: 20, fontWeight: FontWeight.normal);

  static final styleTextNormal = TextStyle(fontFamily: "Helvetica", fontWeight: FontWeight.bold);

  static Widget backButtonFlotante(
      {required VoidCallback callback,
      required double sizeButton,
      required Color colorIcon,
      required Color colorButton}) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
        width: sizeButton,
        height: sizeButton,
        margin: EdgeInsets.only(top: 20.0, left: 10.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: colorButton,
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: colorIcon,
          ),
        ),
      ),
    );
  }

  static AppBar appBarSearching(
      {required VoidCallback cancelSearch,
      required VoidCallback searching,
      required TextEditingController searchController}) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colores.COLOR_BLANCO,
      // brightness: Brightness.light,
      leading: IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            cancelSearch();
          }),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: TextField(
          controller: searchController,
          onEditingComplete: () {
            // searching();
          },
          style: const TextStyle(color: Colores.COLOR_PRIMARY, fontSize: 20),
          cursorColor: Colores.COLOR_PRIMARY,
          autofocus: true,
          decoration: const InputDecoration(
            focusColor: Colores.COLOR_PRIMARY,
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colores.COLOR_PRIMARY)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colores.COLOR_PRIMARY)),
          ),
        ),
      ),
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              searching();
            }),
        Container(
          width: 20.0,
        )
      ],
    );
  }

  static AppBar appBarNormalOption({
    required String title,
    required double elevation,
    required bool mostrarBackButton,
    required List<Widget> optionsList,
    required VoidCallback callBackButton,
  }) {
    return AppBar(
        title: AutoSizeText(title, style: WidgetsPersonalizados.styleText),
        centerTitle: true,
        elevation: elevation,
        backgroundColor: Colores.COLOR_BLANCO,
        // brightness: Brightness.light,
        leading: mostrarBackButton
            // ? GestureDetector(
            //     onTap: () {
            //       callBackButton();
            //     },
            //     child: Container(child: Icon(Icons.arrow_back_ios)),
            //   )
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  callBackButton();
                })
            : null,
        actions: optionsList);
  }

  static void mostrarToast({required String mensaje}) {
    Fluttertoast.showToast(
        msg: mensaje,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colores.COLOR_BLANCO,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static Widget actionRaisedButtonWidget(
      {required BuildContext context,
      required Widget title,
      required VoidCallback callBack,
      required Color color,
      required Color textColor,
      required Color borderColor,
      required double screenWidth}) {
    final ButtonStyle buttonStyle = TextButton.styleFrom(
      elevation: 0.0,
      backgroundColor: color,
      foregroundColor: textColor,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: TextButton(
        style: buttonStyle,
        child: title,
        onPressed: () {
          callBack();
        },
      ),
    );
  }

  static Widget actionRaisedButton(
      {required BuildContext context,
      required String title,
      required VoidCallback callBack,
      required Color color,
      required Color? textColor,
      required Color borderColor,
      required double screenWidth}) {

    final ButtonStyle buttonStyle = TextButton.styleFrom(
      elevation: 0.0,
      backgroundColor: color,
      foregroundColor: textColor,
      minimumSize: const Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 5, vertical: 12.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
    );
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        child: Text(title, style: styleTextButton),
        style: buttonStyle,
        onPressed: () {
          if (callBack != null) {
            callBack();
          }
        },
        //color: color == 0 ? Colores.COLOR_ACTION : Colores.COLOR_ACTION,
      ),
    );
  }

  static Widget actionFlatButton(
      {required BuildContext context,
      required String title,
      required VoidCallback callBack,
      required Color color,
      required Color textColor,
      required double screenWidth}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.symmetric(horizontal: screenWidth / 5, vertical: 10.0),
      child: ElevatedButton(
        onPressed: () {
          callBack();
        },
        child: Text(title, style: styleTextButton.copyWith(color: textColor)),
      ),
    );
  }

  static Widget backButton({required Color colorIcon, required VoidCallback callBack}) {
    return Container(
      // margin: EdgeInsets.only(top: kToolbarHeight - 10.0, left: 20.0),
      margin: EdgeInsets.only(top: 10.0, left: 20.0),
      child: GestureDetector(
        child: Icon(Icons.arrow_back_ios, color: colorIcon),
        onTap: () {
          callBack();
        },
      ),
    );
  }

  static Widget loadingCenter() {
    return const Center(
      child: CircularProgressIndicator(backgroundColor: Colores.COLOR_PRIMARY, strokeWidth: 2.0),
    );
  }

  static Widget botonUbicacion({required VoidCallback callBack}) {
    return Align(
      alignment: Alignment.centerRight,
      child: FloatingActionButton(
        mini: true,
        elevation: 1,
        backgroundColor: Colors.white,
        onPressed: () async {
          callBack();
        },
        child: const Icon(Icons.my_location, color: Colors.black),
      ),
    );
  }

  static Widget botonMenuOfertasDemandas(
    String title,
    IconData icono,
    VoidCallback callBackBoton,
    double? margen,
    Color colorBoton,
    Color colorInterno,
  ) {
    return GestureDetector(
      onTap: () async {
        callBackBoton();
      },
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margen ?? 5.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
            // color: Colores.COLOR_GRIS_HINT,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
            boxShadow: [
              BoxShadow(
                color: colorBoton,
              ),
            ],
          ),
          child: ButtonBar(
            children: [
              Icon(
                icono,
                size: 20.0,
                color: colorInterno,
              ),
              Center(
                child: AutoSizeText(
                  title,
                  style: TextStyle(
                    fontFamily: "Helvetica",
                    fontSize: 20,
                    color: colorInterno,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //este si estaba activo
  /*static Widget cardOferta(OfertaModel oferta, {List<Widget> opcionesList = const []}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Container(
        height: 130,
        color: oferta.estado == 0 ? Colores.COLOR_GRIS_HINT : Colores.COLOR_BLANCO,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: oferta.imagen == ""
                            ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                            : NetworkImage(GlobalVariables.URL_IMAGE + oferta.imagen!),
                      ),
                    ),
                    // child: Image.network(
                    //   GlobalVariables.URL_IMAGE + oferta.imagen,
                    //   fit: BoxFit.contain,
                    //   loadingBuilder: (context, child, loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return const Center(
                    //       child: Image(
                    //         image: AssetImage("assets/images/loading_image.gif"),
                    //         fit: BoxFit.contain,
                    //       ),
                    //     );
                    //   },
                    //   errorBuilder: (context, error, stackTrace) =>
                    //       // const Text('Some errors occurred!'),
                    //       const Image(
                    //     image: AssetImage("assets/images/profesiones.png"),
                    //     fit: BoxFit.contain,
                    //   ),
                    // ),
                  ),
                  SizedBox(height: 5.0),
                  AutoSizeText(
                    "${oferta.nombres} ${oferta.apellidos}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    minFontSize: 10.0,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Align(child: AutoSizeText(oferta.fechaCreacion!), alignment: Alignment.centerRight),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: AutoSizeText(
                                  oferta.titulo!,
                                  maxLines: 1,
                                  minFontSize: 15,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: AutoSizeText(
                                  oferta.descripcionActividad!,
                                  maxLines: 3,
                                  minFontSize: 13,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: opcionesList,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/
//  Este si estaba activo
 /* static Widget cardDemanda(DemandaModel demanda, {List<Widget> opcionesList = const []}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(5),
      child: Container(
        height: 130,
        color: demanda.estado == 0 ? Colores.COLOR_GRIS_HINT : Colores.COLOR_BLANCO,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: demanda.imagen == ""
                            ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                            : NetworkImage(GlobalVariables.URL_IMAGE + demanda.imagen!),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                  AutoSizeText(
                    "${demanda.nombres} ${demanda.apellidos}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.black54),
                    minFontSize: 10.0,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Align(
                          child: AutoSizeText(demanda.fechaCreacion!),
                          alignment: Alignment.centerRight,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListTile(
                                title: AutoSizeText(
                                  demanda.titulo!,
                                  maxLines: 1,
                                  minFontSize: 15,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: AutoSizeText(
                                  demanda.descripcionActividad!,
                                  maxLines: 3,
                                  minFontSize: 13,
                                  textAlign: TextAlign.justify,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: opcionesList,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  static Widget getStars(double puntuacion, {double sizeStar = 20}) {
    List<Icon> listStars = [];
    int puntosint = puntuacion.floor();
    int puntosRedondear = puntuacion.round();
    Icon starFull = Icon(Icons.star, color: Colors.amber, size: sizeStar);
    Icon starEmpty = Icon(Icons.star_border, color: Colors.amber, size: sizeStar);
    Icon starHalf = Icon(Icons.star_half, color: Colors.amber, size: sizeStar);
    // print("PUNTOS   >>>  $puntosint    $puntosRedondear");
    for (int i = 0; i < 5; i++) {
      if (i < puntosint) {
        // print("PUNTOS   >>>  1  $i");
        listStars.add(starFull);
      } else if (i == puntosint && i == puntosRedondear && puntosint == puntosRedondear) {
        listStars.add(starEmpty);
      } else if (i == puntosint && puntosint < puntosRedondear) {
        listStars.add(starHalf);
      } else if (i > puntosint) {
        listStars.add(starEmpty);
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listStars,
    );
  }
//este si funciona
 /* static Widget titleMiembro(MiembroModel miembro, VoidCallback callbackInfoM, {VoidCallback? callback}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
      // color: Colores.COLOR_BLANCO,
      decoration:
          const BoxDecoration(color: Colores.COLOR_BLANCO, borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListTile(
        leading: imageCircular(GlobalVariables.URL_IMAGE, miembro.imagen!),
        title: AutoSizeText(
          "${miembro.nombres} ${miembro.apellidos}",
          maxLines: 1,
          minFontSize: 10.0,
        ),
        subtitle: AutoSizeText(
          miembro.email == "" ? "correo@email.com" : "${miembro.email}",
          maxLines: 1,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
          minFontSize: 10.0,
        ),
        trailing: GestureDetector(
          onTap: () {
            // callbackTranferir();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.access_time, color: Colores.COLOR_VERDE_DESABILITADO),
              AutoSizeText(
                "${miembro.tiempo} horas",
                maxLines: 1,
                minFontSize: 10,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.normal, color: Colores.COLOR_VERDE_DESABILITADO),
              ),
            ],
          ),
        ),
        onTap: () {
          callbackInfoM();
        },
      ),
    );
  }*/
//este si funciona
  // static Widget tarjetaMiembro(MiembroModel miembroModel, {VoidCallback callback}) {
  //   return GestureDetector(
  //     onTap: () {
  //       callback();
  //     },
  //     child: Card(
  //       elevation: 2,
  //       margin: EdgeInsets.all(5),
  //       // color: Colores.COLOR_ROJO_BOTON,
  //       child: Row(
  //         children: [
  //           Container(
  //             margin: EdgeInsets.only(
  //               left: 10.0,
  //               right: 20.0,
  //             ),
  //             width: 60.0,
  //             height: 70.0,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               image: DecorationImage(
  //                 fit: BoxFit.contain,
  //                 image: miembroModel.imagen == ""
  //                     ? AssetImage("assets/images/placeholder.jpg")
  //                     : NetworkImage(GlobalVariables.URL_IMAGE + miembroModel.imagen),
  //               ),
  //             ),
  //           ),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               AutoSizeText("${miembroModel.nombres} ${miembroModel.apellidos}"),
  //               AutoSizeText(
  //                 miembroModel.email == "" ? "correo@email.com" : "${miembroModel.email}",
  //                 style: TextStyle(
  //                   fontSize: 14,
  //                   fontWeight: FontWeight.normal,
  //                   color: Colors.grey,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Spacer(),
  //           Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Icon(Icons.access_time_outlined),
  //               AutoSizeText("${miembroModel.tiempo} horas"),
  //             ],
  //           ),
  //           SizedBox(width: 10.0)
  //         ],
  //       ),
  //     ),
  //   );
  // }

  //este si funciona
  // Retorna un iten de miembro que aplica a una oferta o demanda
  /*static Widget cardMiemAplicado(UsuarioAplicadoModel usuario, {VoidCallback? callback}) {
    return GestureDetector(
      onTap: () {
        if (callback != null) {
          callback();
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.all(5),
        // color: Colores.COLOR_ROJO_BOTON,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 20.0),
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: usuario.imagen == ""
                      ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
                      : NetworkImage(GlobalVariables.URL_IMAGE + usuario.imagen!),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "${usuario.nombres} ${usuario.apellidos}",
                    overflow: TextOverflow.ellipsis,
                  ),
                  AutoSizeText(
                    usuario.email == "" ? "correo@email.com" : "${usuario.email}",
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                  ),
                  AutoSizeText(
                    usuario.telefono!,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0)
          ],
        ),
      ),
    );
  }*/

  static Widget imageCircular(String url, String urlImagen, {double ancho = 60.0}) {
    return Container(
      margin: const EdgeInsets.only(left: 0.0, right: 0.0),
      width: ancho,
      height: ancho,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.contain,
          image:  NetworkImage(""),
              //urlImagen ==""
              // ? const AssetImage(Assets.imagesPlaceholder) as ImageProvider
              // : NetworkImage("$url$urlImagen"),
        ),
      ),
      // child: Image.network(
      //   GlobalVariables.URL_IMAGE + miembroModel.imagen,
      //   fit: BoxFit.contain,
      //   loadingBuilder: (context, child, loadingProgress) {
      //     if (loadingProgress == null) return child;
      //     return const Center(
      //       child: Image(
      //         image: AssetImage("assets/images/loading_image.gif"),
      //         fit: BoxFit.contain,
      //       ),
      //     );
      //   },
      //   errorBuilder: (context, error, stackTrace) =>
      //       // const Text('Some errors occurred!'),
      //       const Image(
      //     image: AssetImage("assets/images/placeholder.jpg"),
      //     fit: BoxFit.contain,
      //   ),
      // ),
    );
  }

  static Widget botonGeneral(
      {required String title,
      required VoidCallback callBackBoton,
      Color colorBoton = Colors.black12,
      Color colorTexto = Colores.COLOR_PRIMARY,
      double borderRadius = 20,
      double margen = 50}) {
    return GestureDetector(
      onTap: () async {
        callBackBoton();
      },
      child: Container(
        height: 40.0,
        margin: EdgeInsets.symmetric(horizontal: margen),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          // color: Colores.COLOR_GRIS_HINT,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          boxShadow: [
            BoxShadow(
              color: colorBoton,
              // blurRadius: 0.0,
              // spreadRadius: 0.0,
              // offset: Offset(0.0, 0.0),
            ),
          ],
        ),
        child: Center(
          child: AutoSizeText(title,
              style: TextStyle(
                color: colorTexto,
                fontSize: 20.0,
              ),
              maxLines: 1),
        ),
      ),
    );
  }
    //esto si funciona
  // static Widget ListTitleMiembrosAplicados(UsuarioAplicadoModel usuarioAplicado, Widget iconContenido,
  //     {VoidCallback? callback}) {
  //   return ListTile(
  //     leading: WidgetsPersonalizados.imageCircular(GlobalVariables.URL_IMAGE, usuarioAplicado.imagen!),
  //     title: AutoSizeText(
  //       "${usuarioAplicado.nombres} ${usuarioAplicado.apellidos}",
  //       // "Humberto Fernando Morocho Guachisac",
  //       style: const TextStyle(fontSize: 14.0, color: Colors.black87),
  //       minFontSize: 10.0,
  //       maxLines: 1,
  //       textAlign: TextAlign.justify,
  //       overflow: TextOverflow.ellipsis,
  //     ),
  //     subtitle: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         AutoSizeText(
  //           usuarioAplicado.email! == "" ? "correo@email.com" : usuarioAplicado.email!,
  //           maxLines: 1,
  //           style: const TextStyle(fontSize: 14.0, color: Colors.grey),
  //           minFontSize: 10,
  //           textAlign: TextAlign.justify,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //         AutoSizeText(
  //           usuarioAplicado.telefono!,
  //           maxLines: 1,
  //           style: const TextStyle(fontSize: 14.0, color: Colors.grey),
  //           minFontSize: 10,
  //           textAlign: TextAlign.justify,
  //           overflow: TextOverflow.ellipsis,
  //         ),
  //       ],
  //     ),
  //     trailing: iconContenido,
  //   );
  // }

 /* static Widget cardMiembroAplicado(UsuarioAplicadoModel userAplicado, {List<Widget> opcionesList = const []}) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(5),
      child: Container(
        height: 90,
        color: Colores.COLOR_BLANCO,
        child: Row(
          children: [
            const SizedBox(width: 10),
            imageCircular(GlobalVariables.URL_IMAGE, userAplicado.imagen!),
            const SizedBox(width: 20),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${userAplicado.nombres} ${userAplicado.apellidos}",
                      // "Humberto Fernando Morocho Guachisac",
                      style: const TextStyle(fontSize: 14.0, color: Colors.black87),
                      minFontSize: 10.0,
                      maxLines: 1,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      userAplicado.email! == "" ? "correo@email.com" : userAplicado.email!,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                      minFontSize: 10,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(
                      userAplicado.telefono!,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                      minFontSize: 10,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10.0),
                    Expanded(
                      flex: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: opcionesList,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }*/

  static Widget iconPerso(Widget icono, VoidCallback callback, {double ancho = 30}) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(2.0),
        width: ancho,
        height: ancho,
        child: icono,
      ),
      onTap: () {
        callback();
      },
    );
  }
}
