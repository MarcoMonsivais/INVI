import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextStyle gfonts = GoogleFonts.roboto();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  PageController pgcontroller = PageController(initialPage: 0);
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Desktop layout
          return Scaffold(
            body: PageView(
              controller: pgcontroller,
              children: [

                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/bg-login.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                          ),
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Iniciar sesión',
                              style: GoogleFonts.roboto(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 105, 45, 5)                      ),
                            ),
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _emailController,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Correo Electronico',
                                ),
                              ),
                            ),
                            // Password text field
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Contraseña',
                                ),
                              ),
                            ),
                            // Login button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () => loginWithFirebase(context, _emailController, _passwordController),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Color.fromARGB(146, 117, 54, 12),
                                ),
                                child: Text(
                                  'Iniciar Sesión',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )
                                ),
                              ),
                            ),
                            // Forgot password link
                            TextButton(
                              onPressed: () {
                                // Handle forgot password logic here
                              },
                              child: Text(
                                'Recuperar contraseña',
                                style: GoogleFonts.roboto(
                                  fontSize: 11.0,
                                )
                              ),
                            ),
                            TextButton(
                              onPressed: () => pgcontroller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              child: Text(
                                'Crear cuenta',
                                style: GoogleFonts.roboto(
                                  fontSize: 11.0,
                                )
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Crear cuenta',
                              style: GoogleFonts.roboto(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 105, 45, 5)                      ),
                            ),
                             Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _emailController,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Correo Electronico',
                                ),
                              ),
                            ),
                            // Password text field
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Contraseña',
                                ),
                              ),
                            ),
                            // Login button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () => createUserWithEmailAndPassword(context, _emailController.text, _passwordController.text),
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  backgroundColor: Color.fromARGB(146, 117, 54, 12),
                                ),
                                child: Text(
                                  'Crear cuenta',
                                  style: GoogleFonts.roboto(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  )
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => pgcontroller.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              ),
                              child: Text(
                                'Iniciar sesión',
                                style: GoogleFonts.roboto(
                                  fontSize: 11.0,
                                )
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: const AssetImage('assets/bg-login.png'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              
              ],
            ),
          );
        } else {
          // Mobile layout
          return Scaffold(
            body: Column(
              children: [
                Image.asset(
                  'assets/bg-login.png',
                  fit: BoxFit.cover,
                ),
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                      ),
                      SizedBox(height: 16.0),
                      // Add your login form here
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> loginWithFirebase(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Navigate to the home page
      Navigator.pushNamed(context, '/home');

    } on FirebaseAuthException catch (e) {
      // Handle login errors
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user found for that email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong password provided.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  Future<void> createUserWithEmailAndPassword(
    BuildContext context,
    String email, 
    String password
  ) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña demasiado débil')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('error en contraseña: ${e.toString()}')),
        );
      if (e.code == 'weak-password'){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña demasiado débil')),
        );
      }
    }
  }

}
