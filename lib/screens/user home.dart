
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:shopping_rooms/screens/createroom.dart';
// ignore: unused_import
import 'package:shopping_rooms/screens/roomcode.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   final FirebaseAuth _auth = FirebaseAuth.instance;
   late User user;
   List<String>mem=[''];
  bool ch=true;
  String name='';
  String id='';
    final CollectionReference data = FirebaseFirestore.instance.collection('rooms');
    final CollectionReference products = FirebaseFirestore.instance.collection('products');


 getUser() async {
    User? firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser!;
      });
    }
  }
   signOut() async {
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
        ),
        body: Center(
          child: Container(
            
             child: Column(
               children: [
                    SizedBox(height: 40,),
              Flexible(
                child: Container(
                  
                  child: TextButton(onPressed: () {
                          DocumentReference docref = FirebaseFirestore.instance.collection('rooms').doc();
                          docref.set({'members': mem,'product': mem});
                          var docid = docref.id;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Createroom(uid:docid)),
                          );
                        },
                         child: Text("Create Room") ),
                ),
              ),
              Flexible(
                child: Container(
                  
                  child: TextButton(onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Roomcode()),
                          );
                        }, child: Text("Enter a Room") ),
                ),
              ),
                    Container(child: SizedBox(height: 20,),color: Colors.black,),
               ],
             )
  
          ),
        ),
      ),
      

      
    );
  }
}

