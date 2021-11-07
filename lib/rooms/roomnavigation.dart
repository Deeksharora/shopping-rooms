import 'package:flutter/material.dart';
import 'package:shopping_rooms/rooms/roomhome.dart';

class Roomnavigation extends StatefulWidget {
  const Roomnavigation({ Key? key }) : super(key: key);

  @override
  _RoomnavigationState createState() => _RoomnavigationState();
}

class _RoomnavigationState extends State<Roomnavigation> {
  int index =0;
  final screens =[
   Roomhome(),

  ];
  //final FirebaseAuth _auth = FirebaseAuth.instance;
 // late User user;
  //bool isloggedin = true;
  @override
  Widget build(BuildContext context) {
  
      return Scaffold(
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        iconSize: 30,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (_index) => setState(() => index = _index),
      
        backgroundColor: Colors.pinkAccent,
        items:<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Color(0xff2FC4B2)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Wishlist',
            backgroundColor: Color(0xff2FC4B2)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
            backgroundColor: Color(0xff2FC4B2)
          ),

          

        ] ),
       body:  screens[index] ,
    );
    
  }
}