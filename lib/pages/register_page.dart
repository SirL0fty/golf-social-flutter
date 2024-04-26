import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/components/my_button.dart';
import 'package:golf_social/components/my_textfield.dart';
import 'package:golf_social/components/constants.dart';
import 'package:golf_social/components/socialmedia_button.dart';
import 'package:golf_social/components/custom_text_button.dart';
import 'package:golf_social/pages/home_page.dart';
import 'package:golf_social/pages/login_page.dart';
import 'package:golf_social/services/auth_service.dart';
import 'package:logging/logging.dart';
import 'package:golf_social/components/snackbar.dart';

class RegisterPage extends StatefulWidget {
  final void Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _logger = Logger('RegisterPage');
  String errorMessage = '';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final fullNameController = TextEditingController();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  // show error message to user
  void showErrorMessage(String message) {
    showSnackBar(scaffoldMessengerKey.currentContext!, message);
  }

  Future<void> signUserUp() async {
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
      //Check if full name is empty
      if (fullNameController.text.isEmpty) {
        showErrorMessage('Please enter your full name.');
        return;
      }
      // Check if email is empty
      if (emailController.text.isEmpty) {
        showErrorMessage('Please enter your email address.');
        return;
      }
      // Check if email is valid
      bool isValidEmail(String email) {
        final RegExp regex =
            RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
        return regex.hasMatch(email);
      }

      if (!isValidEmail(emailController.text)) {
        showErrorMessage('Please enter a valid email address.');
        return;
      }

      // Check if password is empty
      if (passwordController.text.isEmpty) {
        showErrorMessage('Please enter a password.');
        return;
      }
      // Check if confirm password is empty
      if (confirmPasswordController.text.isEmpty) {
        showErrorMessage('Please confirm your password.');
        return;
      }
      // Check if password matches
      if (passwordController.text != confirmPasswordController.text) {
        // show error message
        showErrorMessage(
            'The passwords you entered do not match. Please try again.');
      } else {
        UserCredential userCredential = await AuthService().signUp(
          fullName: fullNameController.text,
          email: emailController.text,
          password: passwordController.text,
        );

        // Update the user profile with the full name
        await userCredential.user?.updateDisplayName(fullNameController.text);

        // Navigate to HomePage only if sign-up was successful
        if (userCredential.user != null && mounted) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      }

      // Show a success SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      _logger.severe('FirebaseAuthException caught: ${e.code}');
      // Dismiss the loading dialog whether the sign-in was successful or not
      navigatorKey.currentState?.pop();

      if (e.code == 'user-not-found') {
        showErrorMessage(
            'No user found for the provided email. Please check the email or register a new account.');
      } else if (e.code == 'wrong-password') {
        showErrorMessage(
            'The password you entered is incorrect. Please try again.');
      } else if (e.code == 'too-many-requests') {
        showErrorMessage('Too many requests. Try again later.');
      } else if (e.code == 'invalid-credential') {
        showErrorMessage(
            'Sorry, your email or password is incorrect. Please try again.');
      } else {
        showErrorMessage('An error occurred: ${e.message}');
      }
    } catch (e) {
      // Handle any other exceptions
      _logger.severe('Exception caught: $e');
      showErrorMessage('An error occurred: $e');
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    // Define a list of social media platforms
    final List<Map<String, dynamic>> socialMediaPlatformsList = [
      {
        'imagePath': 'lib/images/google_signup_button.png',
        'signInMethod': () async {
          try {
            UserCredential userCredential =
                await AuthService().signInWithGoogle();
            if (userCredential.user != null) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(),
                ),
              );
            }
          } catch (e) {
            // Handle the error here
            showErrorMessage('An error occurred while signing in with Google.');
          }
        },
      },
      // Add more platforms here...
    ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryGrey,
      body: ScaffoldMessenger(
        key: scaffoldMessengerKey,
        child: Container(
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
                  'Register your new account!',
                  style: TextStyle(color: primaryLimeGreen, fontSize: 16),
                ),

                const SizedBox(height: 20),

                // full name text field
                MyTextField(
                  controller: fullNameController,
                  hintText: 'Full Name',
                  obscureText: false,
                ),
                const SizedBox(height: 20),

                // email address text field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email Address',
                  obscureText: false,
                ),
                const SizedBox(height: 20),
                //password text field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                //confirm password text field
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 20),

                //sign in button
                MyButton(
                  onTap: signUserUp,
                  text: 'Create new account',
                ),

                const SizedBox(height: 20),

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

                const SizedBox(height: 20),

                // social media buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    children: socialMediaPlatformsList.map((platform) {
                      return SocialMediaButton(
                        onTap: platform['signInMethod'],
                        imagePath: platform['imagePath'],
                      );
                    }).toList(),
                  ),
                ),

                const SizedBox(height: 10),

                // Not a member yet? Sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(color: primaryLimeGreen)),
                    const SizedBox(width: 4),
                    CustomTextButton(
                        text: 'Login Now',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginPage(
                                onTap: () {},
                              ),
                            ),
                          );
                        },
                        color: primaryLimeGreen,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
