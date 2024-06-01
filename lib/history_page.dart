import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';

class HistoryPage extends StatefulWidget {

  const HistoryPage({super.key});
  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.history}');
  }

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Historial', 
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
      body: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('/app/conf/users/${FirebaseAuth.instance.currentUser!.uid}/daytoday')
              .doc('${DateTime.now().toString().substring(0,10)}')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    'Articulos vendidos',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: ListView.builder(
                        itemCount: snapshot.data!['products'].length,
                        itemBuilder: (context, index) {
                          return Text(snapshot.data!['products'][index], style: GoogleFonts.roboto(
                            fontWeight: FontWeight.normal,
                          ),);
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
    );

  }

}
