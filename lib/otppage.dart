import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/firstpage.dart';
import 'package:netflix/navbar.dart';
import 'package:netflix/phone_verification.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:netflix/user_account.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Otppage extends StatefulWidget {
  const Otppage({Key? key}) : super(key: key);

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
  final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    var code="";
    return Scaffold(
      backgroundColor: Colors.green,
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                children: [

                  Padding(padding: EdgeInsets.all(10)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          IconButton(onPressed: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => NavBar()),
                            );
                          },
                              icon: Icon(Icons.keyboard_backspace_outlined,color: Colors.white,)),
                          Text('Continue With OTP',style: GoogleFonts.adamina(
                              color:Colors.white,
                              fontSize:30
                          ),)
                        ],
                      )
                  ),
                  Padding(padding: EdgeInsets.all(50)),
                  Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/64e1e37989a65cfaf68e/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.cover,),
                  Padding(padding: EdgeInsets.all(20)),
                  Center(
                    child: Column(
                      children: [
                        Text('    You need to enter your OTP inorder to get started!',style:
                        GoogleFonts.abel(
                            fontSize:22,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),),
                        Padding(padding: EdgeInsets.all(10)),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(80)),
                              color: Colors.black,
                              border: Border.all(
                                  width: 30,
                                  color: Colors.green
                              )
                          ),
                          child: TextFormField(
                            onChanged: (value){
                              code=value;
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              isCollapsed: false,
                              //errorText: 'Sorry Enter Correct OTP',
                              fillColor: Colors.grey.shade100,
                              prefixIcon: Icon(Icons.perm_phone_msg_rounded),
                              prefixIconColor: Colors.black,
                              hintText: '    Enter The OTP',
                              hintStyle:GoogleFonts.archivoNarrow(
                                  fontWeight: FontWeight.w200,
                                  color: Colors.grey,
                                  wordSpacing: 2,
                                  letterSpacing: 2
                              ),
                              filled: true,


                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10)),
                        SizedBox(
                          width: 200,
                          height: 40,
                          child: ElevatedButton(onPressed: () async{

                            try {PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: Phone_verification.verify,
                                smsCode: code);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>  NavBar()),
                            );
                            MotionToast.success(
                                title:  Text("Sign-In Successful",style: GoogleFonts.aBeeZee(
                                  fontWeight: FontWeight.bold,
                                ),),
                                enableAnimation: true,
                                displayBorder: true,
                                displaySideBar: true,
                                animationDuration: Duration(seconds: 10),
                                description:  Text("Welcome To NetFly")
                            ).show(context);
                            } catch (e) {
                              MotionToast.error(
                                  title:  Text("Sign-In Failed",style: GoogleFonts.aBeeZee(
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  enableAnimation: true,
                                  displayBorder: true,
                                  displaySideBar: true,
                                  animationDuration: Duration(seconds: 10),
                                  description:  Text("Please Check Your OTP")
                              ).show(context);
                            }

                          },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.black)
                              ),
                              child: Text('Verify OTP',style: GoogleFonts.anybody(fontWeight: FontWeight.bold,
                                  color: Colors.white),)),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
