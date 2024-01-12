import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class prueba extends StatefulWidget {
  @override
  _pruebaState createState() => _pruebaState();
}

class _pruebaState extends State<prueba> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subir Foto del Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image != null ? Image.file(_image!) : Text('No se ha seleccionado ninguna imagen.'),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Subir Foto'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: prueba()));
