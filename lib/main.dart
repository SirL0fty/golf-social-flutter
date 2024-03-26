import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      home: FutureBuilder(
        future: Future.delayed(
            const Duration(seconds: 3)), // Change the delay as needed
        builder: (context, AsyncSnapshot snapshot) {
          // Show the splash screen while waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/background.jpeg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            // Navigate to a new screen when done waiting
            return Scaffold(
              appBar: AppBar(
                title: const Text('GolfSocial.'),
                centerTitle: true,
                backgroundColor: Colors.lightGreen[900],
              ),
              backgroundColor: Colors.white,
              body: const Center(
                child: Text(
                  'Welcome to the app!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
