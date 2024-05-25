import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          // Desktop layout
          return Row(
            children: [
              Expanded(
                flex: 6,
                child: Image.asset(
                  'assets/bg-login.png',
                  fit: BoxFit.cover,
                ),
              ),
              const Expanded(
                flex: 4,
                child: Padding(
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
              ),
            ],
          );
        } else {
          // Mobile layout
          return Column(
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
          );
        }
      },
    );
  }
}
