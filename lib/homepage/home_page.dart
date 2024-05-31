import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/dashboard/dashboard_page.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/helpers/side_menu.dart';

class HomePage extends StatefulWidget {

  const HomePage({super.key});
  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.homepage}');
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.brown.shade200,
        child: const Icon(Icons.check, color: Colors.white,),
        onPressed: () {},
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(isDesktop)
            const Expanded(
              child: SideMenu(),
            ),
            const Expanded(
              flex: 8,
              child: DashboardPage(),
            ),
          ],
        ),
      ),
    );
  }

}
