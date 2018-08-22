import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';
// import 'package:random_pk/random_pk.dart';

class RandomColor {
  //from random_pk 0.0.3 library
  static final Random _random = new Random();

  /// Returns a random color.
  static Color next() {
    return new Color(0xFF000000 + _random.nextInt(0x00FFFFFF));
  }
}

class SendMessageScreen extends StatefulWidget {
  final String fromEmail;

  SendMessageScreen({this.fromEmail});
  
  @override
  _SendMessageScreenState createState() => new _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {

  @override
  void initState() {
    super.initState();
    getFaceIcon();
  }

  Widget dividerLine = 
    Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      child: Divider(
        color: Colors.blue[200],
      ),
    );

  List<IconData> listOfFaceIcons = [
    FontAwesomeIcons.sadCry,
    FontAwesomeIcons.sadTear,
    FontAwesomeIcons.smile,
    FontAwesomeIcons.smileWink,
    FontAwesomeIcons.grinHearts,
  ];

  var faceIcon = FontAwesomeIcons.sadCry;

  void getFaceIcon() {
    setState(() {
      faceIcon = listOfFaceIcons[Random().nextInt(listOfFaceIcons.length)];
    });
  }


  String title = "";
  String body = "";
  String toEmail = "";
  String selectedEnvelopeColor = "assets/defaultEnvelope.png";
  
  

  void _addData() {
    Firestore.instance.runTransaction((Transaction transaction) async{
      CollectionReference reference = Firestore.instance.collection("messages");
      await reference.add({
        "fromEmail" : widget.fromEmail,
        "title" : title,
        "body": body,
        "toEmail": toEmail,
        "selectedEnvelopeColor": selectedEnvelopeColor,

      });
    });
    Navigator.pop(context);
  }

  Widget createEnvelope(String asset) {
    return GestureDetector(
      onTap: (){
        setState(() {
          selectedEnvelopeColor = asset;                
        });
      },
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              asset
            ),
          ),
          selectedEnvelopeColor == asset 
          ?
            Container(
              margin: EdgeInsets.only(left: 130.0),
              alignment: Alignment.topRight,
              child: Icon(
                FontAwesomeIcons.checkCircle,
                color: Colors.blue,
                size: 50.0,
              ),
            )
          :
            Container(
              height: 0.0,
              width: 0.0,
            ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Send Envelope"),
            // expandedHeight: 100.0,
            pinned: true,
          ),
          SliverPadding(
//To:
              padding: EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: (String str) {
                          setState(() {
                            toEmail = str;
                          });
                        },
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.solidUserCircle),
                          border: InputBorder.none,
                          labelText: "To:",
                          /**
                           * 
                           * Should I change the colors of the label when a user clicked inside of it? Keep it same color? Keep its colors similar to the theme?
                           * 
                           **/
                          // labelStyle: new TextStyle(color: Colors.grey[800]),
                        ),
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(left: 0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return dividerLine;
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverPadding(
//Title/Condition:
              padding: EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        
                        onChanged: (String str) {
                          setState(() {
                            title = str;
                          });
                        },
                        decoration: InputDecoration(
                          icon: Icon(faceIcon),
                          labelText: "When should this message be opened?",
                          border: InputBorder.none,
                          
                        ),
                        style: TextStyle(
                          fontSize: 15.0, color: Colors.black,
                          
                        ),
                        
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return dividerLine;
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
//Body
              padding: EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                        onChanged: (String str) {
                          setState(() {
                            body = str;
                          });
                        },
                        decoration: InputDecoration(
                          icon: Icon(FontAwesomeIcons.stickyNote),
                          labelText: "Body of message",
                          border: InputBorder.none
                        ),
                        style: TextStyle(fontSize: 15.0, color: Colors.black),
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
             SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return dividerLine;
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
//Body
              padding: EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0, 0.0),                   
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.palette,
                            color: RandomColor.next(),
                            //to make it only one color, you can probably get away with calling RandomColor.next() in initState() or something and assigning it to a variable
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Select a color:"
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
           
            
            SliverPadding(
//Envelope color
              padding: EdgeInsets.all(0.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      height: 140.0,
                      padding: const EdgeInsets.all(16.0),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          createEnvelope("assets/defaultEnvelope.png"),
                          createEnvelope("assets/yellowEnvelope.png"),
                          createEnvelope("assets/redEnvelope.png"),
                          createEnvelope("assets/orangeEnvelope.png"),
                          createEnvelope("assets/greenEnvelope.png"),
                          createEnvelope("assets/purpleEnvelope.png"),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return dividerLine;
                },
                childCount: 1,
              ),
            ),
            SliverPadding(
//Cancel/Send:
              padding: EdgeInsets.only(left: 10.0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Container(
                      alignment: FractionalOffset.center,
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          
                          GestureDetector(
                            onTap: () {
                              _addData();
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 20.0),
                              child: Container(
                                width: 300.0,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  border: Border.all(
                                    color: Colors.blue[50]
                                  ),
                                  borderRadius: BorderRadius.circular(50.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Send",
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Icon(
                                            FontAwesomeIcons.longArrowAltRight, color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 1,
                ),
              ),
            ),
            
        ],
      ),
    );
  }
}

//  children: <Widget>[
//                   Container(
//                     color: Colors.blueAccent[400],
//                     width: double.infinity,
//                     height: MediaQuery.of(context).padding.top,
//                   ),
//                   Container(
//                     height: 150.0,
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       color: Colors.blueAccent[200]
//                     ),
//                     child: 
//                   Column(
//                     children: <Widget>[
                      
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//                     child: Divider(),
//                   ),
                  
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//                     child: Divider(),
//                   ),
                  
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//                     child: Divider(),
//                   ),

                  
                 
//                 ],
//                 ),
//                 ],