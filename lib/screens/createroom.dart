
import 'package:flutter/material.dart';
import 'package:shopping_rooms/rooms/roomnavigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_rooms/rooms/update.dart';

class Createroom extends StatefulWidget {
  //const Createroom({ Key? key }) : super(key: key);
final String uid;
Createroom({required this.uid});
  @override
  _CreateroomState createState() => _CreateroomState(uid: uid);
}

class _CreateroomState extends State<Createroom> {
  final String uid;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  _CreateroomState({required this.uid});
  @override
  Widget build(BuildContext context) {
    
    
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
        key: key, 
      
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              SelectableText(uid),
                  

              TextButton(onPressed: () {
                Update(uid: uid).enterroom(_auth.currentUser!.uid);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Roomnavigation()),
                );
              },child: Text("Go!")),
            ],
          ),
        ],
      ),
    );
  }
}