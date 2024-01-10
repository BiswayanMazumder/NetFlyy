import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/firstpage.dart';
// import 'package:google_sign_in/google_sign_in.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(myApp());
}
class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Monkey',
      home: CallPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class CallPage extends StatefulWidget {
  const CallPage({Key? key}) : super(key: key);

  static String verify="";
  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  // final GoogleSignIn _googlesignin = GoogleSignIn();
  TextEditingController countrycode=TextEditingController();

  var phone="";
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();

  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                ),
                child: Column(
                  children: [
                    //Padding(padding: EdgeInsets.all(20)),
                    Align(
                      alignment: Alignment.center,
                      child: Image(image: AssetImage('assets/images/gif.gif'),fit: BoxFit.cover,),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text('Meal Monkey',style: GoogleFonts.aboreto(
                      color: Colors.white,
                      fontSize: 45,
                      //shadows: List.filled(length, fill),
                      //fontWeight: FontWeight.bold
                    ),
                    ),
                    Padding(padding: EdgeInsets.all(0)),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              style: BorderStyle.solid,
                              strokeAlign: BorderSide.strokeAlignInside,
                              width:30,
                              color: Colors.red.shade900

                          )
                      ),
                      child: TextField(
                        onChanged: (value){
                          phone=value;
                        },
                        //controller: phonenumbercontroller,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(filled: true,
                            fillColor: Colors.white,
                            hintText: '         Phone Number',
                            isDense: false,
                            //labelText: 'Call',
                            focusColor: Colors.black,
                            prefixIcon: TextButton(onPressed: (){},
                                child: Text('+91',style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  decorationColor: Colors.black,

                                ),)),
                            suffixIcon: Icon(Icons.phone_android_rounded,color: Colors.blue),
                            hintStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w300
                            ),
                            //border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(right:Radius.circular(100),left: Radius.circular(100))),
                            prefixStyle:TextStyle(
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(5)),
                    SizedBox(
                      width:300,
                      height:40,
                      child: ElevatedButton(onPressed: () async{
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countrycode.text+phone}',
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            CallPage.verify=verificationId;
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const FirstPage()),
                            );
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );


                      },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                            shadowColor:MaterialStatePropertyAll(Colors.black),
                            //fixedSize:MaterialStatePropertyAll(Cir),
                            elevation:MaterialStatePropertyAll(50),

                          ),
                          child:Text('Send OTP')),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    Text('━━━━━━━━━━━━━━ OR ━━━━━━━━━━━━━',style: GoogleFonts.arefRuqaa(
                        color: Colors.grey,
                        fontWeight: FontWeight.w200
                    ),),
                    Padding(padding: EdgeInsets.all(20)),
                    SizedBox(
                      width: 200,
                      child:ElevatedButton(onPressed: (){
                      },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.grey),
                            elevation:MaterialStatePropertyAll(50),
                            shadowColor:MaterialStatePropertyAll(Colors.white),
                          ),
                          child:Text('Skip Sign In',style: GoogleFonts.arefRuqaa(fontSize: 20,color: Colors.black,
                          ),)),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    SizedBox(
                      height: 50,
                      child: Text('By Continuing you agree to our privacy policy',style: GoogleFonts.arsenal(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),),
                    )
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
}

