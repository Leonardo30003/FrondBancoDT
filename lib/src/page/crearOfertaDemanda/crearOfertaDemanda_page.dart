import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bancodt/api/api_ofertasDemandas.dart';
import 'package:bancodt/src/modelos/servicio_modelo.dart';

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

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null && (picked.start != fechaCreacion || picked.end != fechaVigente)) {
      setState(() {
        fechaCreacion = picked.start;
        fechaVigente = picked.end;
        // Si decides usar controladores para las fechas, actualízalos aquí
        fechaCreacion1.text = DateFormat('yyyy-MM-dd').format(picked.start);
        fechaVigente1.text = DateFormat('yyyy-MM-dd').format(picked.end);
      });
    }
  }

  void _crearOferta() {
    if (fechaCreacion == null || fechaVigente == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, selecciona el rango de fechas primero.'),
        ),
      );
      return;
    }

    final oferta = Servicio(
      ROL_CHOICES: tipo.text,
      titulo: titulo.text,
      descripcion_actividad: descripcion.text,
      tiempo_requerido: int.tryParse(horas.text) ?? 0,
      fecha_creacion: fechaCreacion1.text,
      fecha_vigente: fechaVigente1.text,
      propietario: 5,
      estadoVigencia: "vigente",
      estadoServicio: "solicitada",
    );

    ServicioApi.crearServicio(oferta);
        //.then((resultado) {
    //   print("se guardo el servicio");
    // }).catchError((error) {
    //   print("no se guardo el servicio");
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Ofertas y Demandas'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Tus otros widgets van aquí
              DropdownButtonFormField<String>(
                value: tipo.text.isEmpty ? null : tipo.text,
                items: const [
                  DropdownMenuItem<String>(
                    value: 'Oferta',
                    child: Text('Oferta'),
                  ),
                  DropdownMenuItem<String>(
                    value: 'Demanda',
                    child: Text('Demanda'),
                  ),
                ],
                onChanged: (value) {
                  tipo.text = value ?? '';
                },
                decoration: const InputDecoration(
                  labelText: 'Selecciona tipo:',
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: titulo,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: descripcion,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
              TextFormField(
                controller: horas,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Horas requeridas',
                  border: OutlineInputBorder(),
                ),
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
                        // controller: fechaCreacion1,
                        initialValue:DateFormat('yyyy-MM-dd').format(fechaCreacion!),
                        decoration: InputDecoration(
                          labelText: 'Fecha de creación',
                        ),
                      ),
                      TextFormField(
                        // controller: fechaVigente1,
                        initialValue:DateFormat('yyyy-MM-dd').format(fechaVigente!),
                        decoration: InputDecoration(
                          labelText: 'Fecha vigente hasta',
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: _crearOferta,
                child: const Text('Enviar'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
