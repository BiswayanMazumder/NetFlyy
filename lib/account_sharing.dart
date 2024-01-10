import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/signup.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/user_account.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:device_info/device_info.dart';
import 'package:phone_number/phone_number.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Account_sharing());
}

class Account_sharing extends StatefulWidget {
  const Account_sharing({Key? key}) : super(key: key);

  @override
  State<Account_sharing> createState() => _Account_sharingState();
}

class _Account_sharingState extends State<Account_sharing> {
  final auth=FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ipAddress = "Fetching...";
  String phone='';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String phoneNumber = '';
  String verificationId = '';
  String user_name='';
  TextEditingController _passwordauth_user2=TextEditingController();
  TextEditingController countrycode=TextEditingController();
  TextEditingController  _phonenumberentered=TextEditingController();
  bool macchange=false;
  String androidId = 'Fetching...';
  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();
    fetchIpAddress();
    fetchphonenumber();
    fetchusername();
    getUserEmail();
    getDeviceInfo();
    fetchusername();
  }
  Future<void> fetchusername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Clients').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            user_name = snapshot.data()?['username'] ?? '';
          });
        } else {
          print('Document does not exist.');
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print('Error retrieving password: $e');
    }
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

    final useremail = userEmail;
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
  Future<void> getDeviceInfo() async {
    try {
      DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;

      setState(() {
        androidId = androidInfo.androidId ?? 'Not available';
      });
    } catch (e) {
      print('Error getting device information: $e');
    }
  }
  String? userEmail;
  Future<void> getUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error getting user email: $e");
    }
  }

  Future<void> fetchphonenumber() async{
    final user=auth.currentUser;
    if(user!=null){
      try{
        final docsnap=await _firestore.collection('Clients').doc(user.uid).get();
        if(docsnap.exists){
          setState(() {
            phone=docsnap.data()?['phoneNumber'];
          });
        }
      }catch(e){

      }
    }
  }

  void _showOtpDialog() {
    String enteredOtp = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OTP'),
          content: TextField(
            onChanged: (value) {
              enteredOtp = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                // Validate the OTP and update the Firestore value
                final user=auth.currentUser;
                if (enteredOtp.isNotEmpty) {
                  // Update the Firestore value (replace this with your actual logic)

                  await _firestore
                      .collection('users')
                      .doc(user?.uid)
                      .update({
                    'IP Address':ipAddress
                  });

                  Navigator.of(context).pop();
                } else {
                  // Handle invalid OTP
                  print('Invalid OTP');
                }
              },
              child: Text('Verify'),
            ),
          ],
        );
      },
    );
  }
  Future<void> fetchIpAddress() async {
    try {
      var response = await http.get(Uri.parse('https://api64.ipify.org'));
      if (response.statusCode == 200) {
        // Parse the JSON response and update the state with the IP address.
        setState(() {
          ipAddress = response.body;
        });
      } else {
        throw Exception('Failed to load IP address');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  @override
  Widget build(BuildContext context) {
    var code="";
    return Scaffold(
      // backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.red.shade500,Colors.black])
        ),
        child: SingleChildScrollView(
          child: Column(

            children: [
              SizedBox(
                height: 250,
              ),
              Text('Start Your Own NetFly Today',style: GoogleFonts.amaranth(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
              SizedBox(
                height: 40,
              ),
              Text('If you do not live with the owner you need to have your own account to keep watching',style: GoogleFonts.amaranth(color:Colors.white,
                  fontWeight: FontWeight.w100,
                  fontSize: 25
              )),

              SizedBox(
                height: 40,
              ),
              ElevatedButton(onPressed: (){
                auth.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>SignUpScreen()),
                );
              },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
                  child:Text('Join Now',style: GoogleFonts.amaranth(color:Colors.black,fontWeight: FontWeight.bold))),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text('Is this your account?',style: GoogleFonts.amaranth(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),

              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(onPressed:()async{
                showDialog(context: context,
                    builder:(BuildContext){
                      return AlertDialog(
                        title: Text('Please verify yourself\n${user_name}',style: TextStyle(fontWeight: FontWeight.w300),),
                        scrollable: true,
                        content: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller: _passwordauth_user2,
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Enter Password To Continue'
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(onPressed: ()async{
                              if(_passwordauth_user2.text.isNotEmpty){
                                final user=auth.currentUser;
                                // _auth.fetchSignInMethodsForEmail(userEmail.toString());
                                if(user!=null && user.emailVerified){
                                  AuthCredential credential=EmailAuthProvider.credential(email: user.email!, password: _passwordauth_user2.text);
                                  await user.reauthenticateWithCredential(credential);
                                  await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                                    'IP Address':ipAddress,
                                    'Time Of Last Change Of IP':FieldValue.serverTimestamp()
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(child: Text('Succesfully added as secondary device for email ${userEmail}')),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                  await sendEmail(
                                    name: user_name, // Replace with the user's name
                                    subject: 'Confirmation: Your IP Address has been changed Succesfully.',
                                    message: 'Dear ${user_name},\n'

                                        '\n We hope this message finds you well.\n'
                                        '\n We would like to inform you that we have noticed sudden change of IP-Address from your account\n'
                                        '\n at ${DateTime.now().toString().split(' ')}. You new changed IP is: ${ipAddress}.\n'
                                        'If you feel you havenot done it please contact us at: support@netfly.org.'
                                  );
                                  _passwordauth_user2.clear();
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Center(child: Text("Please verify your email to continue.")),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  await user?.sendEmailVerification();
                                }
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserAccount(initialTimerValue: 300),
                                  ),
                                ).then((_) {
                                  // This code will run after the new screen has been dismissed
                                  Navigator.pop(context);
                                });

                              }else if(_passwordauth_user2.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter password'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                              else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please enter correct password'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                _passwordauth_user2.clear();
                              }
                            }, child: Text('Verify User'))
                          ],
                        ),
                      );
                    });
              },
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red)
                  ),
                  child:Text('Add this as secondary device',style: GoogleFonts.amaranth(color:Colors.white,fontWeight: FontWeight.bold))),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed: ()async{
                final user=_auth.currentUser;
                if(user!=null){
                  final docsnap= await _firestore.collection('users').doc(user.uid).get();
                  if(docsnap.exists){
                    setState(() {
                      macchange=docsnap.data()?['change mac address'];
                    });
                  }
                  if(macchange==true){
                    await _firestore.collection('users').doc(user.uid).update(
                        {
                          'MAC Accress':androidId,
                          'change mac address':false
                        });
                    await sendEmail(
                        name: user_name, // Replace with the user's name
                        subject: 'Confirmation: Your MAC Address has been successfully changed',
                        message: 'Dear ${user_name},\n'

                            '\n We hope this message finds you well.\n'
                            '\n We would like to inform you that we have noticed sudden change of MAC Address from your account\n'
                            '\n at ${DateTime.now().toString().split(' ')}. You new changed MAC is: ${androidId}.\n'
                            'If you feel you havenot done it please contact us at: support@netfly.org.'
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  UserAccount(initialTimerValue: 300)),
                    );
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please contact customer care to make this your primary device ${user_name}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                  child: Text('Add this as primary device',style: GoogleFonts.amaranth(color:Colors.white,fontWeight: FontWeight.bold))),
              SizedBox(
                height: 500,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}