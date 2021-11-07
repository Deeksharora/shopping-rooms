import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';

class Database{


final String uid;
Database({required this.uid});
final CollectionReference data = FirebaseFirestore.instance.collection('course');
 // FirebaseAuth _auth = FirebaseAuth.instance;

Future updateroomdata(List<String> members,List<String>products)
async {
  return await data.doc(uid).set({
  'members':members,
  'products':products
   });
   
} 

updatemembers(List<String> member)async{
  Map<String,dynamic> demoData = {
       'members': member,
     };
     data.doc(uid).update(demoData);
}


}