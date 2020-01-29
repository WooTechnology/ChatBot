import 'package:eliana_chatbot/router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //google sign-in
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  //google sign-out
  void signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Sign Out");
  }

  //fb login
    bool _isLoggedIn=false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  _loginWithFB() async{

    
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        final graphResponse = await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=${token}');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false );
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false );
        break;
    }

  }

  //_logout(){
    //facebookLogin.logOut();
    //setState(() {
     // _isLoggedIn = false;
   // });
  //}
  

  //ui
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'LOGIN WITH SOCIAL ACCOUNT',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            RaisedButton(
              child: Text(
                "Google",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              color: Colors.red[600],
              onPressed: () {
                signInWithGoogle().whenComplete(() {
                  Navigator.pushReplacementNamed(context, chat_page);
                });
              },
            ),
            RaisedButton(
              child: Text(
                "Facebook",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              color: Colors.blue[600],
              onPressed: () {
                _loginWithFB();
                Navigator.pushReplacementNamed(context, chat_page);
              },
            ),
          ],
        ),
      ),
    );
  }
}
