import 'package:bancodt/src/page/crearOfertaDemanda/crearOfertaDemanda_page.dart';
import 'package:bancodt/src/page/login/login2/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:bancodt/src/page/Cuenta/Cuenta.dart';
import 'package:bancodt/src/page/home/home_page.dart';
import 'package:bancodt/src/page/transaccion/transaccionHoras_page.dart';
import 'package:bancodt/src/page/perfil/perfil_page.dart';
import 'package:bancodt/src/page/historial/historial_page.dart';
import 'package:bancodt/src/page/home/ofertas_home.dart';
import 'package:bancodt/src/page/demandas/demandas/demandas_page.dart';
import 'package:bancodt/src/page/transaccion/transaccionTerminada.dart';
import 'package:bancodt/src/page/transaccion/transaccionTerminada.dart';
import 'package:bancodt/src/page/Chat/chat.dart';
import 'package:bancodt/src/page/chat/chats.dart';

final routes = <String, WidgetBuilder>{
 'login':(BuildContext context)=>LoginScreen(),
 'crearOfertaDemanda':(BuildContext context)=>CreateOfferDemandPage(),
 'home':(BuildContext context)=>HomePage(),
 'cuenta': (BuildContext context)=>CuentaScreen(),
 'transferirHoras':(BuildContext context)=>TransaccionHoras(),
 'PerfilPage':(BuildContext context)=> ProfilePage(),
 'historial':(BuildContext context)=>HistorialPage(),
 'ofertashome':(BuildContext context) => OfertasHome(),
// 'estado':(BuildContext context)=>EstadoPage(),
 'transaccion':(BuildContext context)=>transaccionTerminada(),
 'chat':(BuildContext context)=>chatPage(),
 'demandaspage':(BuildContext context) => DemandasHome(),
 'chats':(BuildContext context) => ChatsPage(),
};
