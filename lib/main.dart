import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'router.dart' as router;
const String FACTS_DIALOGFLOW = "FACTS_DIALOGFLOW";

import 'router.dart' as router;

const String FACTS_DIALOGFLOW = "FACTS_DIALOGFLOW";

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

void signOutGoogle() async{
  await googleSignIn.signOut();

  print("User Sign Out");
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ELIANA CHATBOT',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
       debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Login Page'),
      onGenerateRoute: router.generateRoute,
      initialRoute: '/',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) { 
    return Scaffold(
      
      
      //appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(widget.title),
      //),
      body: Center(
        
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            
            
            //SizedBox(height: 20),
            TextField(
                obscureText: true,
                  decoration: InputDecoration(
                  
                  border: OutlineInputBorder(),
                    labelText: 'Username/Email/Phone',
                    
              ),
            ),
            SizedBox(height: 15),
            TextField(
                obscureText: true,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(),
                    labelText: 'Password',
              ),
            ),

        
        SizedBox(height: 15),
        new Container(
    child: new Row(

      children: <Widget>[
        SizedBox(width: 110),
      new RaisedButton(
        child: new Text("LOGIN"),
        color:  Colors.blueAccent[600],
        onPressed: () => Navigator.pushNamed(context, FACTS_DIALOGFLOW),
        ),

      SizedBox(width: 15),
      new RaisedButton(
        child: new Text("SIGNUP"),
        color:  Colors.blueAccent[600],
        onPressed: () {},
        ),


      ],
    ),
  ),
          SizedBox(height: 40),
         Text('LOGIN WITH SOCIAL ACCOUNT', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize:18),), 
     SizedBox(height: 15),
      new RaisedButton(
        child: new Text("Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:18),),
        color:  Colors.red[600],
        onPressed: () {
          signInWithGoogle().whenComplete(() {
           Navigator.pushNamed(context, FACTS_DIALOGFLOW);
        });
      },
    ),
       
  
          ],
        ),
      ),
    );
  }
}
