import 'package:bancodt/src/page/Chat/chat.dart';
import 'package:bancodt/src/page/chat/prueba_chat.dart';
import 'package:bancodt/src/page/crearOfertaDemanda/crearOfertaDemanda_page.dart';
import 'package:bancodt/src/page/demandas/demandas/demandas_page.dart';
import 'package:bancodt/src/page/historial/historial_page.dart';
import 'package:bancodt/src/page/home/ofertas_home.dart';
import 'package:bancodt/src/page/perfil/perfil_page.dart';
import 'package:bancodt/src/page/transaccion/VerTransaccion.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'dart:core';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Banco del Tiempo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        canvasColor: canvasColor,
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(
            color: Colors.white,
            fontSize: 46,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      home: Builder(
        builder: (context) {
          final isSmallScreen = MediaQuery.of(context).size.width < 600;
          return Scaffold(
            key: _key,
            appBar: isSmallScreen
                ? AppBar(
              backgroundColor: canvasColor,
              title: Text(_getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
                : null,
            drawer: ExampleSidebarX(controller: _controller),
            body: Row(
              children: [
                if (!isSmallScreen) ExampleSidebarX(controller: _controller),
                Expanded(
                  child: Center(
                    child: _ScreensExample(
                      controller: _controller,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  const ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: canvasColor,
          borderRadius: BorderRadius.circular(20),
        ),
        hoverColor: scaffoldBackgroundColor,
        textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
        selectedTextStyle: const TextStyle(color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: canvasColor),
        ),
        selectedItemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: actionColor.withOpacity(0.37),
          ),
          gradient: const LinearGradient(
            colors: [accentCanvasColor, canvasColor],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 30,
            )
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.white.withOpacity(0.7),
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 200,
        decoration: BoxDecoration(
          color: canvasColor,
        ),
      ),
      footerDivider: divider,
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset('assets/images/logo.png'),
          ),
        );
      },
      items: [
        SidebarXItem(
          icon: Icons.account_circle,
          label: 'Perfil',
          onTap: () {
            debugPrint('Home');
          },
        ),
        const SidebarXItem(
          icon: Icons.account_balance,
          label: 'Inicio',
        ),
        const SidebarXItem(
          icon: Icons.add_chart_rounded,
          label: 'Demandas',
        ),
        const SidebarXItem(
            icon: Icons.add_alert,
            label: "Historial"
        ),
        const SidebarXItem(
            icon: Icons.add_box_outlined,
            label: "Crear Oferta/Demanda"
        ),
        const SidebarXItem(
            icon: Icons.mark_email_read,
            label: "Buzon de Mensajes"
        ),
        const SidebarXItem(
            icon: Icons.add_box_rounded,
            label: "Chat"
        ),
        const SidebarXItem(
            icon: Icons.add_box_rounded,
            label: "Transaccion"
        ),
        const SidebarXItem(
            icon: Icons.add_box_rounded,
            label: "Notificaciones"
        ),
      ],
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        switch (controller.selectedIndex) {
          case 0:
            return ProfilePage(); // Asumiendo que esta es una página definida
          case 1:
            return OfertasHome(); // Asumiendo que esta es una página definida
          case 2:
            return DemandasHome(); // Asumiendo que esta es una página definida
          case 3:
            return HistorialPage(); // Asumiendo que esta es una página definida
          case 4:
            return CreateOfferDemandPage(); // Asumiendo que esta es una página definida
          case 5:
            return PruebaChat(); // Asumiendo que esta es una página definida
          case 6:
            return chatPage();
          case 7:
            return VerTransaccion();
          default:
            return Center(
              child: Text(
                'Página no encontrada',
                style: theme.textTheme.headlineSmall,
              ),
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Perfil';
    case 1:
      return 'Ofertas Home';
    case 2:
      return 'Demandas';
    case 3:
      return 'Historial';
    case 4:
      return 'Crear Oferta/Demanda';
    case 5:
      return 'Crear demanda';
    case 6:
      return 'Transaccion';
    case 7:
      return 'Buzon de Mensajes';
    case 8:
      return 'Chat';
    default:
      return 'Not found page';
  }
}
const Color primaryColor = Color(0xFF910048); // Morado para elementos interactivos y botones
const Color canvasColor = Color(0xFF910048); // Morado claro para el fondo del contenido principal
const Color scaffoldBackgroundColor = Color(0xFFFFFFFF); // Azul índigo para la barra lateral o fondo de andamio
const Color accentCanvasColor = Color(0xFF002D72); // Amarillo para acentos, ideal para bordes y divisores
const Color white = Colors.white; // Blanco puro para texto y contraste
final Color actionColor = Color(0xFF910048).withOpacity(0.6); // Morado translúcido para elementos de acción como botones flotantes
final Divider divider = Divider(color: white.withOpacity(0.3), height: 1); // Divisor blanco translúcido para separar elementos discretamente