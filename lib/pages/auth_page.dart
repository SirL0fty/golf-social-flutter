import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/pages/home_page.dart';
import 'package:golf_social/pages/login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // If the user is logged in, return the HomePage
              if (snapshot.hasData) {
                return HomePage();
              }
              // If the user is not logged in, return the LoginPage
              else {
                return const LoginOrRegisterPage();
              }
            }));
  }
}
