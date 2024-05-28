import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';
import 'package:invi/login/login_page.dart';
import 'package:invi/settings/settings_page.dart';

class ShowProduct_Page extends StatefulWidget {

  const ShowProduct_Page({super.key,});

  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.showproduct}');
  }

  @override
  State<ShowProduct_Page> createState() => _ShowProduct_PageState();
}

class _ShowProduct_PageState extends State<ShowProduct_Page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          productName, 
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
            const SettingsPage().goScreen(context);
          },
        ),
        backgroundColor: Colors.brown.shade200,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.doc('app/conf/products/$productId').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            TextEditingController _descriptionController = TextEditingController(text: snapshot.data!['description']);
            TextEditingController _keyController = TextEditingController(text: snapshot.data!['key']);
            TextEditingController _priceController = TextEditingController(text: snapshot.data!['price'].toString());
            TextEditingController _qntyController = TextEditingController(text: snapshot.data!['qnty'].toString());
            TextEditingController _totalController = TextEditingController(text: snapshot.data!['total'].toString());


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _descriptionController,
                      style: GoogleFonts.roboto(),
                      decoration: const InputDecoration(
                        labelText: 'Descripcion',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _keyController,
                      style: GoogleFonts.roboto(),
                      decoration: const InputDecoration(
                        labelText: 'Clave',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _priceController,
                      style: GoogleFonts.roboto(),
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _qntyController,
                      style: GoogleFonts.roboto(),
                      decoration: const InputDecoration(
                        labelText: 'Cantidad',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _totalController,
                      style: GoogleFonts.roboto(),
                      decoration: const InputDecoration(
                        labelText: 'Total',
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () async {
                      if (_descriptionController.text != snapshot.data!['description'] ||
                          _keyController.text != snapshot.data!['key'] ||
                          _priceController.text != snapshot.data!['price'].toString() ||
                          _qntyController.text != snapshot.data!['qnty'].toString() ||
                          _totalController.text != snapshot.data!['total'].toString()) {
                        await FirebaseFirestore.instance.doc('app/conf/products/$productId').update({
                          'description': _descriptionController.text,
                          'key': _keyController.text,
                          'price': double.parse(_priceController.text),
                          'qnty': int.parse(_qntyController.text),
                          'total': double.parse(_totalController.text),
                        }).then((doc){
                          const HomePage().goScreen(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Producto editado correctamente')),
                          );
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color.fromARGB(146, 117, 54, 12),
                    ),
                    child: Text(
                      'Editar Producto',
                       style: GoogleFonts.roboto(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      )
                    ),
                  ),

                ],
              ),
            );
          } else if (snapshot.hasError) {
            return const Text('Error en cargar catalogo');
          } else {
            return const Text('Cargando información');
          }
        },
      ),
    );
  }

}
