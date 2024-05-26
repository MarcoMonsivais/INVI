import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/dashboard/dashboard_page.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/helpers/side_menu.dart';
import 'package:invi/newproduct/newproduct_page.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});
  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.homepage}');
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Bienvenido', 
          style: GoogleFonts.roboto(
            color: Colors.white, 
            fontWeight: FontWeight.bold
            ),
          ),
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown.shade200,
        actions: [

          TextField(
            controller: _searchTextEditingController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          IconButton(
            onPressed: () {
              
            },
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              widget.goScreen(context);
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade200,
        child: const Icon(Icons.add, color: Colors.white,),
        onPressed: () async =>
          const NewProductPage().goScreen(context),
      ),
      body: const SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SideMenu(),
            ),
            Expanded(
              flex: 8,
              child: DashboardPage(),
            ),
          ],
        ),
      ),
    );
  }

}
