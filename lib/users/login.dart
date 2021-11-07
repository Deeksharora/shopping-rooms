import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:shopping_rooms/screens/navigation.dart';
import 'package:shopping_rooms/users/sign up.dart';
import 'package:google_sign_in/google_sign_in.dart';
// ignore: unused_import
import 'package:shopping_rooms/users/user database.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

final FirebaseAuth _auth = FirebaseAuth.instance;
final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

String email='',password='';

checkAuthentication() async{
  _auth.authStateChanges().listen((user) { 
    if(user!=null)
    {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) => NavigationScreen()));
    }

  });
}
@override
void initState()
{
  super.initState();
  this.checkAuthentication();
}

login() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();

       try {
        UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
            print(result);
        //await _auth.currentUser!.updateDisplayName(_name);
        //await Database(uid: _user!.uid).updateuserdata(_name, _id, true ,0,-1,-1,-1,-1,-1);
      } catch (e) {
        showError(e.toString());
        print(e);
      }
    }
  }

  Future<UserCredential> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        final UserCredential user =
            await _auth.signInWithCredential(credential);
          // ignore: unused_local_variable
          User? _user = user.user;
           await Database(uid: _user!.uid).updateuserdata(_user.displayName.toString(), [],[]);

         Navigator.push(context, MaterialPageRoute(
        builder: (context) => NavigationScreen()));

        return user;
      } else {
        throw StateError('Missing Google Auth Token');
      }
    } else
      throw StateError('Sign in Aborted');
  }

 showError(String errormessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ERROR'),
            content: Text(errormessage),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 40,),
                Container(
                  alignment: Alignment.center,
                  width: screenSize.width * 0.80,
                  height: screenSize.height * 0.20,
                  child: Text(
                    'MYNTRA HACKERRAMP',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w800,
                      fontSize: 35,
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                 Container(
                             width: screenSize.width * 0.85,
                             child: Column(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [
                                               
                                               Column(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Container(
                                                     height: screenSize.height * 0.04,
                                                     alignment: Alignment.centerLeft,
                                                     child: Text(
                                                       'Email',
                                                     ),
                                                   ),
                                                   TextFormField(
                                                    
                                                     decoration: InputDecoration(
                                                       border: InputBorder.none,
                              fillColor: Colors.grey[300],
                              filled: true,
                              hintText: 'Please enter your email'),
                              
                              validator: (input)
                              {
                                if(input!.isEmpty)
                                return 'Enter valid email';
                              },
                              onSaved: (input) => email = input!,
                                                   ),
                                                 ],
                                               ),
                                               SizedBox(
                                                 width: screenSize.width * 0.85,
                                                 height: screenSize.width * 0.09,
                                               ),
                                               Column(
                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Container(
                                                     height: screenSize.height * 0.04,
                                                     alignment: Alignment.centerLeft,
                                                     child: Text('Password'),
                                                   ),
                                                   TextFormField(
                                                     validator : (input)
                              {
                                if(input!.length<6)
                                return 'password should be atleast 6 characters long';
                              },
                              onSaved: (input) => password = input!,
                                                     obscureText: true,
                                                     
                                                     decoration: InputDecoration(
                                                       border: InputBorder.none,
                                                       fillColor: Colors.grey[300],
                                                       filled: true,
                                                       hintText: 'Please enter your password',
                                             
                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ],
                             ),
                           ),
                           SizedBox(height: 40,),
              Column(
                children: [
                  Container(
                    width: screenSize.width * 0.75,
                    height: screenSize.height * 0.08,
                    child: Card(
                      color: Colors.pinkAccent,
                      child: TextButton(
                        onPressed: login,
                        child: Text(
                          'LOG IN',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: screenSize.width * 0.90,
                    height: 50,
                    child: TextButton(
                      onPressed: login,
                      child: Text('Forgot Password ?'),
                      style:
                          TextButton.styleFrom(primary: Colors.pinkAccent),
                    ),
                  ),
                ],
                
              ),
              
                SizedBox(height: 10.0),
            
                SignInButton(
                   Buttons.Google,
                   text: "Sign up with Google",
                   onPressed: googleSignIn,
                ),
                SizedBox(height: 8.0),
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account ',
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                  TextButton(
                    onPressed: () {
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    child: Text('Register',
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontSize: 15,
                        )),
                  ),
                ],
                    )
                    ],
                  ),
            ),
          ),
      ),
    );
  }
  
}
   