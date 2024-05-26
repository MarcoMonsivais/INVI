import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/product/showproduct_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

   @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('app/conf/products').get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index].data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  productId = products[index].id;
                  print(productId);
                  const ShowProduct_Page().goScreen(context);
                },
                child: Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    trailing: Image.network(product['image']),
                    title: Text(
                      product['description'],
                      style: GoogleFonts.roboto(),
                    ),
                    subtitle: Text(
                      'Price: \$${product['price']}',
                      style: GoogleFonts.roboto(),
                    ),
                    
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
