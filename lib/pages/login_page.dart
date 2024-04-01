import 'package:flutter/material.dart';
import 'package:golf_social/components/my_button';
import 'package:golf_social/components/my_textfield.dart';
import 'package:golf_social/components/constants.dart';
import 'package:golf_social/components/socialmedia_button.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryGrey,
      body: Container(
        alignment: Alignment.topCenter,
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
              controller: usernameController,
              hintText: 'Username',
              obscureText: false,
            ),
            const SizedBox(height: 25),
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
                        color: primaryLimeGreen, fontWeight: FontWeight.bold)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
