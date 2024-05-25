import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GoogleMappState extends StatefulWidget {
  GoogleMappState({super.key});

  @override
  State<GoogleMappState> createState() => GoogleMappStateState();
}

class GoogleMappStateState extends State<GoogleMappState> {
  final TextEditingController _controller = TextEditingController();
  String _studentName = '';
  String _studentImage = '';

  Future<void> _fetchStudent(String codigo) async {
    final response = await http.get(Uri.parse('http://localhost:3000/Estudiantes?codigo=$codigo'));

    if (response.statusCode == 200) {
      final List students = json.decode(response.body);
      if (students.isNotEmpty) {
        setState(() {
          _studentName = students[0]['nombre'];
          _studentImage = students[0]['imagen'];
        });
      } else {
        setState(() {
          _studentName = 'Estudiante no encontrado';
          _studentImage = '';
        });
      }
    } else {
      setState(() {
        _studentName = 'Error al buscar estudiante';
        _studentImage = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: _studentImage.isNotEmpty
                ? Image.network(_studentImage)
                : Icon(Icons.account_circle),
            onSelected: (item) => _onSelected(context, item),
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: <Widget>[Text("opcion 1")],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: <Widget>[Text("opcion 2")],
                ),
              ),
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'Buscar por código de estudiante',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => _fetchStudent(_controller.text),
                  ),
                ),
              ),
            ),
            if (_studentName.isNotEmpty) ...[
              Text('Nombre: $_studentName'),
              if (_studentImage.isNotEmpty) Image.network(_studentImage),
            ],
          ],
        ),
      ),
    );
  }
}

void _onSelected(BuildContext context, int item) {
  switch (item) {
    case 0:
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Opción 1 seleccionada')));
      break;
    case 1:
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Opción 2 seleccionada')));
      break;
  }
}
