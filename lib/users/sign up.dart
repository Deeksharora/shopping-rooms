import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:shopping_rooms/users/user database.dart';
import 'package:shopping_rooms/screens/navigation.dart';
import 'package:shopping_rooms/users/login.dart';
enum answer {yes,no}
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool hide = true;
  FirebaseAuth _auth = FirebaseAuth.instance;
  

String? id='';
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = '2020';
  bool _switch = false;
   answer? _character = answer.yes;

 // ignore: unused_field
 String _name='', _email='', _password='',_id='';

  checkAuthentication() async {
    _auth.authStateChanges().listen((user) async {
      if (user != null) {
         Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavigationScreen()),
                      );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        UserCredential result = await _auth.createUserWithEmailAndPassword(
            email: _email, password: _password);
            // ignore: unused_local_variable
            User? _user = result.user;
            
        await _auth.currentUser!.updateDisplayName(_name);
        await Database(uid: _user!.uid).updateuserdata(_name,[],[]);
      } catch (e) {
        showError(e.toString());
        print(e);
      }
    }
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                width: 350,
                height: 60,
                color: Color(0xff2FC4B2),
                child: Text(
                  'CRUX FLUTTER SUMMER GROUP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: screenSize.width * 0.85,
                child: Column(
                  children: [
                    //Padding(padding: EdgeInsets.all(25)),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(12)),
                        Container(
                          height: screenSize.height * 0.04,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Name',
                            
                          ),
                        ),
                        TextFormField(
                           validator: (input)
                        {
                          if(input!.isEmpty)
                          return 'Enter name';
                        },
                        onSaved: (input) => _name = input!,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey[300],
                              filled: true,
                              hintText: 'Please enter your Name'),
                               ),
                      ],
                    ),
                    
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(12)),
                        Container(
                         height: screenSize.height * 0.04,
                         alignment: Alignment.centerLeft,
                          child: Text(
                            'ID Number',
                            
                          ),
                        ),
                        TextFormField(
                           validator: (input)
                        {
                          if(input!.isEmpty)
                          return 'Enter valid ID Number';
                        },
                        onSaved: (input) => _id = input!,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey[300],
                            filled: true,
                              hintText: 'Please enter your BITS ID Number'),
                               ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(12)),
                        Container(
                           height: screenSize.height * 0.04,
                           alignment: Alignment.centerLeft,
                          child: Text(
                            'Email',
                            
                          ),
                        ),
                        TextFormField(
                           validator: (input)
                        {
                          if(input!.isEmpty)
                          return 'Enter valid email';
                        },
                        onSaved: (input) => _email = input!,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              fillColor: Colors.grey[300],
                            filled: true,
                              hintText: 'Please Enter your Email'),
                               ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(12)),
                        Container(
                          height: screenSize.height*0.04,
                         alignment: Alignment.centerLeft,
                          child: Text(
                            'Password',
                            
                          ),
                        ),
                        TextFormField(
                          validator : (input)
                        {
                          if(input!.length<6)
                          return 'password should be atleast 6 characters long';
                        },
                        onSaved: (input) => _password = input!,
                          obscureText: hide,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                             fillColor: Colors.grey[300],
                            filled: true,
                            hintText: 'Please enter your password',
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.all(12)),
                        Container(
                          height: screenSize.height*0.04,
                         alignment: Alignment.centerLeft,
                          child: Text(
                            'Batch',
                            
                          ),
                        ),
                        Container(
                          width: screenSize.width * 0.85,
                          height: screenSize.height*0.06,
                          color: Colors.grey[300],
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Center(
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValue,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownValue = newValue!;
                                  });
                                },
                                underline: DropdownButtonHideUnderline(
                                    child: Container()),
                                items: <String>[
                                  '2020',
                                  '2019',
                                  '2018',
                                  '2017'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                 width: screenSize.width * 0.80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Receive Regular Updates',
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          textAlign: TextAlign.start),
                      Switch(
                        value: _switch,
                        onChanged: (value) {
                          setState(() {
                            _switch = value;
                            print(_switch);
                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Color(0xff2FC4B2),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                
                children: [
                  Padding(padding: EdgeInsets.all(12)),
                  SizedBox(
                     width: screenSize.width * 0.80,
                    child: Text('Are you excited for this !!',
                          style: TextStyle(color: Colors.black, fontSize: 15,),
                          textAlign: TextAlign.start,
                          ),
                  ),
                  Container(
                    
                    
                    child: Row(
                      
                      children: <Widget>[
                          Expanded(
                            child: ListTile(
                              title: const Text('Yes'),
                              leading: Radio<answer>(
                                value: answer.yes,
                                groupValue: _character,
                                onChanged: (answer? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              
                              title: const Text('No'),
                              leading: Radio<answer>(
                                value: answer.no,
                                groupValue: _character,
                                onChanged: (answer? value) {
                                          setState(() {
                                            _character = value;
                                          });
                                },
                              ),
                            ),
                          ),
                        ],
                    ),
                  )
                        
                ],
              ),
              SizedBox(height: screenSize.height*0.02,),
              Container(
                 width: screenSize.width * 0.85,
                 height: screenSize.height * 0.06,
                
                decoration: BoxDecoration(
                    color: Color(0xff2FC4B2),
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    style: TextButton.styleFrom(
                        textStyle:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric()),
                    onPressed: signUp,
                    child: Text('REGISTER')),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(12)),
                  Text(
                    'Already have an account ',
                    
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xff2FC4B2),
                          
                        ),
                      )),
                ],
              )
            ]),
          ),
        ),
      ),
    )
    );
    
  }
}