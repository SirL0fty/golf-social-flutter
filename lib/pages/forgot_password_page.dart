import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/components/my_button.dart';
import 'package:golf_social/components/my_textfield.dart';
import 'package:golf_social/components/constants.dart';
import 'package:golf_social/components/custom_text_button.dart';
import 'package:golf_social/components/snackbar.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;
  const ForgotPasswordPage({super.key, required this.email});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String errorMessage = '';

  late var emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.email);
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> resetPassword() async {
    if (emailController.text.isEmpty) {
      showSnackBar(context, 'Please enter your email address.');
      return;
    }

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      if (mounted) {
        showSnackBar(context, 'Password reset email sent',
            backgroundColor: primaryLimeGreen, textColor: primaryGrey);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An unknown error occurred.';
      }
      if (mounted) {
        showSnackBar(context, 'Error: $message');
      }
    } catch (e) {
      if (mounted) {
        showSnackBar(context, 'Error: $e');
      }
    }
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
                'Reset your password',
                style: TextStyle(color: primaryLimeGreen, fontSize: 16),
              ),
              const SizedBox(height: 25),
              // email text field
              MyTextField(
                controller: emailController,
                hintText: 'Email Address',
                obscureText: false,
              ),
              const SizedBox(height: 25),
              // reset password button
              MyButton(
                onTap: resetPassword,
                text: 'Reset Password',
              ),
              const SizedBox(height: 25),
              // back to login
              CustomTextButton(
                text: 'Back to Login',
                onTap: () {
                  Navigator.of(context).pop(emailController.text);
                },
                color: primaryLimeGreen,
                style: const TextStyle(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
