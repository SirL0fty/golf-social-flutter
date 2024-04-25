import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_social/components/constants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home Page',
          style: TextStyle(color: primaryLimeGreen),
        ),
        backgroundColor: primaryGrey,
        actions: [
          IconButton(
              onPressed: signUserOut,
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
                backgroundImage:
                    user.photoURL != null ? NetworkImage(user.photoURL!) : null,
                radius: 60,
                child: user.photoURL == null
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
              'LOGGED IN AS: ${user.email!}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              'NAME: ${user.displayName ?? 'No name provided'}',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
