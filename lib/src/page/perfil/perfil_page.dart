import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:profile_view/profile_view.dart';
import 'package:xen_popup_card/xen_popup_card.dart';
import 'package:flutter/services.dart';
import 'button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final BoxController boxController = BoxController();
  bool isSlidingBoxVisible = false;
  List<String> misOfertas = ['Oferta 1', 'Oferta 2', 'Oferta 3'];
  List<String> misDemandas = ['Demanda 1', 'Demanda 2', 'Demanda 3'];
  String showingList = ''; // 'ofertas', 'demandas' o ''

  void showSlidingBox(String listType) {
    setState(() {
      showingList = listType;
      isSlidingBoxVisible = true;
    });
  }

  void hideSlidingBox() {
    setState(() {
      isSlidingBoxVisible = false;
    });
  }

  Widget buildSlidingBoxContent() {
    List<String> itemsToShow = showingList == 'ofertas' ? misOfertas : misDemandas;
    return ListView(
      children: itemsToShow.map((item) => ListTile(title: Text(item))).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Aquí colocas el contenido de fondo de tu página de perfil
          // Por ejemplo, el resto de tu Column o ListView
          Column(
            children: [
              // Contenido existente antes del SlidingBox
              Expanded(
                child: Container(), // Reemplaza con tu contenido actual
              ),
              // Este botón se utiliza solo como ejemplo para cerrar el SlidingBox
              if (isSlidingBoxVisible)
                ElevatedButton(
                  onPressed: hideSlidingBox,
                  child: Text('Cerrar SlidingBox'),
                ),
            ],
          ),
          // SlidingBox que aparecerá encima del contenido existente
          if (isSlidingBoxVisible)
            SlidingBox(
              controller: boxController,
              minHeight: 300,
              maxHeight: MediaQuery.of(context).size.height,
              collapsedBody: buildSlidingBoxContent(),
            ),
        ],
      ),
      bottomNavigationBar: _ProfileInfoRow(
        showOfertas: () => showSlidingBox('ofertas'),
        showDemandas: () => showSlidingBox('demandas'),
      ),
    );
  }
}

class _ProfileInfoRow extends StatelessWidget {
  final VoidCallback showOfertas;
  final VoidCallback showDemandas;

  const _ProfileInfoRow({
    Key? key,
    required this.showOfertas,
    required this.showDemandas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: [
        ProfileInfoItem(
          title: "Ofertas",
          value: 900,
          onTap: showOfertas,
        ),
        ProfileInfoItem(
          title: "Demandas",
          value: 120,
          onTap: showDemandas,
        ),
        // Puedes añadir más ProfileInfoItem aquí si lo necesitas
      ],
    );
  }
}

class ProfileInfoItem extends StatefulWidget {
  final String title;
  final int value;
  final VoidCallback onTap;

  const ProfileInfoItem({
    Key? key,
    required this.title,
    required this.value,
    required this.onTap,
  }) : super(key: key);

  @override
  _ProfileInfoItemState createState() => _ProfileInfoItemState();
}

class _ProfileInfoItemState extends State<ProfileInfoItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (hovering) {
        setState(() {
          _isHovering = hovering;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isHovering
              ? [BoxShadow(color: Colors.blue, blurRadius: 10, offset: Offset(0, 0))]
              : [],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _isHovering ? Colors.blue : Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.value.toString(),
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w800,
                color: _isHovering ? Colors.blue : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}