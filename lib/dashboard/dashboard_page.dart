import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/product/showproduct_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  TextEditingController _searchController = TextEditingController();
  Future<QuerySnapshot<Map<String, dynamic>>> products = FirebaseFirestore.instance.collection('app/conf/products').get();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              prefixIcon: const Icon(Icons.search),
              hintText: 'Buscar producto',
              hintStyle: GoogleFonts.roboto(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onChanged: (value) {
              String upperValue = value.toUpperCase();
              if(value.isEmpty){
                setState(() {
                  products = FirebaseFirestore.instance.collection('app/conf/products').get();
                });
              } else {
                setState(() {
                  products = FirebaseFirestore.instance.collection('app/conf/products')                
                  .where('key', isGreaterThanOrEqualTo: upperValue)
                  .where('key', isLessThan: upperValue + 'z')
                  .get();
                });
              }
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<QuerySnapshot>(
            future: products,
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
                        productName = product['key'].toString();
                        const ShowProduct_Page().goScreen(context);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // trailing: Image.network(product['image']),
                          trailing: Text(
                            product['key'],
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
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
                return const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
