import 'package:bancodt/src/page/Chat/chat.dart';
import 'package:bancodt/src/page/transaccion/transaccionTerminada.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(TransaccionHoras());
}

class TransaccionHoras extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detalles de pago',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PaymentDetailsScreen(),
    );
  }
}

class PaymentDetailsScreen extends StatelessWidget {
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildRecipientSection(),
          _buildTransactionDetails(),
          _buildTransactionBreakdown(),
          SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 50), // width and height
            ),
            onPressed: () {
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

  Widget _buildRecipientSection() {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.person),
      ),
      title: Text('Juanito perez'),
      subtitle: Text('@juanitoperez'),
    );
  }

  Widget _buildTransactionDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailItem('Id de transaccion', '123456'),
        _buildDetailItem('Transaccion', 'viernes,'),
        _buildDetailItem('Horas', '5H'),
        _buildDetailItem('Estado', 'Completado'),
      ],
    );
  }

  Widget _buildTransactionBreakdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        _buildDetailItem('Total', '5H'),
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