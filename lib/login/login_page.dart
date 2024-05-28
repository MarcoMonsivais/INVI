import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invi/helpers/globals_variables.dart';
import 'package:invi/helpers/routes_constants.dart';
import 'package:invi/homepage/home_page.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});
  void goScreen(BuildContext context) {
    context.go('/${RoutesConstants.login}');
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextStyle gfonts = GoogleFonts.roboto();
  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordConfirmationController = TextEditingController();

  bool showPassword = true;
  bool showConfirmationPassword = true;

  PageController pgcontroller = PageController(initialPage: 0);
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          isDesktop = true;
          // Desktop layout
          return Scaffold(
            body: PageView(
              controller: pgcontroller,
              children: [

                Row(
                  children: [
                    Expanded(
                      flex: 6,
                      child: Stack(
                        children: [
                          Container(
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
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              'Inventario San Jose',
                              style: GoogleFonts.roboto(
                                fontSize: 29.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
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
                                obscureText: showPassword,
                                style: gfonts,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword ? Icons.visibility : Icons.visibility_off,
                                  ),  
                                  onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Login button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () => loginWithFirebase(context,),
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
                            /// Nombre
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _nameController,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Nombre',
                                ),
                              ),
                            ),
                            /// Nombre
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _lastNameController,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Apellido',
                                ),
                              ),
                            ),
                            /// Nombre
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _phoneController,
                                style: gfonts,
                                decoration: const InputDecoration(
                                  labelText: 'Teléfono',
                                ),
                              ),
                            ),
                            // Password text field
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _passwordController,
                                obscureText: showPassword,
                                style: gfonts,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  suffixIcon: IconButton(
                                  icon: Icon(
                                    showPassword ? Icons.visibility : Icons.visibility_off,
                                  ),  
                                  onPressed: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Password text field
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: TextFormField(
                                controller: _passwordConfirmationController,
                                obscureText: showConfirmationPassword,
                                style: gfonts,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña',
                                  suffixIcon: IconButton(
                                  icon: Icon(
                                    showConfirmationPassword ? Icons.visibility : Icons.visibility_off,
                                  ),  
                                  onPressed: () {
                                      setState(() {
                                        showConfirmationPassword = !showConfirmationPassword;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // Login button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: ElevatedButton(
                                onPressed: () => createUserWithEmailAndPassword(context),
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
                      child: Stack(
                        children: [
                          Container(
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
                          Positioned(
                            bottom: 20,
                            left: 20,
                            child: Text(
                              'Inventario San Jose',
                              style: GoogleFonts.roboto(
                                fontSize: 29.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              
              ],
            ),
          );
        
        } else {

          return Scaffold(
            body: PageView(
              controller: pgcontroller,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
                          obscureText: showPassword,
                          style: gfonts,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                            ),  
                            onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Login button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () => loginWithFirebase(context,),
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
                
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
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
                      /// Nombre
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _nameController,
                          style: gfonts,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                          ),
                        ),
                      ),
                      /// Nombre
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _lastNameController,
                          style: gfonts,
                          decoration: const InputDecoration(
                            labelText: 'Apellido',
                          ),
                        ),
                      ),
                      /// Nombre
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _phoneController,
                          style: gfonts,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                          ),
                        ),
                      ),
                      // Password text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: showPassword,
                          style: gfonts,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                            icon: Icon(
                              showPassword ? Icons.visibility : Icons.visibility_off,
                            ),  
                            onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Password text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: TextFormField(
                          controller: _passwordConfirmationController,
                          obscureText: showConfirmationPassword,
                          style: gfonts,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            suffixIcon: IconButton(
                            icon: Icon(
                              showConfirmationPassword ? Icons.visibility : Icons.visibility_off,
                            ),  
                            onPressed: () {
                                setState(() {
                                  showConfirmationPassword = !showConfirmationPassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      // Login button
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () => createUserWithEmailAndPassword(context),
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
                )
              
              ],
            ),
          );
        
        }
      },
    );


  }

  Future<void> loginWithFirebase(BuildContext context,) async {
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      const HomePage().goScreen(context);

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

  Future<void> createUserWithEmailAndPassword(BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;

      if(_passwordConfirmationController.text == _passwordController.text){
        await auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((user) async {
          if(user.user != null) {

            await FirebaseFirestore.instance
                .collection('app')
                .doc('conf')
                .collection('users')
                .doc(user.user!.uid)
                .set({
              'mail': _emailController.text,
              'name': '${_nameController.text} ${_lastNameController.text}',
              'phone': _phoneController.text,
              'role': 'user',
              'lastSeen': DateTime.now(),
              'profilepic': 'https://firebasestorage.googleapis.com/v0/b/smile360-3425c.appspot.com/o/test%2FPIC.webp?alt=media&token=8765a72f-b18f-451b-9f59-c11bdd0f91b3',
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Usuario creado exitosamente')),
            );

            const HomePage().goScreen(context);

          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Error en usuario')),
            );
          }
        },
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Las contraseñas no coinciden')),
        );
      }

    } on FirebaseAuthException catch (e) {
      print('Error: ${e.toString()}');
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
