import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:profile_view/profile_view.dart';
import 'package:xen_popup_card/xen_popup_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = "Nombre";
  String last_name = "";
  String username = "";
  String telefono = "";
  String direccion = "";
  String documennto_identificacion = "";
  String genero = "";
  String email = "";
  String password = "";
  String confirm_password = "";
  String _description = "Descripcion";
  String facebookUrl = "";
  String instagramUrl = "";
  String linkedInUrl = "";

  bool _isEditing = false;

  final BoxController boxController = BoxController();
  final List<String> _offers = ['Mi Oferta 1', 'Mi Oferta 2'];
  final List<String> _demands = ['Mi demanda 1', 'Mi demanda 2'];
  bool showingOffers = true;
  bool _isSlidingBoxVisible = false;

  File? _image;

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'No se pudo lanzar $url';
  }

  void showOffers() {
    if (_isSlidingBoxVisible) {
      // Actualiza este método con el método correcto para cerrar el SlidingBox
      boxController.closeBox();
    } else {
      // Actualiza este método con el método correcto para abrir el SlidingBox
      boxController.openBox();
    }
    setState(() {
      _isSlidingBoxVisible = !_isSlidingBoxVisible;
    });
  }

  void showDemands() {
    if (_isSlidingBoxVisible) {
      // Actualiza este método con el método correcto para cerrar el SlidingBox
      boxController.closeBox();
    } else {
      // Actualiza este método con el método correcto para abrir el SlidingBox
      boxController.openBox();
    }
    setState(() {
      _isSlidingBoxVisible = !_isSlidingBoxVisible;
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Actualiza la imagen seleccionada
      });
    }
  }

  XenCardGutter gutter = const XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(text: "Guardar y salir"),
    ),
  );
  @override
  Widget build(BuildContext context) {
    double slidingBoxHeight = _isSlidingBoxVisible
        ? MediaQuery.of(context).size.height * 0.0
        : 100; // El valor mínimo cuando está colapsado
    return Scaffold(
      body: Column(
        children: <Widget>[
          _TopPortion(profileImage: _image),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  _isEditing
                      ? _EditableTextField(
                    label: "Nombre:",
                    initialValue: _name,
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  )
                      : Text(
                    _name,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _isEditing
                      ? _EditableTextField(
                    label: "Descripcion",
                    initialValue: _description,
                    onChanged: (value) {
                      setState(() {
                        _description = value;
                      });
                    },
                  )
                      : Text(
                    _description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (facebookUrl.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.facebook),
                          onPressed: () => _launchURL(facebookUrl),
                        ),
                      if (instagramUrl.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.camera_alt),
                          onPressed: () => _launchURL(instagramUrl),
                        ),
                      if (linkedInUrl.isNotEmpty)
                        IconButton(
                          icon: Icon(Icons.work), // Icono genérico, cámbialo según tus necesidades
                          onPressed: () => _launchURL(linkedInUrl),
                        ),
                    ],
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton.extended(
                        onPressed: () {},
                        heroTag: 'Seguir',
                        elevation: 0,
                        label: const Text("Seguir"),
                        icon: const Icon(Icons.person_add_alt_1),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),*/

                  const SizedBox(height: 16),
                  EditableRatingStars(),
                  const SizedBox(height: 16),
                  _ProfileInfoRow(
                    showOffers: showOffers,
                    showDemands: showDemands,
                  ),
                  const SizedBox(height: 16),
                  cardWithGutterAndAppBar(),
                ],
              ),
            ),
          ),
          SlidingBox(
            controller: boxController,
            minHeight: slidingBoxHeight,
            maxHeight: MediaQuery.of(context).size.height * 0.0,
            color: Theme.of(context).colorScheme.background,
            style: BoxStyle.sheet,
            bodyBuilder: (sc, pos) => _buildSlidingBoxContent(sc, pos),
            collapsedBody: _collapsedSlidingBoxBody(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isSlidingBoxVisible = !_isSlidingBoxVisible;
          });
        },
        child: Icon(Icons.edit),
      ),
    );
  }

  Widget _buildSlidingBoxContent(ScrollController sc, double pos) {
    // Construye el contenido de tu SlidingBox aquí
    return Center(
      child: Text("Contenido del SlidingBox"),
    );
  }

  Widget _collapsedSlidingBoxBody() {
    // Construye el cuerpo colapsado de tu SlidingBox aquí
    return Center(
      child: Text("Toca para expandir"),
    );
  }

  Widget cardWithGutterAndAppBar() => TextButton(
    onPressed: () => showDialog(
      context: context,
      builder: (builder) => XenPopupCard(
        gutter: gutter,
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buildTextFormField(
              label: 'Nombre',
              initialValue: _name,
              onChanged: (value) => setState(() => _name = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Apellido',
              initialValue: last_name,
              onChanged: (value) => setState(() => last_name = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Email',
              initialValue: email,
              onChanged: (value) => setState(() => email = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Teléfono',
              initialValue: telefono,
              onChanged: (value) => setState(() => telefono = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Dirección',
              initialValue: direccion,
              onChanged: (value) => setState(() => direccion = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Documento de Identificación',
              initialValue: documennto_identificacion,
              onChanged: (value) =>
                  setState(() => documennto_identificacion = value),
            ),
            SizedBox(height: 16),
            buildDropdownField(
              label: 'Género',
              value: genero,
              items: ['Masculino', 'Femenino', 'Otro'],
              onChanged: (value) => setState(() => genero = value!),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Descripción',
              initialValue: _description,
              onChanged: (value) => setState(() => _description = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Contraseña',
              initialValue: password,
              onChanged: (value) => setState(() => password = value),
              obscureText: true,
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'Confirmar Contraseña',
              initialValue: confirm_password,
              onChanged: (value) =>
                  setState(() => confirm_password = value),
              obscureText: true,
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'URL de Facebook',
              initialValue: facebookUrl,
              onChanged: (value) => setState(() => facebookUrl = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'URL de Instagram',
              initialValue: instagramUrl,
              onChanged: (value) => setState(() => instagramUrl = value),
            ),
            SizedBox(height: 16),
            buildTextFormField(
              label: 'URL de LinkedIn',
              initialValue: linkedInUrl,
              onChanged: (value) => setState(() => linkedInUrl = value),
            ),
            SizedBox(height: 16),
            _buildImagePickerField(), // Campo para seleccionar la imagen
            SizedBox(height: 25),
          ],
        ),
      ),
    ),
    child: const Text("Editar"),
  );

  TextFormField buildTextFormField({
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    bool obscureText = false,
  }) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
      obscureText: obscureText,
    );
  }

  Widget _buildImagePickerField() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: _pickImage,
          child: Text('Cambiar Foto de Perfil'),
        ),
        if (_image != null)
          CircleAvatar(
            radius: 75, // El radio del CircleAvatar
            backgroundImage:
            FileImage(_image!), // Muestra la imagen seleccionada
          )
        else
          CircleAvatar(
            radius: 75, // El radio del CircleAvatar
            backgroundImage: NetworkImage(
              "https://th.bing.com/th/id/R.44feaafc87215076e5eb5df5328d38a5?rik=cPBbJrMvT35mow&pid=ImgRaw&r=0", // Coloca aquí la URL de tu imagen por defecto
            ),
          ),
      ],
    );
  }

  DropdownButtonFormField<String> buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      value: value.isEmpty ? null : value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

