import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:netflix/netfly_shopping_page.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neopop/neopop.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Login successful, navigate to the next page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Shopping(email: emailController.text),
        ),
      );
      MotionToast.success(
          title: Text(
            "Sign-In Successful",
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold,
            ),
          ),
          enableAnimation: true,
          displayBorder: true,
          displaySideBar: true,
          animationDuration: Duration(seconds: 10),
          description: Text("Welcome To NetFly"))
          .show(context);
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      // Handle login errors
      MotionToast.error(
          title: Text(
            "Sign-In Failed",
            style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.bold,
            ),
          ),
          enableAnimation: true,
          displayBorder: true,
          displaySideBar: true,
          animationDuration: Duration(seconds: 10),
          description: Text(
              "Please Check Your Email-ID and password"))
          .show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/iCg.gif'),
              fit: BoxFit.fill,
              opacity: 100,
              //colorFilter: ColorFilter.mode(Colors.b),
              filterQuality: FilterQuality.high,
              repeat: ImageRepeat.repeat,
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 250,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Define the border color
                          width: 5.0,         // Define the border width
                        ),
                        borderRadius: BorderRadius.circular(50.0), // Define the border radius
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: ' Email',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey, // Define the border color
                          width: 5.0,         // Define the border width
                        ),
                        borderRadius: BorderRadius.circular(50.0), // Define the border radius
                      ),
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(fontWeight: FontWeight.bold)
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Align(
                      alignment: Alignment.center,
                      child: NeoPopButton(
                        color: Colors.yellow,
                        enabled: true,
                        border: Border.all(color: Colors.black),
                        animationDuration: Duration(seconds: 1),
                        shadowColor:Colors.black,
                        forwardDuration: Duration(seconds: 1),
                        reverseDuration: Duration(seconds: 1),
                        onLongPress: (){
                          _login();
                        },
                        depth: 25,
                        onTapUp:(){
                          _login();
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Sign In",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 250,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
