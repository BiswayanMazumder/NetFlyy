import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/Helppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:avatar_glow/avatar_glow.dart';
class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  bool isDark = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // Toggle between light and dark mode
              setState(() {
                isDark = !isDark;
              });
            },
            icon: Icon(
              isDark ? Icons.sunny : Icons.nights_stay_rounded,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          'NetFly',
          style: GoogleFonts.amaranth(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Text(
                    'Terms and Conditions for NetFly Help Forum',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18,color: isDark ? Colors.black : Colors.white,),
                  )),
              Text(
                '''

1. Acceptance of Terms

By accessing and using NetFly Help Forum, you agree to comply with and be bound by these terms and conditions. If you do not agree with any part of these terms, please do not use the forum.

2. User Responsibilities

a. Users are responsible for all content they post on the forum.
b. Users must respect the rights and privacy of others.
c. Users shall not engage in any unlawful activities on the forum.

3. Moderation

a. The forum reserves the right to moderate content to ensure it complies with community guidelines.
b. Moderation decisions are at the discretion of the forum administrators.

4. Content Removal

a. The forum may, at its sole discretion, remove content that violates these terms.
b. Users will be notified of content removal and provided with an explanation, if feasible.

5. User Conduct

a. Users must refrain from engaging in any behavior that disrupts the community or harasses other members.
b. Hate speech, discrimination, and offensive content are strictly prohibited.

6. Intellectual Property

a. Users retain ownership of their content but grant the forum a license to use, modify, and display the content.
b. Users must not infringe on the intellectual property rights of others.

7. Privacy Policy:

8. Disclaimers and Limitation of Liability

a. The forum provides information and assistance on an "as-is" basis, without warranties.
b. The forum is not liable for any direct, indirect, or consequential damages arising from the use of the platform.

9. Governing Law and Jurisdiction

a. These terms are governed by the laws of India.
b. Any disputes shall be resolved in the courts of India.

10. Changes to Terms

a. The forum reserves the right to modify these terms at any time.
b. Users are responsible for reviewing the terms regularly.

11. Termination of Service

a. The forum may terminate or suspend its services at any time without notice.

12. User Agreement

By using NetFly, you acknowledge that you have read, understood, and agreed to these terms and conditions.
''',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w300,color: isDark ? Colors.black : Colors.white,),),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  AvatarGlow(
                    glowColor: Colors.green,
                    animate: true,
                    endRadius: 60.0,
                    showTwoGlows: true,
                    shape: BoxShape.rectangle,
                    repeat: true,
                    curve: Curves.bounceOut,
                    child: Material(
                      color:isDark?Colors.white:Colors.black,
                      child: ElevatedButton(
                        onPressed: ()async{
                          final user=_auth.currentUser;
                          if(user!.emailVerified){
                            if(user!=null){
                              await _firestore.collection('Help Forum T&C').doc(user.uid).set({
                                'T&C Accepted for help forum':true,
                                'Time Of Accepting':FieldValue.serverTimestamp(),
                                'User email':user.email,
                                "user Id":user.uid,
                                'haveaccess':true
                              });
                            }
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HelpPage(),
                              ),
                            );
                          }else{
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:  Text('Please verify your account to continue'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.green)),
                        child: Text('Yes, I agree'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
