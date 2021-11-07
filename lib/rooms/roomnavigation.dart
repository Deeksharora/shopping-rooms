import 'package:flutter/material.dart';
import 'package:shopping_rooms/rooms/room%20wishlist.dart';
import 'package:shopping_rooms/rooms/roomhome.dart';

class Roomnavigation extends StatefulWidget {
  //const Roomnavigation({ Key? key }) : super(key: key);
final String roomid;
  Roomnavigation({required this.roomid});
  @override
  _RoomnavigationState createState() => _RoomnavigationState(roomid: roomid);
}

class _RoomnavigationState extends State<Roomnavigation> {
  final String roomid;
  _RoomnavigationState({required this.roomid});
  int index =0;

  //final FirebaseAuth _auth = FirebaseAuth.instance;
 // late User user;
  //bool isloggedin = true;
  @override
  Widget build(BuildContext context) {
  final screens =[
   Roomhome(roomid: roomid),
   Roomwishlist(roomid: roomid)

  ];
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
            icon: Icon(Icons.chat),
            label: 'Chat',
            backgroundColor: Color(0xff2FC4B2)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
            backgroundColor: Color(0xff2FC4B2)
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
            backgroundColor: Color(0xff2FC4B2)
          ),

          

        ] ),
       body:  screens[index] ,
    );
    
  }
}