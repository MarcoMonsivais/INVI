import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';

import 'package:csv/csv.dart';
import 'dart:html' as html;

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);
  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.settings}');
  }

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Configuración', 
          style: GoogleFonts.roboto(
              color: Colors.white, 
              fontWeight: FontWeight.bold
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white,),
          onPressed: () {
            const HomePage().goScreen(context);
          },
        ),
        backgroundColor: Colors.brown.shade200,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const Text('Exportar CSV de base de datos'),
            ElevatedButton(
              onPressed: generateAndDownloadCSV,
              child: const Text('Generar y Descargar CSV'),
            ),            
          ],
        ),
      ),
    );
  }
  void generateAndDownloadCSV() {
    List<List<dynamic>> rows = [
      ["Name", "Age", "Email"],
      ["Alice", 25, "alice@example.com"],
      ["Bob", 30, "bob@example.com"],
      ["Charlie", 35, "charlie@example.com"],
    ];

    String csv = const ListToCsvConverter().convert(rows);

    // Crear un Blob con el contenido del CSV
    final bytes = utf8.encode(csv);
    final blob = html.Blob([bytes]);

    // Crear un enlace temporal para descargar el archivo
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "example.csv")
      ..click();

    // Liberar la URL temporal
    html.Url.revokeObjectUrl(url);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Archivo descargado correctamente')),
    );
  }
  
}
