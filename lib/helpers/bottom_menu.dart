// Suggested code may be subject to a license. Learn more: ~LicenseLog:575553422.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invi/login/login_page.dart';
import 'package:invi/settings/settings_page.dart';

class BottomMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.brown,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      items: [
        BottomNavigationBarItem(
          backgroundColor: Colors.brown.shade200,
          icon: const Icon(Icons.dashboard),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.brown.shade200,
          icon: const Icon(Icons.settings),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.brown.shade200,
          icon: const Icon(Icons.logout),
          label: '',
        ),
        BottomNavigationBarItem(
          backgroundColor: Colors.brown.shade200,
          icon: const Icon(Icons.account_balance_outlined),
          label: '',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            // Navigate to Dashboard
            break;
          case 1:
            // Navigate to Settings
            const SettingsPage().goScreen(context);
            break;
          case 2:
            // Sign out and navigate to Login
            FirebaseAuth.instance.signOut();
            const LoginPage().goScreen(context);
            break;
          case 3:
            // Show About dialog
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
            break;
        }
      },
    );
  }

}