Widget _buildSlidingBoxBody() {
  return ListView(
    children: List<Widget>.generate(
        20, (index) => ListTile(title: Text('Item $index'))),
  );
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
              ? [
            BoxShadow(
                color: Colors.blue, blurRadius: 10, offset: Offset(0, 0))
          ]
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

class _ProfileInfoRow extends StatelessWidget {
  final VoidCallback showOffers;
  final VoidCallback showDemands;
  _ProfileInfoRow({
    Key? key,
    required this.showOffers,
    required this.showDemands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: [
          ProfileInfoItem(
            title: "Ofertas",
            value: 900,
            onTap: () => context
                .findAncestorStateOfType<_ProfilePageState>()
                ?.showOffers(),
          ),
          ProfileInfoItem(
            title: "Demandas",
            value: 120,
            onTap: () => context
                .findAncestorStateOfType<_ProfilePageState>()
                ?.showDemands(),
          ),
          ProfileInfoItem(
            title: "N horas disponible",
            value: 200,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class _EditableTextField extends StatelessWidget {
  const _EditableTextField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onChanged,
  }) : super(key: key);

  final String label;
  final String initialValue;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      onChanged: onChanged,
    );
  }
}

Widget _singleItem(BuildContext context, ProfileInfoItem item) => Column(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        item.value.toString(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    ),
    Text(
      item.title,
      style: Theme.of(context).textTheme.caption,
    )
  ],
);

class _TopPortion extends StatelessWidget {
  const _TopPortion({Key? key, required this.profileImage}) : super(key: key);

  final File? profileImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior:
      Clip.none, // Permite que los hijos se dibujen fuera de la caja
      alignment: Alignment.center,
      children: [
        Container(
          height: 300, // Altura para la foto de portada
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  "images/bdt_portada.jpg"),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(50)),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 150,
                  height: 150,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const ProfileView(
                        //ANiadir un if
                        image: AssetImage("images/Bank.jpeg"),
                      ),
                      Positioned(
                        bottom: -75,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                          child: Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: const BoxDecoration(
                                color: Colors.green, shape: BoxShape.circle),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class EditableRatingStars extends StatefulWidget {
  const EditableRatingStars({Key? key}) : super(key: key);

  @override
  _EditableRatingStarsState createState() => _EditableRatingStarsState();
}

class _EditableRatingStarsState extends State<EditableRatingStars> {
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        5,
            (index) => IconButton(
          icon: Icon(
            index < _rating.floor() ? Icons.star : Icons.star_border,
            color: Colors.amber,
          ),
          onPressed: () {
            setState(() {
              _rating = index + 1.0;
            });
          },
        ),
      ),
    );
  }
}