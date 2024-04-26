import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/components/constants.dart';
import 'package:golf_social/pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  void signUserOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => LoginPage(
          onTap: () {},
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (user == null) {
      // No user is signed in, navigate to LoginPage
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(
              onTap: () {},
            ),
          ),
        );
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: primaryLimeGreen),
        ),
        backgroundColor: primaryGrey,
        actions: [
          IconButton(
              onPressed: () => signUserOut(context),
              icon: const Icon(Icons.logout, color: primaryLimeGreen, size: 30))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: primaryGrey,
                  width: 6,
                ),
              ),
              child: CircleAvatar(
                backgroundColor: primaryLimeGreen,
                backgroundImage: user?.photoURL != null
                    ? NetworkImage(user!.photoURL!)
                    : null,
                radius: 60,
                child: user?.photoURL == null
                    ? const Icon(
                        Icons.account_circle,
                        size: 120,
                        color: primaryGrey,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'LOGGED IN AS: ${user?.email ?? 'No email'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              'NAME: ${user?.displayName ?? 'No name provided'}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
