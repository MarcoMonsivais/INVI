import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/dashboard/dashboard_page.dart';
import 'package:invi/helpers/bottom_menu.dart';
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Desktop
            if (constraints.maxWidth > 800) {
              return Row(
                children: [
                  const SideMenu(),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: const DashboardPage(),
                    ),
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  const DashboardPage(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomMenu(),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

}
