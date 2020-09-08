import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookSignIn = new FacebookLogin();

  Future<bool> signUpWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signInWithEmail(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user != null)
        return true;
      else
        return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> emailSignOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("error logging out $e");
    }
  }

  /// faced this issue
  /// PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null)
  /// solved with the help of
  /// https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google/54696963#54696963
  /// answer from KylianMbappe
  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) {
        return false;
      }
      AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken));

      if (result.user == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Null> googleSignOut() async {
    await googleSignIn.signOut();
  }

  Future<bool> signInWithFacebook() async {
    final FacebookLogin facebookSignIn = new FacebookLogin();

    final FacebookLoginResult facebookLoginResult = await facebookSignIn.logIn(['email']);
    if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
      AuthCredential credential =
          FacebookAuthProvider.getCredential(accessToken: facebookLoginResult.accessToken.token);
      AuthResult authResult = await _auth.signInWithCredential(credential);
      if (authResult.user == null) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<Null> facebookSignOut() async {
    await facebookSignIn.logOut();
  }
}
