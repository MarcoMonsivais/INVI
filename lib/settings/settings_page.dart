import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/admin/editproducts/edit_page.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';
import 'package:csv/csv.dart';
import 'dart:html' as html;
import 'package:invi/admin/newproduct/newproduct_page.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
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
              onPressed: () async =>
                await readCSVAndConvertToJson(),
              child: Text('Cargar CSV', style: GoogleFonts.roboto(
                color: Colors.black, 
                fontWeight: FontWeight.normal,
                fontSize: 15
              ),),
            ),
            const Divider(height: 20.0, color: Colors.grey),
            Text('Agregar un producto', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
            Text('Carga manualmente un producto', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),),
            ElevatedButton(
              onPressed: () => const NewProductPage().goScreen(context),
              child: Text('Cargar CSV', style: GoogleFonts.roboto(
                color: Colors.black, 
                fontWeight: FontWeight.normal,
                fontSize: 15
              ),),
            ),
            const Divider(height: 20.0, color: Colors.grey),
            Text('Editar productos', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.bold,
              fontSize: 25
            ),),
            Text('Muestra una lista completa de productos para editar uno por uno', style: GoogleFonts.roboto(
              color: Colors.black, 
              fontWeight: FontWeight.normal,
              fontSize: 15
            ),),
            ElevatedButton(
              onPressed: () => const EditPage().goScreen(context),
              child: Text('Buscar y editar', style: GoogleFonts.roboto(
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

// Suggested code may be subject to a license. Learn more: ~LicenseLog:958646065.
  readCSVAndConvertToJson() async {

    int progress = 0;

    ProgressDialog pd = ProgressDialog(context: context);

    pd.show(
      hideValue: true,
      max: 50,
      msg: 'Generando archivo...',
      progressBgColor: Colors.transparent,
    );

    try{
    
      final input = html.FileUploadInputElement()..accept = '.csv';
      input.click();
      
      await input.onChange.first;
      final file = input.files?.first;
      if (file == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se seleccionó ningún archivo')),
        );
      }

      progress = progress + 10;
      pd.update(value: progress, msg: 'Leyendo archivo...');
      await Future.delayed(const Duration(milliseconds: 500));

      final reader = html.FileReader();
      reader.readAsText(file!);
      await reader.onLoad.first;

      final csvString = reader.result as String;

      progress = progress + 10;
      pd.update(value: progress, msg: 'Generando datos...');
      await Future.delayed(const Duration(milliseconds: 500));

      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter().convert(csvString);

      if (rowsAsListOfValues.isEmpty) {
        print('El archivo CSV está vacío');
      }

      await FirebaseFirestore.instance.collection('prod').add({
        'rowsAsListOfValues': rowsAsListOfValues
      });
      List<String> headers = List<String>.from(rowsAsListOfValues[0]);
      List<Map<String, dynamic>> jsonList = [];
      
      progress = progress + 10;
      pd.update(value: progress, msg: 'Identificando datos...');
      await Future.delayed(const Duration(milliseconds: 500));

      Map<String, dynamic> rowMap = {};
      for (int i = 1; i < rowsAsListOfValues.length; i++) {
        for (int j = 0; j < headers.length; j++) {
          rowMap[headers[j]] = rowsAsListOfValues[i][j];
        }
        jsonList.add(rowMap);
      }
      
      progress = progress + 10;
      pd.update(value: progress, msg: '${rowMap.length} productos identificados...');
      await Future.delayed(const Duration(milliseconds: 500));

      await FirebaseFirestore.instance.collection('prod').add({
        'test': rowMap
      });

      progress = progress + 10;
      pd.update(value: progress, msg: 'Casi listo...');
      await Future.delayed(const Duration(milliseconds: 500));
    } catch (e) {
      print(e);

      progress = progress + 10;
      pd.update(value: progress, msg: 'Casi listo...');
      await Future.delayed(const Duration(milliseconds: 500));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al leer el archivo CSV: ${e.toString()}')));
  
    }
  }

}
