import 'dart:async';
import 'package:envelopes_flutter/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  //Lengua - Spanish Grammar App
  
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lengua',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "avenir-next"
      ),
      home: new LoginPage(),
      routes: {
        // "/generalTopicsPage": (context) => GeneralTopicsPage(),
         "/loginPage": (context) => LoginPage(),
        //might not work right now because the "googleSignIn" paramter might be useful later on
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();

  Future<FirebaseUser> _signIn() async {

    GoogleSignInAccount googleSignInAccount = 
      await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = 
      await googleSignInAccount.authentication;

    FirebaseUser firebaseUser = await firebaseAuth.signInWithGoogle(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => 
        new Home(
          user: firebaseUser, 
          googleSignIn: googleSignIn
        ),
      ),
    );
  } 

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      TextEditingController userController;
      TextEditingController passwordController;
    }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: AppBar(
      //   title: Text("Flutter Test"),
      // ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.orange[300],
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xFF53c7f0),
              Color(0xFF1d97c1), 
            ]
          )
          // image: DecorationImage(
          //   image: AssetImage("assets/wallpaper.jpg"),
          //   fit: BoxFit.cover
          // )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            Column(
              children: <Widget>[
                // Container(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Image.asset(
                //     "assets/spanish_flag.png",
                //     width: 100.0,
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 90.0, 0.0, 0.0),
                  child: Text(
                    "Envelopes",
                    style: TextStyle(
                      fontFamily: "avenir-next",
                      fontWeight: FontWeight.bold,
                      fontSize: 75.0,
                      // color: Colors.deepOrange[900]
                      color: Colors.white
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                  child: Text(
                    "Send an envelope, not an email.",
                  ),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [BoxShadow(
                  color: Colors.black12,
                  blurRadius: 50.0,
                  spreadRadius: 2.0
                ),]
              ),
              margin: EdgeInsets.all(16.0),
              // padding: EdgeInsets.all(16.0),
              // color: Colors.orange,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                    child: new Theme(
                      data: new ThemeData(
                        primaryColor: Colors.blue[200],
                        // accentColor: Colors.orange[900],
                        hintColor: Colors.grey[800]
                      ),
                      child: new TextField(
                        decoration: new InputDecoration(
                          // hintText: "Enter your email",
                          labelText: "Email",
                          labelStyle: new TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                    child: new Theme(
                      data: new ThemeData(
                        // primaryColor: Colors.amber[200],
                        primaryColor: Colors.blue[200],
                        // accentColor: Colors.orange[900],
                        hintColor: Colors.grey[800]
                      ),
                      child: new TextField(
                        decoration: new InputDecoration(
                          // hintText: "Enter your password",
                          labelText: "Password",
                          labelStyle: new TextStyle(color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          border: Border.all(
                            color: Colors.blue[50]
                          ),
                          borderRadius: BorderRadius.circular(50.0)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Divider(color: Colors.grey[800],),
            // ),
            
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: InkWell(
                onTap: () => _signIn(),
                child: Image.asset(
                  "assets/google_sign_in.png",
                  width: 200.0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}