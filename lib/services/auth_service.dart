import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthService {
  //Google Sign In
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

// Apple Sign In
signInWithApple() async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName,
    ],
  );

  return await FirebaseAuth.instance.signInWithCredential(
    OAuthProvider('apple.com').credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    ),
  );
}

// Facebook Sign In
signInWithFacebook() async {
  final LoginResult result = await FacebookAuth.instance.login();

  final OAuthCredential credential = FacebookAuthProvider.credential(
    result.accessToken!.token,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
}
