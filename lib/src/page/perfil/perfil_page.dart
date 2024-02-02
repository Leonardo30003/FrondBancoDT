import 'dart:io';
import 'package:bancodt/api/api_cuenta.dart';
import 'package:bancodt/api/api_ofertasDemandas.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:bancodt/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:profile_view/profile_view.dart';
import 'package:xen_popup_card/xen_popup_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'button.dart';
import 'package:provider/provider.dart';
import 'package:bancodt/api/api_usuarios.dart';
import 'package:bancodt/src/modelos/cuenta_modelo.dart';
import 'package:intl/intl.dart';
import '../login/login2/dialog_builders.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // para recuperar los datos

  late UsuarioProvider _usuarioProvider;
  bool _mostrarOfertas = true;
  late Future<Cuenta> _cuentaFuture;

  Future<List<dynamic>> obtenerServiciosOfertas(
      String cuenta, String rolChoices) async {
    // Reemplaza con el tipo deseado
    try {
      List<dynamic> servicios = await ServicioApi.obtenerServiciosCuentaTipo(
          cuenta: cuenta, rolChoices: rolChoices);
      print('Servicios obtenidos: $servicios');
      return servicios;
    } catch (error) {
      print('Error al obtener servicios: $error');
      throw error; // Puedes manejar el error según tus necesidades
    }
  }

  List<dynamic> ofertas = [];
  List<dynamic> demandas = [];

  // codigo para cargar la lista de servicios por oferta/demandas

  final fechaCreacionFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());
  final fechaActualizacionFormatted =
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _actualizarUsuario() async {
    Usuario usuarioActual = await UsuarioApi.obtenerUsuarioPorId(_id);
    String generoAsignado = '';
    if (genero == "Masculino") {
      generoAsignado = "h"; // Asigna "h" si el género es Masculino
    } else if (genero == "Femenino") {
      generoAsignado = "m"; // Asigna "m" si el género es Femenino
    }

    final usuario = Usuario(
        id: _id,
        first_name: _name,
        email: _email,
        password: usuarioActual.password,
        confirm_password: usuarioActual.password,
        direccion: direccion,
        telefono: telefono,
        documento_identificacion: documennto_identificacion,
        is_active: true,
        is_staff: true,
        genero: generoAsignado,
        last_name: last_name,
        descripcion: _description,
        imagen: _image?.path ?? "images/Bank.jpeg",
        username: usuarioActual.username);
    try {
      print(usuario.password);
      await UsuarioApi.actualizarUsuario(usuario);
      print("actualizado");
      Usuario usuarioActualizado = await UsuarioApi.obtenerUsuarioPorId(_id);
      final cuenta = Cuenta(
        usuario: usuarioActualizado.id, // Crea una nueva instancia de Usuario
        fecha_creacion: fechaCreacionFormatted,
        fecha_actualizacion: fechaActualizacionFormatted,
        numero_horas: 10,
      );

      await CuentaApi.crearCuenta(cuenta);
    } catch (e) {
      print("Error al actualizar usuario: $e");
    }
  }

  void _loadUserProfile() {
    // Obtener el usuario desde el UsuarioProvider
    Usuario? usuario = _usuarioProvider.usuario;

    if (usuario != null) {
      setState(() {
        _name = usuario.first_name;
        _description = usuario.last_name;
        _username = usuario.username;
        // _password = usuario.password;
        _email = usuario.email;
        _description = usuario.descripcion;
        telefono = usuario.telefono;
        direccion = usuario.direccion;

        _id = usuario.id;
        // Resto del código...
      });
    }
    print(_id);
  }

  // Función para cargar la cuenta
  /* void _cargarCuenta() async {
    Usuario? usuario = _usuarioProvider.usuario;
    if (usuario != null) {
      setState(() {
        print(usuario.id);

        _cuentaFuture = CuentaApi.obtenerCuentaPorId(usuario.id
            .toString()); // Asignar el Future resultante a la variable _cuentaFuture
        print(_cuentaFuture);
      });
    }
  } */

  void _cargarCuenta() async {
    Usuario? usuario = _usuarioProvider.usuario;
    if (usuario != null) {
      setState(() {
        _cuentaFuture = CuentaApi.obtenerCuentaPorId(usuario.id.toString());

        _cuentaFuture.then((cuenta) {
          print("Cuenta obtenida: ${cuenta?.toJson()}");

          if (cuenta != null) {
            print("ID de la cuenta: ${cuenta.id}");
          } else {
            print("La cuenta es nula");
          }
        }).catchError((error) {
          print("Error al obtener la cuenta: $error");
        });
      });
    }
  }

  /* void _cargarCuenta() async {
    Usuario? usuario = _usuarioProvider.usuario;
    if (usuario != null) {
      try {
        // Obtener el ID de la cuenta directamente sin esperar la respuesta completa de la cuenta
        final int accountId =
            await CuentaApi.obtenerCuentaPorId(usuario.id.toString());
      } catch (error) {
        // Manejar errores si es necesario
        print("Error al obtener el ID de la cuenta: $error");
      }
    }
  } */

  @override
  void initState() {
    super.initState();
    // Obtener una referencia al UsuarioProvider
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    // Cargar el perfil del usuario al inicio

    _loadUserProfile();
    // cargamos la cuenta
    _cargarCuenta();

    // prueba mostrando datos

    // Inicializar el gutter aquí después de que se ha cargado el perfil
    gutter = XenCardGutter(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: CustomButton(
          text: "Guardar y salir",
          onPressed: () {
            // Llama al método _actualizarUsuario al presionar el botón
            _actualizarUsuario();
            DialogBuilder(context).showResultDialog(
                'Se actualizado sus datos y se ha creado su cuenta correctamente');
            print("Botón presionado");
          },
        ),
      ),
    );
  }

  // para crear el usuario
  int? _id;
  String _name = "Nombre";
  String last_name = "";
  String username = "";
  String telefono = "";
  String direccion = "";
  String documennto_identificacion = "";
  String genero = "";
  String _email = "";
  String password = "";
  String confirm_password = "";
  String _description = "Descripcion";
  String facebookUrl = "";
  String instagramUrl = "";
  String linkedInUrl = "";
  String _username = '';
  String _password = '';

  bool _isEditing = false;

  // para crear la cuenta
  String fecha_creacion = '';
  String fecha_actualizacion = '';
  int numero_horas = 10;

  final BoxController boxController = BoxController();
  final List<String> _offers = ['Mi Oferta 1', 'Mi Oferta 2'];
  final List<String> _demands = ['Mi demanda 1', 'Mi demanda 2'];
  bool showingOffers = true;
  bool _isSlidingBoxVisible = false;
  XenCardGutter? gutter;

  File? _image;

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'No se pudo lanzar $url';
  }

  void showOffers() async {
    try {
      Cuenta cuenta = await _cuentaFuture;
      List<dynamic> servicios = await obtenerServiciosOfertas(cuenta.id.toString(), 'Oferta');
      setState(() {
        _mostrarServicios(context, 'Oferta', servicios);
      });
    } catch (error) {
      print('Error al obtener servicios: $error');
    }
  }

  void showDemands() async {
    try {
      Cuenta cuenta = await _cuentaFuture;
      print(cuenta.id);
      List<dynamic> servicios = await obtenerServiciosOfertas(cuenta.id.toString(), 'Demanda');
      setState(() {
        _mostrarServicios(context, 'Demanda', servicios);
      });
    } catch (error) {
      print('Error al obtener servicios: $error');
    }
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

  /* XenCardGutter gutter = XenCardGutter(
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: CustomButton(
        text: "Guardar y salir",
        onPressed: () {
          // Llama al método _actualizarUsuario al presionar el botón
          _actualizarUsuario();
          print("Botón presionado");
        },
      ),
    ),
  ); */

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
                  const SizedBox(height: 10),
                  _isEditing
                      ? _EditableTextField(
                          label: "Correo:",
                          initialValue: _email,
                          onChanged: (value) {
                            setState(() {
                              _email = value;
                            });
                          },
                        )
                      : Text(
                          _email,
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
                          icon: Icon(Icons
                              .work), // Icono genérico, cámbialo según tus necesidades
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

  void _mostrarServicios(
      BuildContext context, String title, List<dynamic> servicios) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ServiciosPopup(title: title, servicios: servicios);
      },
    );
  }

  //widget agregado para colocar una lista
  Widget _buildServiciosList(List<dynamic> servicios) {
    return servicios.isNotEmpty
        ? ListView.builder(
            itemCount: servicios.length,
            itemBuilder: (context, index) {
              final servicio = servicios[index];
              return ListTile(
                title: Text('Tipo: ${servicio['ROL_CHOICES'] ?? ''}'),
                subtitle: Text('Titulo: ${servicio['titulo'] ?? ''}'),
              );
            },
          )
        : Center(
            child: Text("No hay servicios disponibles"),
          );
  }
  // ----------------------

  Widget _collapsedSlidingBoxBody(
      List<dynamic> servicios, bool mostrarOfertas) {
    final serviciosFiltrados = mostrarOfertas
        ? servicios
            .where((servicio) => servicio['ROL_CHOICES'] == 'Oferta')
            .toList()
        : servicios
            .where((servicio) => servicio['ROL_CHOICES'] == 'Demanda')
            .toList();

    return serviciosFiltrados.isNotEmpty
        ? ListView.builder(
            itemCount: serviciosFiltrados.length,
            itemBuilder: (context, index) {
              final servicio = serviciosFiltrados[index];
              return ListTile(
                title: Text('Tipo: ${servicio['ROL_CHOICES'] ?? ''}'),
                subtitle: Text('Titulo: ${servicio['titulo'] ?? ''}'),
              );
            },
          )
        : Center(
            child: Text(mostrarOfertas
                ? "No hay ofertas disponibles"
                : "No hay demandas disponibles"),
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
                  //controller: _first_nameController,
                  label: 'Nombre',
                  initialValue: _name,
                  onChanged: (value) => setState(() => _name = value),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _last_nameController,
                  label: 'Apellido',
                  initialValue: last_name,
                  onChanged: (value) => setState(() => last_name = value),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _emailController,
                  label: 'Email',
                  initialValue: _email,
                  onChanged: (value) => setState(() => _email = value),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _telefonoController,
                  label: 'Teléfono',
                  initialValue: telefono,
                  onChanged: (value) => setState(() => telefono = value),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _direccionController,
                  label: 'Dirección',
                  initialValue: direccion,
                  onChanged: (value) => setState(() => direccion = value),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _documento_identificacionController,
                  label: 'Documento de Identificación',
                  initialValue: documennto_identificacion,
                  onChanged: (value) =>
                      setState(() => documennto_identificacion = value),
                ),
                SizedBox(height: 16),
                buildDropdownField(
                  controller: TextEditingController(text: genero),
                  label: 'Género',
                  value: genero,
                  items: ['Masculino', 'Femenino', 'Otro'],
                  onChanged: (value) => setState(() => genero = value!),
                ),
                SizedBox(height: 16),
                buildTextFormField(
                  //controller: _descripcionController,
                  label: 'Descripción',
                  initialValue: _description,
                  onChanged: (value) => setState(() => _description = value),
                ),
                // SizedBox(height: 16),
                // buildTextFormField(
                //   //controller: _passwordController,
                //   label: 'Contraseña',
                //   initialValue: password,
                //   onChanged: (value) => setState(() => password = value),
                //   obscureText: true,
                // ),
                // SizedBox(height: 16),
                // buildTextFormField(
                //   //controller: _confirm_passwordController,
                //   label: 'Confirmar Contraseña',
                //   initialValue: confirm_password,
                //   onChanged: (value) =>
                //       setState(() => confirm_password = value),
                //   obscureText: true,
                // ),
                // SizedBox(height: 16),
                // buildTextFormField(
                //
                //   label: 'URL de Facebook',
                //   initialValue: facebookUrl,
                //   onChanged: (value) => setState(() => facebookUrl = value),
                // ),
                // SizedBox(height: 16),
                // buildTextFormField(
                //   label: 'URL de Instagram',
                //   initialValue: instagramUrl,
                //   onChanged: (value) => setState(() => instagramUrl = value),
                // ),
                // SizedBox(height: 16),
                // buildTextFormField(
                //   label: 'URL de LinkedIn',
                //   initialValue: linkedInUrl,
                //   onChanged: (value) => setState(() => linkedInUrl = value),
                // ),
                // SizedBox(height: 16),
                _buildImagePickerField(), // Campo para seleccionar la imagen
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
        child: const Text("Editar"),
      );

  TextFormField buildTextFormField({
    //required TextEditingController controller,
    required String label,
    required String initialValue,
    required Function(String) onChanged,
    bool obscureText = false,
  }) {
    return TextFormField(
      //rcontroller: controller,
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
    required TextEditingController controller,
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



class ServiciosPopup extends StatelessWidget {
  final String title;
  final List<dynamic> servicios;

  ServiciosPopup({required this.title, required this.servicios});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: _buildServiciosList(servicios),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cerrar'),
        ),
      ],
    );
  }

  Widget _buildServiciosList(List<dynamic> servicios) {
    return servicios.isNotEmpty
        ? Column(
            children: servicios.map((servicio) {
              return ListTile(
                title: Text('Tipo: ${servicio['ROL_CHOICES'] ?? ''}'),
                subtitle: Text('Titulo: ${servicio['titulo'] ?? ''}'),
              );
            }).toList(),
          )
        : Center(
            child: Text("No hay servicios disponibles"),
          );
  }
}

//---------------------------de aqui para abajo todo es lo anterior
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
            onTap: showOffers,
          ),
          ProfileInfoItem(
            title: "Demandas",
            value: 120,
            onTap: showDemands,
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
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          height: 200, // Altura para la foto de portada
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bdt_portada.jpg"),
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
                        image: AssetImage(
                            "images/Bank.jpeg"), // Muestra la imagen seleccionada
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
