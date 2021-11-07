import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Roomhome extends StatefulWidget {
  const Roomhome({ Key? key }) : super(key: key);

  @override
  _RoomhomeState createState() => _RoomhomeState();
}

class _RoomhomeState extends State<Roomhome> {
  final CollectionReference data = FirebaseFirestore.instance.collection('rooms');
    final CollectionReference products = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pinkAccent,
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
                            Image.network((document.data() as dynamic)!['images'][0]),
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