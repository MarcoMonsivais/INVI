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
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text('Exportar CSV de base de datos', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
            Text('Descarga la base de datos actual en un archivo CSV', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),),
            ElevatedButton(
              onPressed: generateAndDownloadCSV,
              child: Text('Generar y Descargar CSV', style: GoogleFonts.roboto(
                color: Colors.black, 
                fontWeight: FontWeight.normal,
                fontSize: 15
              ),),
            ),
            const Divider(height: 20.0, color: Colors.grey),
            Text('Cargar archivo CSV', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
            Text('Carga un archivo CSV a la base de datos de sistema', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),),
            ElevatedButton(
              onPressed: () async {
                final jsonResult = await readCSVAndConvertToJson();
                print(jsonResult);
              },
              child: Text('Cargar CSV', style: GoogleFonts.roboto(
                color: Colors.black, 
                fontWeight: FontWeight.normal,
                fontSize: 15
              ),),
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

  Future<String> readCSVAndConvertToJson() async {
    // Crea un input de archivo para seleccionar el archivo CSV
    final input = html.FileUploadInputElement()..accept = '.csv';
    input.click();

    // Espera a que el usuario seleccione el archivo
    await input.onChange.first;
    final file = input.files?.first;
    if (file == null) {
      return 'No se seleccionó ningún archivo';
    }

    // Lee el archivo CSV
    final reader = html.FileReader();
    reader.readAsText(file);
    await reader.onLoad.first;

    final csvString = reader.result as String;

    // Convierte el contenido del CSV a una lista de listas
    List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

    // Convierte la lista de listas a JSON
    if (rowsAsListOfValues.isEmpty) {
      return 'El archivo CSV está vacío';
    }

    List<String> headers = List<String>.from(rowsAsListOfValues[0]);
    List<Map<String, dynamic>> jsonList = [];

    for (int i = 1; i < rowsAsListOfValues.length; i++) {
      Map<String, dynamic> rowMap = {};
      for (int j = 0; j < headers.length; j++) {
        rowMap[headers[j]] = rowsAsListOfValues[i][j];
      }
      jsonList.add(rowMap);
    }

    // Convierte la lista de mapas a una cadena JSON
    return jsonEncode(jsonList);
  }

}
