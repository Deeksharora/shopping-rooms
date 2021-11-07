import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Database{

final String uid;
Database({required this.uid});
final CollectionReference data = FirebaseFirestore.instance.collection('users');
  //FirebaseAuth _auth = FirebaseAuth.instance;

Future updateuserdata(String name,List<String>wishlist,List<String>cart)
async {
  return await data.doc(uid).set({
  'name':name,
  'wishlist' : wishlist,
  'cart': cart
   });
   
} 

addproduct(String productid)
{
   Map<String,dynamic> demoData = {
       'wishlist': FieldValue.arrayUnion([productid]),
     };
     
     data.doc(uid).update(demoData);
}
  
}