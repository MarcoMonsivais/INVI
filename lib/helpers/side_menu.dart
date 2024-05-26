import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.brown.shade200,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/icono-bg.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: Icons.dashboard,
            press: () {},
          ),
          DrawerListTile(
            title: "Configuración",
            icon: Icons.settings,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon, 
        size: 14,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: GoogleFonts.roboto(
          color: Colors.white, 
          fontSize: 16.0,
          fontWeight: FontWeight.normal
        ),
      ),
    );
  }
}
