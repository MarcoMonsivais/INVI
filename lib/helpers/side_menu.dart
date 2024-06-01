import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/login/login_page.dart';
import 'package:invi/settings/settings_page.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    super.key,
  });

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
          // DrawerListTile(
          //   title: "Perfil",
          //   icon: Icons.person,
          //   press: () {},
          // ),
          DrawerListTile(
            title: "Configuración",
            icon: Icons.settings,
            press: () => const SettingsPage().goScreen(context),
          ),
          DrawerListTile(
            title: "Salir de sesión",
            icon: Icons.logout,
            press: () {
              FirebaseAuth.instance.signOut();
              const LoginPage().goScreen(context);
            },
          ),
          DrawerListTile(
            title: "Acerca de",
            icon: Icons.settings,
            press: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Acerca de'),
                  content: Text('Versión 1.00.01\nÚltima actualización: 01/05/2024'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    super.key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.icon,
    required this.press,
  });

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
