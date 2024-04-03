import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/components/my_button.dart';
import 'package:golf_social/components/my_textfield.dart';
import 'package:golf_social/components/constants.dart';
import 'package:golf_social/components/socialmedia_button.dart';
import 'package:logging/logging.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _logger = Logger('LoginPage');
  String errorMessage = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> signUserIn() async {
    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(color: primaryLimeGreen),
          );
        },
        fullscreenDialog: true,
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Dismiss the loading dialog on successful sign-in
      navigatorKey.currentState?.pop();
    } on FirebaseAuthException catch (e) {
      _logger.severe('FirebaseAuthException caught: ${e.code}');

      // Dismiss the loading dialog on error
      navigatorKey.currentState?.pop();
      if (e.code == 'user-not-found') {
        userNotFoundMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      } else if (e.code == 'too-many-requests') {
        tooManyRequestsMessage();
      } else if (e.code == 'invalid-credential') {
        invalidCredentialMessage();
      }
    }
  }

  void invalidEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Invalid Email'),
          content: const Text(
              'The email address is not valid. Please check the email and try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void userNotFoundMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('User Not Found'),
          content: const Text(
              'No user found for the provided email. Please check the email or register a new account.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Wrong Password'),
          content: const Text(
              'The password you entered is incorrect. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void invalidCredentialMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Authentication Failed'),
          content: const Text(
              'Sorry, your email or password is incorrect. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void tooManyRequestsMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Too Many Requests'),
          content: const Text(
              'You have attempted to sign in too many times. Please wait a while before trying again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGrey,
      body: Container(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Padding(
                padding: const EdgeInsets.only(top: 75.0),
                child: SizedBox(
                  width: 300, // Set the width to your liking
                  height: 120, // Set the height to your liking
                  child: Image.asset('lib/images/Logo.png', fit: BoxFit.fill),
                ),
              ),

              const SizedBox(height: 15),

              // welcome back text
              const Text(
                'Welcome back we\'ve missed you!',
                style: TextStyle(color: primaryLimeGreen, fontSize: 16),
              ),

              const SizedBox(height: 25),

              // username text field
              MyTextField(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 25), //SHOW ERROR TEXT HERE IN RED
              //password text field
              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 15),

              //forgot password text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Forgot Password?',
                        style: TextStyle(color: primaryLimeGreen)),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              //sign in button
              MyButton(
                onTap: signUserIn,
                text: 'Sign In',
              ),

              const SizedBox(height: 25),

              // continue with
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Divider(
                      color: primaryLimeGreen,
                      thickness: 1.0,
                    )),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: primaryLimeGreen),
                      ),
                    ),
                    Expanded(
                        child: Divider(
                      color: primaryLimeGreen,
                      thickness: 1.0,
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // social media buttons
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: <Widget>[
                      SocialMediaButton(imagePath: 'lib/images/Google.jpg'),
                      SizedBox(height: 10),
                      SocialMediaButton(imagePath: 'lib/images/Facebook.jpg'),
                      SizedBox(height: 10),
                      SocialMediaButton(imagePath: 'lib/images/Apple.jpg'),
                    ],
                  )),

              const SizedBox(height: 10),

              // Not a member yet? Sign up
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Not a member? ',
                      style: TextStyle(color: primaryLimeGreen)),
                  SizedBox(width: 4),
                  Text('Register Now',
                      style: TextStyle(
                          color: primaryLimeGreen,
                          fontWeight: FontWeight.bold)),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
