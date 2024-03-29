
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_rooms/users/user database.dart';

class Roomwishlist extends StatefulWidget {
  //const Roomwishlist({ Key? key }) : super(key: key);
final String roomid;
Roomwishlist({required this.roomid});
  @override
  _RoomwishlistState createState() => _RoomwishlistState(roomid:roomid);
}

class _RoomwishlistState extends State<Roomwishlist> {
   final String roomid;
  _RoomwishlistState({required this.roomid});
    FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference products = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(appBar: AppBar(backgroundColor: Colors.pinkAccent,),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('rooms').doc(roomid).snapshots(),
       // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot snapshot1) {
          
          if (snapshot1.connectionState == ConnectionState.done) 
          {
            
          }
          List wishlist = snapshot1.data['product'];
           return FutureBuilder<QuerySnapshot>(
                future: products.get(),
                builder: (context,snapshot){
                  if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
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
                                if(wishlist.contains(document.id.toString())==true)
                                Image.network((document.data() as dynamic)!['images'][0]),
                                    
                                    //if(wishlist.contains(document.id.toString())==true)
                                  IconButton(onPressed: (){
                                     Database(uid: _auth.currentUser!.uid).addproduct(document.id);
                                  }, icon: Icon(Icons.account_circle,color: Colors.white,)),
                              ],
                            ),
                            if(wishlist.contains(document.id.toString())==true)
                                Text((document.data()as dynamic)!['Name'].toString(),style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                               if(wishlist.contains(document.id.toString())==true)
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
              );
        },
      ),
      
      )
      ,
      
    );
  }
}