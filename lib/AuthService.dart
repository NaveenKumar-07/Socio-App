import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();
  final TwitterLogin twitterLogin = new TwitterLogin(
      consumerKey: 'wLnZ9Sh43Oola0LPXD4Axz8Mh',
      //'1220680908346294272-BJOn6NIV1AntpaRcgyfeVEHS53hrr2',
      consumerSecret: 'ygpi1x1hDe1Yg8y78iZoX7PEFz6Z3XdbSNjloLhLntGpWcKFbb'
      //'1Mc7u5BRpMa1cSO6QgwK6XieyXNC6PCK5tjdb1MC3vQt1',
      );

  Future signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final GoogleAuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        User user = (await _auth.signInWithCredential(credential)).user;
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('email', _auth.currentUser.email);
        sharedPreferences.setString('name', _auth.currentUser.displayName);
        sharedPreferences.setString('purl', _auth.currentUser.photoURL);
        print(user.providerData);
      }
    } catch (e) {
      print(e);
    }
  }

  void signInWithTwitter(String token, String secret) async {
    final AuthCredential credential =
        TwitterAuthProvider.credential(accessToken: token, secret: secret);
    User user = (await _auth.signInWithCredential(credential)).user;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.setString('email', _auth.currentUser.email);
    sharedPreferences.setString('name', _auth.currentUser.displayName);
    sharedPreferences.setString('purl', _auth.currentUser.photoURL);
    print(user.providerData);
  }

  void login() async {
    final TwitterLoginResult result = await twitterLogin.authorize();
    String newMessage;
    if (result.status == TwitterLoginStatus.loggedIn) {
      signInWithTwitter(result.session.token, result.session.secret);
    } else if (result.status == TwitterLoginStatus.cancelledByUser) {
      newMessage = 'Login cancelled by user.';
    } else {
      newMessage = result.errorMessage;
    }
  }

  /*void _signInWithTwitter(String token, String secret) async {
    final AuthCredential credential =
        TwitterAuthProvider.credential(accessToken: token, secret: secret);
    await _auth.signInWithCredential(credential);
  }*/

  void logout() async {
    await googleSignIn.signOut();
    await twitterLogin.logOut();
    await facebookLogin.logOut();
    await _auth.signOut();
  }
}