// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_rooms/rooms/update.dart';
import 'package:shopping_rooms/rooms/roomnavigation.dart';


class Roomcode extends StatefulWidget {
  //const Roomcode({ Key? key }) : super(key: key);

  @override
  _RoomcodeState createState() => _RoomcodeState();
}

class _RoomcodeState extends State<Roomcode> {
final FirebaseAuth _auth = FirebaseAuth.instance;

 final codecontroller = TextEditingController();
  
   GlobalKey<FormState> _formkey = GlobalKey<FormState>();
String docid='';
late List <String> members;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
          
          child: Column(
            children: [
              Text("Enter room code"),
              TextFormField(decoration: InputDecoration(
                                                           border: InputBorder.none,
                                  fillColor: Colors.grey[300],
                                  filled: true,
                                  hintText: 'Please enter room code'),
                                  controller: codecontroller,
                                  
                                  ),
              //SizedBox(height:20),
              
                  TextButton(onPressed: () {
                    Update(uid: codecontroller.text).enterroom(_auth.currentUser!.uid);
                              Navigator.push(
                               context,
                               MaterialPageRoute(builder: (context) => Roomnavigation(roomid : codecontroller.text)),
                              );
                            },child: Text("Go!"))
                
            ],
          
          ),
          
        ),
      ),
    );
  }
}
