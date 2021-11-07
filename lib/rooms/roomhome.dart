import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_rooms/rooms/update.dart';
import 'package:shopping_rooms/screens/navigation.dart';
import 'package:shopping_rooms/screens/user%20home.dart';
class Roomhome extends StatefulWidget {
  //const Roomhome({ Key? key }) : super(key: key);
final String roomid;
Roomhome({required this.roomid});
  @override
  _RoomhomeState createState() => _RoomhomeState(roomid: roomid);
}

class _RoomhomeState extends State<Roomhome> {
  final String roomid;
  _RoomhomeState({required this.roomid});
  final CollectionReference data = FirebaseFirestore.instance.collection('rooms');
    final CollectionReference products = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
          actions: [
            IconButton(onPressed: (){
              Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => NavigationScreen()),
                          );
            }, icon: Icon(Icons.logout,color: Colors.white,))
          ],
        ),
        body: Center(
          child: Container(
            

              child:FutureBuilder<QuerySnapshot>(
                future: products.get(),
                builder: (context,snapshot){
                  if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
                    
              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Expanded(
                child: Card(
                  
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Image.network((document.data() as dynamic)!['images'][0]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(onPressed: (){
                                      Update(uid: roomid).addproduct(document.id);
                                    }, icon: Icon(Icons.favorite,color: Colors.white,)),
                                    IconButton(onPressed: (){}, icon: Icon(Icons.share,color: Colors.white,)),
                                  ],
                                )
                                ]),
                                
                                Text((document.data()as dynamic)!['Name'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                Text((document.data()as dynamic)!['price'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                              ],
                            ),
                          
                        ),
                      );
                    
                  }).toList(),
                );
              }
                    
              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
                },
              )
  
          ),
        ),
      ),
      

      
    );
  }
}