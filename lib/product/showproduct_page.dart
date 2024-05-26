import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/helpers/routes_constants.dart';

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
          'Producto', 
          style: GoogleFonts.roboto(
            color: Colors.white, 
            fontWeight: FontWeight.bold
            ),
          ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        backgroundColor: Colors.brown.shade200,
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.doc('app/conf/products/$productId').get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                TextField(
                  controller: TextEditingController(text: snapshot.data!['description']),
                  style: GoogleFonts.roboto(),
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: snapshot.data!['key']),
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    labelText: 'Key',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: snapshot.data!['image']),
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    labelText: 'Image',
                  ),
                ),
                
                TextField(
                  controller: TextEditingController(text: snapshot.data!['price'].toString()),
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    labelText: 'Price',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: snapshot.data!['qnty'].toString()),
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                  ),
                ),
                TextField(
                  controller: TextEditingController(text: snapshot.data!['total'].toString()),
                  style: GoogleFonts.roboto(),
                  decoration: InputDecoration(
                    labelText: 'Total',
                  ),
                ),

              ],
            );
          } else if (snapshot.hasError) {
            return Text('Error');
          } else {
            return Text('Error');
          }
        },
      ),
    );
  }

}
