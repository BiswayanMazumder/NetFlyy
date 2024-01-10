import 'package:password_strength/password_strength.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Verification Demo',
      home: SignUpScreen(),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static String verify="";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpassword= TextEditingController();
  final TextEditingController _username=TextEditingController();
  final TextEditingController _phonenumber=TextEditingController();
  bool _isPhoneNumberVerified = false;
  TextEditingController countrycode=TextEditingController();
  String _message = "";
  var phone="";
  String? userEmail;
  String? user_name;
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();

  }
  Future<void> sendEmail({
    required String name,
    required String subject,
    required String message,
  }) async {
    // Obtain the currently logged-in user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('User not logged in');
      return;
    }

    final useremail = _emailController.text;
    final userName=user_name;
    final serviceId = 'service_yqb9qrh';
    final templateId = 'template_pgh891c';
    final userId = 'AFarhcZCFw4YaCRCi';
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    final response = await http.post(
      url,
      headers: {
        'Origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': userName,
          'user_email': useremail,
          'user_subject': subject,
          'user_message': message,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully to $userEmail');
    } else {
      print('Failed to send email. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }
  Future<void> _signUp() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      User? user = userCredential.user; // Get the user object

      if (user != null) {
        // Send a verification email
        await user.sendEmailVerification();
        await FirebaseFirestore.instance.collection('Clients').doc(user.uid).set({
          'username': _username.text,
          'phoneNumber': _phonenumber.text,
          'email id':_emailController.text,
          'password':_passwordController.text
          // Add other fields as needed
        });
        setState(() {
          _message = "Verification email sent. Please check your email.";
          _emailController.clear();
          _passwordController.clear();
          _phonenumber.clear();
          _confirmpassword.clear();
          _username.clear();
        });
      } else {
        setState(() {
          _message = "Error: User is null.";
          _emailController.clear();
          _passwordController.clear();
          _phonenumber.clear();
          _confirmpassword.clear();
          _username.clear();
        });
      }
    } catch (e) {
      setState(() {
        _message = "Error: The email address is already in use";
        _emailController.clear();
        _passwordController.clear();
        _phonenumber.clear();
        _confirmpassword.clear();
        _username.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var code="";
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('User Enrollment...'),
      ),
      body: Padding(

        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'),

              // TextField(
              //   controller: _emailController,
              //   decoration: InputDecoration(labelText: 'Email'),
              // ),
              SizedBox(height: 50,),
              Text('Enter User-Name ',style: GoogleFonts.arya(
                  color: Colors.white
              ),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                    color: Colors.lightBlueAccent,
                    // border: Border.all(
                    //   width: 15,
                    //  style: BorderStyle.solid,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    border: BorderDirectional(bottom: BorderSide.none)),
                child: TextField(
                  controller: _username,
                  keyboardType: TextInputType.name,
                  textAlign: TextAlign.center,
                  //autocorrect: true,
                  decoration: InputDecoration(
                    //border:OutlineInputBorder(),
                      filled: true,
                      hintText: 'User Name',
                      hintStyle: GoogleFonts.azeretMono(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(height: 50,),
              Text('Enter Email-ID ',style: GoogleFonts.arya(
                  color: Colors.white
              ),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                    color: Colors.lightBlueAccent,
                    // border: Border.all(
                    //   width: 15,
                    //  style: BorderStyle.solid,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    border: BorderDirectional(bottom: BorderSide.none)),
                child: TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  //autocorrect: true,
                  decoration: InputDecoration(
                    //border:OutlineInputBorder(),
                      filled: true,
                      hintText: 'Email ID',
                      hintStyle: GoogleFonts.azeretMono(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              // TextField(
              //   controller: _passwordController,
              //   decoration: InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              // ),
              SizedBox(height: 50,),
              Text('Enter Password',style: GoogleFonts.arya(
                color: Colors.white
              ),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                    color: Colors.lightBlueAccent,
                    // border: Border.all(
                    //   width: 15,
                    //  style: BorderStyle.solid,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    border: BorderDirectional(bottom: BorderSide.none)),
                child: TextField(
                  obscureText: true,
                  controller: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  //autocorrect: true,
                  decoration: InputDecoration(
                    //border:OutlineInputBorder(),
                      filled: true,

                      hintText: 'Password',
                      hintStyle: GoogleFonts.azeretMono(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text('Confirm Password',style: GoogleFonts.arya(
                  color: Colors.white
              ),),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                    color: Colors.lightBlueAccent,
                    // border: Border.all(
                    //   width: 15,
                    //  style: BorderStyle.solid,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    border: BorderDirectional(bottom: BorderSide.none)),
                child: TextField(
                  obscureText: true,
                  controller: _confirmpassword,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  //autocorrect: true,
                  decoration: InputDecoration(
                    //border:OutlineInputBorder(),
                      filled: true,
                      hintText: ' Confirm Password',
                      hintStyle: GoogleFonts.azeretMono(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_isPhoneNumberVerified==false) {
                    if (_emailController.text.isEmpty) {
                      _message = "Please enter email";
                    } else if (_passwordController.text == _confirmpassword.text) {
                      try {
                        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );

                        User? user = userCredential.user;
                        if (user != null) {
                          await user.sendEmailVerification();
                          await FirebaseFirestore.instance.collection('Clients').doc(user.uid).set({
                            'username': _username.text,
                            'phoneNumber': phone,
                            'email id': _emailController.text,
                            'password': _passwordController.text,
                            'timestamp': FieldValue.serverTimestamp(),
                            // Add other fields as needed
                          });

                          setState(() {
                            _message = "Your account has been successfully created\nThak You For Chosing Us";
                          });
                          _phonenumber.clear();
                          _confirmpassword.clear();
                          _username.clear();
                          _passwordController.clear();
                          _emailController.clear();
                        }
                      } catch (e) {
                        // Handle the case where the email is already in use
                        if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
                          setState(() {
                            _message = "Sorry, this email is already in use. Please use a different email.";
                          });
                        } else {
                          setState(() {
                            _message = "Error: ${e.toString()}";
                          });
                        }
                      }
                    } else if (_passwordController.text.isEmpty || _confirmpassword.text.isEmpty) {
                      setState(() {
                        _message = "Sorry, please enter the password";
                      });
                    }
                    else if (_passwordController.text.isEmpty || _confirmpassword.text.isEmpty||_emailController.text.isEmpty||_username.text.isEmpty) {
                      setState(() {
                        _message = "Please Enter Your Details To Proceed";
                      });
                    }
                    else if (_passwordController.text != _confirmpassword.text) {
                      setState(() {
                        _message = "Sorry, passwords don't match or either column is empty.";
                      });
                    }
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.black),
                ),
                child: Text('Sign Up'),
              ),


              SizedBox(height: 16),
       Text(_message,style: TextStyle(color: Colors.white),),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

