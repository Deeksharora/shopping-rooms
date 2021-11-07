import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';

class Update{


final String uid;
Update({required this.uid});
final CollectionReference data = FirebaseFirestore.instance.collection('rooms');
 // FirebaseAuth _auth = FirebaseAuth.instance;


enterroom(String member)async{
 Map<String,dynamic> demoData = {
       'members': FieldValue.arrayUnion([member]),
     };
     
     data.doc(uid).update(demoData);
}

addproduct(String productid)
{
   Map<String,dynamic> demoData = {
       'product': FieldValue.arrayUnion([productid]),
     };
     
     data.doc(uid).update(demoData);
}
}