// import 'package:flutter/material.dart';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:meal_monkey/Emailreg.dart';
// // import 'package:meal_monkey/FirstPage.dart';
// // import 'package:meal_monkey/otppage.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:netflix/firstpage.dart';
// import 'package:netflix/otppage.dart';
// void main() async{
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   runApp(MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'NetFly',
//       home: Phone_verification(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
// class Phone_verification extends StatefulWidget {
//   const Phone_verification({Key? key}) : super(key: key);
//
//   static String verify="";
//   @override
//   State<Phone_verification> createState() => _Phone_verificationState();
// }
//
// class _Phone_verificationState extends State<Phone_verification> {
//   // final GoogleSignIn _googlesignin = GoogleSignIn();
//   TextEditingController countrycode=TextEditingController();
//
//   var phone="";
//   @override
//   void initState() {
//     // TODO: implement initState
//     countrycode.text="+91";
//     super.initState();
//
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.green,
//         body: ListView(
//           children: [
//             SingleChildScrollView(
//               child: Container(
//
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                 ),
//                 child: Column(
//                   children: [
//                     //Padding(padding: EdgeInsets.all(20)),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b0'
//                           '29b4116daf/files/64e1e37989a65cfaf68e/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.cover,),
//                     ),
//                     Padding(padding: EdgeInsets.all(20)),
//                     Text('NetFly',style: GoogleFonts.saira(
//                       color: Colors.black,
//                       fontSize: 45,
//                       //shadows: List.filled(length, fill),
//                       fontWeight: FontWeight.bold
//                     ),
//                     ),
//                     Padding(padding: EdgeInsets.all(0)),
//                     SizedBox(
//                       height: 50,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           border: Border.all(
//                               style: BorderStyle.solid,
//                               strokeAlign: BorderSide.strokeAlignInside,
//                               width:30,
//                               color: Colors.green
//
//                           )
//                       ),
//                       child: TextField(
//                         onChanged: (value){
//                           phone=value;
//                         },
//                         //controller: phonenumbercontroller,
//                         keyboardType: TextInputType.phone,
//                         decoration: InputDecoration(filled: true,
//                             fillColor: Colors.white,
//                             hintText: '         Phone Number',
//                             isDense: false,
//                             //labelText: 'Call',
//                             focusColor: Colors.black,
//                             prefixIcon: TextButton(onPressed: (){},
//                                 child: Text('+91',style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black,
//                                   decorationColor: Colors.black,
//
//                                 ),)),
//                             suffixIcon: Icon(Icons.phone_android_rounded,color: Colors.blue),
//                             hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.w300
//                             ),
//                             //border: OutlineInputBorder(borderRadius: BorderRadius.horizontal(right:Radius.circular(100),left: Radius.circular(100))),
//                             prefixStyle:TextStyle(
//                                 fontWeight: FontWeight.bold
//                             )
//                         ),
//                       ),
//                     ),
//                     Padding(padding: EdgeInsets.all(5)),
//                     SizedBox(
//                       width:300,
//                       height:40,
//                       child: ElevatedButton(onPressed: () async{
//                         await FirebaseAuth.instance.verifyPhoneNumber(
//                           phoneNumber: '${countrycode.text+phone}',
//                           verificationCompleted: (PhoneAuthCredential credential) {},
//                           verificationFailed: (FirebaseAuthException e) {},
//                           codeSent: (String
//                               , int? resendToken) {
//                             Phone_verification.verify=verificationId;
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(builder: (context) => const Otppage()),
//                             );
//                           },
//                           codeAutoRetrievalTimeout: (String verificationId) {},
//                         );
//
//
//                       },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStatePropertyAll(Colors.black),
//                             shadowColor:MaterialStatePropertyAll(Colors.black),
//                             //fixedSize:MaterialStatePropertyAll(Cir),
//                             elevation:MaterialStatePropertyAll(50),
//
//                           ),
//                           child:Text('Send OTP',style: GoogleFonts.aBeeZee(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold
//                           ),)),
//                     ),
//                     Padding(padding: EdgeInsets.all(10)),
//
//                     Padding(padding: EdgeInsets.all(20)),
//                     SizedBox(
//                       height: 50,
//                       child: Text('By Continuing you agree to our privacy policy',style: GoogleFonts.arsenal(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold
//                       ),),
//                     )
//                   ],
//                 ),
//               ),
//             )
//           ],
//         )
//     );
//   }
// }
//
