import 'package:bancodt/api/api_usuarios.dart';
import 'package:bancodt/constantes/const.dart';
import 'package:bancodt/src/page/Chat/chat.dart';
import 'package:bancodt/src/page/transaccion/transaccionTerminada.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:core';
import 'package:bancodt/src/providers/usuario_provider.dart';
import 'package:bancodt/src/modelos/cuenta_modelo.dart';
import 'package:bancodt/src/modelos/usuarios_modelo.dart';
import 'package:bancodt/src/modelos/transaccion_modelo.dart';
//apis
import 'package:bancodt/api/api_cuenta.dart';
import 'package:bancodt/api/api_transaccion.dart';
// provider
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TransaccionHoras extends StatefulWidget {
  const TransaccionHoras({super.key});

  @override
  State<TransaccionHoras> createState() => _TransaccionHorasState();
}

class _TransaccionHorasState extends State<TransaccionHoras> {
  Map<String, dynamic>? datos;

  Future<Map<String, dynamic>?> recuperarDatosDeSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? datosString = prefs.getString('datos');
    print(datosString);
    if (datosString != null) {
      Map<String, dynamic> datos = json.decode(datosString);
      print(datos);
      return datos;
    } else {
      return null;
    }
  }

  Future<void> recuperarDatos() async {
    Map<String, dynamic>? datosRecuperados =
        await recuperarDatosDeSharedPreferences();
    if (datosRecuperados != null) {
      setState(() {
        datos = datosRecuperados;
      });
    }
  }

  late UsuarioProvider _usuarioProvider;
  late Future<Cuenta> _cuentaFuture;
  //late Future<Usuario> _cuentaPropietario;
  late Future<Usuario> _usuarioPropietario;


  final fechaCrearTransaccion = DateFormat('yyyy-MM-dd').format(DateTime.now());

  void _obtenerUsuario(int id) async {
    Cuenta usuarioActual = await CuentaApi.obtenerCuentaPorCuenta(id);
    if (usuarioActual != null) {
      setState(() {
        _usuarioPropietario = (UsuarioApi.obtenerUsuarioPorId(usuarioActual.id)) as Future<Usuario>;
      });

  }


  @override
  void initState() {
    super.initState();

    print(fechaCrearTransaccion);
    _usuarioProvider = Provider.of<UsuarioProvider>(context, listen: false);
    recuperarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de pago'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => chatPage()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body:
          // Center(
          //   child: datos != null
          //       ? MostrarDatos(datosObtenidos: datos!)
          //       : Text('No se han encontrado datos en SharedPreferences'),
          // ),
          ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          //_buildRecipientSection(recuperarDatosDeSharedPreferences),
          //_buildTransactionDetails(recuperarDatos),
          Text('Servicio: ${datos?['servicio']}'),
          Text('horas: ${datos?['horas']}'),
          Text('Para: $_obtenerUsuario(${datos?['propietario']})'),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // width and height
            ),
            onPressed: () {
              Usuario? usuario = _usuarioProvider.usuario;
              Cuenta? propietarioser=CuentaApi.obtenerCuentaPorId({datos?['propietario']})
              if (usuario != null) {
                setState(() {
                  _cuentaFuture =
                      CuentaApi.obtenerCuentaPorId(usuario.id.toString());

                  _cuentaFuture.then((cuenta) {
                    print(usuario.id);
                    final trasaccion = TransaccionTiempo(
                      servicio: datos?['servicio'] ?? 0,
                      numero_horas: datos?['horas'] ?? 0,
                      numero_minutos: 0,
                      descripcion: datos?['descripcion'] ?? 'Datos',
                      demandanteCuenta: cuenta?.id ?? 0,
                      propietario: datos?['propietario'] ?? 0,
                      fecha_transaccion: fechaCrearTransaccion.toString(),
                      estadoTransaccion: 'en_proceso',
                    );
                    print(trasaccion);
                    TransaccionApi.crearTransaccionTiempo(trasaccion);
                  }).catchError((error) {
                    print(
                        "Error al guardar la transaccion en la funcion: $error");
                  });
                });
              }
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => transaccionTerminada()),
                (Route<dynamic> route) => false,
              );
            },
            child: Text('Transferir'),
          ),
        ],
      ),
    );
  }

  // Widget _buildRecipientSection(datos) {
  //   return ListTile(
  //     leading: CircleAvatar(
  //       child: Icon(Icons.person),
  //     ),
  //     title: Text('Para:'),
  //     subtitle: Text(datos.propietario),
  //   );
  // }

  // Widget _buildTransactionDetails(BuildContext context) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children:
  //       _buildDetailItem('Servicio','${datos.servicio}'),
  //       _buildDetailItem('Fecha', 'viernes,'),
  //       _buildDetailItem('Horas',datos['horas']),
  //       _buildDetailItem('Estado', 'Completado'),
  //       _buildDetailItem('Desde:', 'Leonardo'),
  //       _buildDetailItem('Para:',datos['propietario']),
  //     ],
  //   );
  // }

  Widget _buildTransactionBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _buildDetailItem('Monto Transferido', '5H'),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}

class MostrarDatos extends StatelessWidget {
  final Map<String, dynamic> datosObtenidos;

  MostrarDatos({required this.datosObtenidos});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Dato 1: ${datosObtenidos['servicio']}'),
        Text('Dato 2: ${datosObtenidos['horas']}'),
        Text('Dato 2: ${datosObtenidos['propietario']}'),
        // Otros widgets para mostrar los datos obtenidos
      ],
    );
  }
}
