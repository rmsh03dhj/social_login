import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signInWithEmail(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user  = result.user;
      if(user != null)
        return true;
      else
        return false;
    }catch(e){
      return false;
    }
  }

  Future<void> logOut() async{
    try{
      await _auth.signOut();
    }catch(e){
      print("error logging out $e");
    }
}

  /// faced this issue
  /// PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null)
  /// solved with the help of
  /// https://stackoverflow.com/questions/54557479/flutter-and-google-sign-in-plugin-platformexceptionsign-in-failed-com-google/54696963#54696963
  /// answer from KylianMbappe 
  Future<bool> loginWithGoogle() async{
    try{
      GoogleSignIn googleSignIn=GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if(account == null){
        return false;
      }
      AuthResult result = await _auth.signInWithCredential(GoogleAuthProvider.getCredential(
          idToken: (await account.authentication).idToken,
          accessToken: (await account.authentication).accessToken
      ));

      if(result.user == null){
        return false;
      }else{
        return true;
      }
    }catch(e){
      print(e);
      return false;
    }
}
}