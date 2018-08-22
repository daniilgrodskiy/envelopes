// import 'dart:async';
// import 'package:envelopes_flutter/sendMessageScreen.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'main.dart';



// class Home extends StatefulWidget {
//   //we need to get the user as well as the current status of the sign in
//   Home({this.user, this.googleSignIn});

//   final FirebaseUser user;
//   final GoogleSignIn googleSignIn;

//   @override
//   _HomeState createState() => new _HomeState();
// }

// class _HomeState extends State<Home> {

//   void _signOut() {
//     AlertDialog alertDialog = AlertDialog(
//       content: Container(
//         height: 280.0,
//         child: Column(
//           children: <Widget>[
//             ClipOval(
//               child: Image.network(widget.user.photoUrl),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Text(
//                 "Are you sure you want to sign out?",
//                 style: TextStyle(
//                   fontSize: 16.0
//                 ),
//               ),
//             ),
//             Divider(),
//             Padding(padding: EdgeInsets.only(bottom: 10.0),),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: <Widget>[
//                 InkWell(
//                   onTap: () {
//                     widget.googleSignIn.signOut();
//                     Navigator.of(context).push(
//                       MaterialPageRoute(
//                         builder: (BuildContext context) => LoginPage()
//                       ),
//                     );
//                   },
//                    child: Container(
//                      padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//                     // decoration: BoxDecoration(
//                     //   color: Colors.blue,
//                     //   borderRadius: BorderRadius.circular(5.0),
//                     //   boxShadow: [
//                     //     BoxShadow(
//                     //       color: Colors.black38,
//                     //       //spreadRadius: 10.0,
//                     //       blurRadius: 15.0
//                     //     ),
//                     //   ],
//                     // ),
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.check, color: Colors.black,),
//                         Padding(
//                           padding: EdgeInsets.all(5.0),
//                         ),
//                         Text(
//                           "Yes",
//                           style: TextStyle(color: Colors.black),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Container(
//                     padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
//                     child: Column(
//                       children: <Widget>[
//                         Icon(Icons.close),
//                         Padding(
//                           padding: EdgeInsets.all(5.0),
//                         ),
//                         Text("Cancel"),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );

//     showDialog(
//       context: context,
//       child: alertDialog,
//     );
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           print("Pressed floating action button");
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (BuildContext context) =>
//                 SendMessageScreen(
//                  fromEmail: widget.user.email,
//                 ),
//             ),
//           );
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       // bottomNavigationBar: new BottomAppBar(
//       //   elevation: 20.0,
//       //   color: Colors.blue,
//       //   child: ButtonBar(
//       //     children: <Widget>[
//       //     ],
//       //   ),
//       // ),
//       appBar: AppBar(
//         backgroundColor: Colors.blueAccent,
//         elevation: 0.0,
//         title: Text(
//           "Envelopes",
//           style: TextStyle(
//             fontFamily: "avenir-next",
//             fontWeight: FontWeight.bold
//           ),
//         ),
//       ),
//       body: Stack(
//         children: <Widget>[
//           Padding(
//             padding: const EdgeInsets.only(top: 100.0),
//             child: StreamBuilder(
//               stream: Firestore.instance
//               .collection("messages")
//               .where("toEmail", isEqualTo: widget.user.email)
//               .snapshots(),

//               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Container(
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   );
//                 }
//                 return EnvelopeList(document: snapshot.data.documents,);
//               },
//             ),
//           ),
//           new Container(
//             height: 90.0,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: Colors.blueAccent,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black45,
//                   blurRadius: 8.0
//                 ),
//               ]
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Row(
//                     //mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Container(
//                         width: 40.0,
//                         height: 40.0,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: NetworkImage(widget.user.photoUrl),
//                             fit: BoxFit.cover
//                           ),
//                         ),
//                       ),
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.only(left: 18.0),
//                           child: Column(
//                             //mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               Text(
//                                 "Welcome",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18.0
//                                 ),
//                               ),
//                               Text(
//                                 widget.user.displayName,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 24.0
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.exit_to_app, 
//                           color: Colors.white,
//                           size: 30.0,
//                         ),
//                         onPressed: _signOut,
//                       ),
//                     ],
//                   ),
//                 ),
//                 // Text(
//                 //   "My Task",
//                 //   style: TextStyle(
//                 //     color: Colors.white,
//                 //     fontSize: 40.0,
//                 //     fontFamily: "avenir-next",
//                 //     fontWeight: FontWeight.bold
//                 //     //letterSpacing: 2.0,
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EnvelopeList extends StatelessWidget {
//   EnvelopeList({this.document});
//   final List<DocumentSnapshot> document;

//   @override
//   Widget build(BuildContext context) {

//     //title - title of message
//     //body - body of message
//     //fromEmail - who it's from
//     //toEmail - who it's going to

//     return new ListView.builder(
//       itemCount: document.length,
//       itemBuilder: (BuildContext context, int i){

//         String title = document[i].data['title'].toString();
//         String body = document[i].data['body'].toString();
//         String fromEmail = document[i].data['fromEmail'].toString();

//         // DateTime _date = document[i].data['dueDate'];
//         // String dueDate = "${_date.month}/${_date.day}/${_date.year}";

//         // print("_date:  $_date");
//         // print("dueDate: $dueDate");

        
        
//         return Stack(
//           children: <Widget>[
//             // Container(
//             //   color: Colors.red,
//             //   height: 150.0,
//             // ),
//             Dismissible(
//               key: Key(document[i].documentID),
//                 onDismissed: (direction){
//                   Firestore.instance.runTransaction((Transaction transaction) async{
//                     DocumentSnapshot snapshot = await transaction.get(document[i].reference);
//                     await transaction.delete(snapshot.reference);
//                   });
//                   Scaffold.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text("Data Deleted"),
//                       backgroundColor: Colors.red[400],
//                     )
//                   );
//                 },
//               child: Container(
//                 // color: Colors.white,
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     Expanded(
//                       child: Container(
//                         padding: EdgeInsets.fromLTRB(16.0, 8.0, 0.0, 3.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Text(
//                               title, 
//                               style: TextStyle(
//                                 fontSize: 20.0, 
//                                 fontWeight: FontWeight.bold
//                               ),
//                             ),
//                             Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                     padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 10.0),
//                                     child: Text(
//                                       body, style: TextStyle(fontSize: 18.0),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 Text(
//                                   "From: ", 
//                                   style: TextStyle(
//                                     fontSize: 10.0, 
//                                     fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                                 Text(
//                                   fromEmail, 
//                                   style: TextStyle(
//                                     fontSize: 10.0, 
//                                     // fontWeight: FontWeight.bold
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Divider()
//                           ],
//                         ),
//                       ),
//                     ),
//                     // IconButton(
//                     //   icon: Icon(Icons.edit, color: Colors.blue[900],),
//                     //   onPressed: () {
//                     //     // Navigator.of(context).push(MaterialPageRoute(
//                     //     //   builder: (BuildContext context) => EditTask(
//                     //     //     title: title,
//                     //     //     body: body,
//                     //     //     dueDate: document[i].data['dueDate'],
//                     //     //     //^DONT CONVERT TO STRING VIA .toString() LIKE YOU WOULD USUALLY DO
//                     //     //     index: document[i].reference,
//                     //     //   )
//                     //     // ));
//                     //   },
//                     // )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }