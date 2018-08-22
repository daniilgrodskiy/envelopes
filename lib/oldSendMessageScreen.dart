// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'main.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class SendMessageScreen extends StatefulWidget {
//   final String fromEmail;

//   SendMessageScreen({this.fromEmail});
  
//   @override
//   _SendMessageScreenState createState() => new _SendMessageScreenState();
// }

// class _SendMessageScreenState extends State<SendMessageScreen> {


//   String title = "";
//   String body = "";
//   String toEmail = "";
  

//   void _addData() {
//     Firestore.instance.runTransaction((Transaction transaction) async{
//       CollectionReference reference = Firestore.instance.collection("messages");
//       await reference.add({
//         "fromEmail" : widget.fromEmail,
//         "title" : title,
//         "body": body,
//         "toEmail": toEmail,

//       });
//     });
//     Navigator.pop(context);
//   }

//   @override
//     void initState() {
//       // TODO: implement initState
//       super.initState();
//       // _dateText = "${_dueDate.month}/${_dueDate.day}/${_dueDate.year}";
//     }

//   @override
//   Widget build(BuildContext context) {
//     return new Material(
//       child: Column(
//         children: <Widget>[
//           Container(
//             color: Colors.blueAccent[400],
//             width: double.infinity,
//             height: MediaQuery.of(context).padding.top,
//           ),
//           Container(
//             height: 150.0,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blueAccent[200]
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   "Send Message",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontFamily: "avenir-next",
//                     fontWeight: FontWeight.bold,
//                     fontSize: 40.0
//                   ),
//                 ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(top: 30.0),
//                 //   child: Text("Send Message", style: TextStyle(
//                 //     fontSize: 20.0, color: Colors.white),),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 20.0),
//                   child: Icon(FontAwesomeIcons.envelope, color: Colors.white, size: 30.0,),
//                 ),
//               ],
//             ),
//           ),
//           Column(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   onChanged: (String str) {
//                     setState(() {
//                       toEmail = str;
//                     });
//                   },
//                   decoration: InputDecoration(
//                     icon: Icon(FontAwesomeIcons.solidUserCircle),
//                     border: InputBorder.none,
//                     labelText: "To:",
//                     /**
//                      * 
//                      * Should I change the colors of the label when a user clicked inside of it? Keep it same color? Keep its colors similar to the theme?
//                      * 
//                      **/
//                     // labelStyle: new TextStyle(color: Colors.grey[800]),
//                   ),
//                   style: TextStyle(fontSize: 15.0, color: Colors.black),
//                 ),
//               ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//             child: Divider(),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               onChanged: (String str) {
//                 setState(() {
//                   title = str;
//                 });
//               },
//               decoration: InputDecoration(
//                 icon: Icon(FontAwesomeIcons.sadCry),
//                 labelText: "When should this message be opened?",
//                 border: InputBorder.none
//               ),
//               style: TextStyle(fontSize: 15.0, color: Colors.black),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//             child: Divider(),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: TextField(
//               keyboardType: TextInputType.multiline,
//               maxLines: 6,
//               onChanged: (String str) {
//                 setState(() {
//                   body = str;
//                 });
//               },
//               decoration: InputDecoration(
//                 icon: Icon(FontAwesomeIcons.stickyNote),
//                 labelText: "Body of message",
//                 border: InputBorder.none
//               ),
//               style: TextStyle(fontSize: 15.0, color: Colors.black),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(0.0, 0.0, 100.0, 0.0),
//             child: Divider(),
//           ),
          
//           Padding(
//             padding: const EdgeInsets.only(top: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 IconButton(
//                   icon: Icon(Icons.close, size: 40.0,),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.check, size: 40.0,),
//                   onPressed: () {
//                     _addData();
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//         ),
//         ],
//       ),
//     );
//   }
// }