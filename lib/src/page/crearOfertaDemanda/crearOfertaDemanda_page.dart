import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bancodt/api/api_ofertasDemandas.dart';
import 'package:bancodt/src/modelos/servicio_modelo.dart';
//import 'package:bancodt/constantes/widgets/widgets_personalizados.dart';
import 'package:bancodt/constantes/colores.dart';
import 'package:bancodt/src/providers/usuario_provider.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:provider/provider.dart';
import 'package:bancodt/src/modelos/cuenta_modelo.dart';
import 'package:bancodt/api/api_cuenta.dart';

import '../login/login2/dialog_builders.dart';

class CreateOfferDemandPage extends StatefulWidget {
  const CreateOfferDemandPage({Key? key}) : super(key: key);

  @override
  State<CreateOfferDemandPage> createState() => _CreateOfferDemandPageState();
}

class _CreateOfferDemandPageState extends State<CreateOfferDemandPage> {
  final TextEditingController tipo = TextEditingController();
  final TextEditingController titulo = TextEditingController();
  final TextEditingController descripcion = TextEditingController();
  final TextEditingController horas = TextEditingController();
  final TextEditingController fechaCreacion1 = TextEditingController();
  final TextEditingController fechaVigente1 = TextEditingController();

  DateTime? fechaCreacion;
  DateTime? fechaVigente;

  //metodo para obtener el usuario autentificado
  late UsuarioProvider _usuarioProvider;
  late Future<Cuenta> _cuentaFuture;

  void _loadUserProfile() {
    // Obtener el usuario desde el UsuarioProvider

    Usuario? usuario = _usuarioProvider.usuario;
    if (usuario != null) {
      //setState(() {
      //   _id = usuario.id;
      //   _description = usuario.last_name;
      //   _email = usuario.email;
      //   // Resto del código...
      // });
    }
    print(usuario);
  }

  @override
  void initState() {
    super.initState();
    // Obtener una referencia al UsuarioProvider
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    // Cargar el perfil del usuario al inicio
    _loadUserProfile();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null &&
        (picked.start != fechaCreacion || picked.end != fechaVigente)) {
      setState(() {
        fechaCreacion = picked.start;
        fechaVigente = picked.end;
        // Si decides usar controladores para las fechas, actualízalos aquí
        fechaCreacion1.text = DateFormat('yyyy-MM-dd').format(picked.start);
        fechaVigente1.text = DateFormat('yyyy-MM-dd').format(picked.end);
      });
    }
  }

  final _formKey = GlobalKey<FormState>();
  void _crearOferta() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (fechaCreacion == null || fechaVigente == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, selecciona el rango de fechas primero.'),
        ),
      );
      return;
    }
    Usuario? usuario = _usuarioProvider.usuario;
    if (usuario != null) {
      setState(() {
        _cuentaFuture = CuentaApi.obtenerCuentaPorId(usuario.id.toString());

        _cuentaFuture.then((cuenta) {
          print(usuario.id);
          print(tipo.text);
          final oferta = Servicio(
            ROL_CHOICES: tipo.text,
            titulo: titulo.text,
            descripcion_actividad: descripcion.text,
            tiempo_requerido: int.tryParse(horas.text) ?? 0,
            fecha_creacion: fechaCreacion1.text,
            fecha_vigente: fechaVigente1.text,
            propietario: cuenta.id,
            estadoVigencia: "vigente",
            estadoServicio: "solicitada",
          );
          ServicioApi.crearServicio(oferta);
        }).catchError((error) {
          print("Error al obtener la cuenta: $error");
        });
      });
    }
  }

  TextFormField buildTextFormField({
    required String label,
    required TextEditingController controller,
    String? Function(String?)? validator,
    bool readOnly = false,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blueAccent),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.pink),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
          borderRadius: BorderRadius.circular(30),
        ),
        errorStyle: TextStyle(color: Colors.red),
        fillColor: readOnly ? Colors.grey[200] : Colors.white,
        filled: true,
      ),
      style: TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  DropdownButtonFormField<String> buildDropdownField({
    required String label,
    required List<String> items,
    String? value,
    required void Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.pink),
        ),
      ),
      value: value,
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                buildDropdownField(
                  label: 'Selecciona tipo:',
                  value: tipo.text.isEmpty ? null : tipo.text,
                  items: ['Oferta', 'Demanda'],
                  onChanged: (newValue) {
                    setState(() {
                      tipo.text = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20.0),
                buildTextFormField(
                  label: 'Título',
                  controller: titulo,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el título';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                buildTextFormField(
                  label: 'Descripción',
                  controller: descripcion,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una descripción';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                buildTextFormField(
                  label: 'Horas requeridas',
                  controller: horas,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa las horas requeridas';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Por favor ingresa un número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () => _selectDateRange(context),
                  child: const Text('Seleccionar fecha de disponibilidad'),
                ),
                if (fechaCreacion != null && fechaVigente != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        TextFormField(
                          readOnly: true, // Campo de solo lectura
                          initialValue:
                          DateFormat('yyyy-MM-dd').format(fechaCreacion!),
                          decoration: InputDecoration(
                            labelText: 'Fecha de creación',
                            // Aquí aplicas el estilo que prefieras
                          ),
                        ),
                        TextFormField(
                          readOnly: true, // Campo de solo lectura
                          initialValue:
                          DateFormat('yyyy-MM-dd').format(fechaVigente!),
                          decoration: InputDecoration(
                            labelText: 'Fecha vigente hasta',
                            // Aquí aplicas el estilo que prefieras
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _crearOferta();
                        DialogBuilder(context).showResultDialog('Se ha creado correctamente');
                      } else {
                      }
                    },
                    child: Text('Crear'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}