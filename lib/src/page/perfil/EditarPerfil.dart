import 'package:bancodt/src/page/perfil/button.dart';
import 'package:flutter/material.dart';
import 'package:xen_popup_card/xen_popup_card.dart';

void main() {
  runApp(const MaterialApp(home: EditarPerfil()));
}

class EditarPerfil extends StatefulWidget {
  const EditarPerfil({Key? key}) : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  // APP BAR
  //
  // [XenCardAppBar]
  XenCardAppBar appBar = const XenCardAppBar(
    child: Text(
      "app bar",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
    ),
    // To remove shadow from appbar
    shadow: BoxShadow(color: Colors.transparent),
  );

  // GUTTER
  //
  // [XenCardGutter]
  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "close"),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            cardWithGutterAndAppBar(),
          ],
        ),
      ),
    );
  }

  // card with both gutter and app bar
  Widget cardWithGutterAndAppBar() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        appBar: appBar,
        gutter: gutter,
        body: ListView(
          children: const [
            Text("body"),
          ],
        ),
      ),
    ),
    child: const Text("open card with gutter and app bar"),
  );



}