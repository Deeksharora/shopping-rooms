
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
     var screenSize = MediaQuery.of(context).size;
    var docid;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          actions: [
            IconButton(onPressed: () {
                                      signOut();
                                    }, icon: Icon(Icons.logout,color: Colors.white))
          ],
        ),
        body: Center(
          child: Container(
            
             child: Column(
               children: [
                    SizedBox(height: 160,),
              Flexible(
                child: Container(
                  width: screenSize.width * 0.75,
                    height: screenSize.height * 0.08,
                  child: Card(
                    color: Colors.pinkAccent,
                    child: TextButton(onPressed: () {
                            DocumentReference docref = FirebaseFirestore.instance.collection('rooms').doc();
                            docref.set({'members': mem,'product': mem});
                            docid = docref.id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Createroom(uid:docid)),
                            );
                          },
                           child: Text("Create Room",style: TextStyle(
                        color: Colors.white,
                       
                        fontSize: 20,
                      ),),),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text('OR',style: TextStyle(color: Colors.pink,fontSize: 20)),
              SizedBox(height: 15,),
              Flexible(
                child: Container(
                  width: screenSize.width * 0.75,
                    height: screenSize.height * 0.08,
                  child: Card(
                    color: Colors.pinkAccent,
                    child: TextButton(onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Roomcode()),
                            );
                          }, child: Text("Enter a Room",style: TextStyle(
                        color: Colors.white,
                        
                        fontSize: 20,
                      ),) ),
                  ),
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

