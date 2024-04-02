import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:golf_social/pages/auth_page.dart';
import 'firebase_options.dart';
import 'package:golf_social/components/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primaryColor: primaryGrey,
        scaffoldBackgroundColor: Colors.white,
        dividerColor: primaryGrey,
        buttonTheme: const ButtonThemeData(
          buttonColor: primaryLimeGreen,
          textTheme: ButtonTextTheme.primary,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: primaryLimeGreen,
          selectionColor: primaryLimeGreen,
          selectionHandleColor: primaryLimeGreen,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
