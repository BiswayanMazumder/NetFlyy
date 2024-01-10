import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  bool isDark=false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _policy='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchlegalpolicy();
  }
  Future<void> fetchlegalpolicy() async{
    final docsnap= await _firestore.collection('Policies').doc('Legal Policies').get();
    if(docsnap.exists){
      setState(() {
        _policy=docsnap.data()?['Policy'];
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark?Colors.white:Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            setState(() {
              isDark=!isDark;
            });
          },
              icon: Icon(isDark?Icons.sunny:Icons.nights_stay_rounded,
                color: Colors.white,))
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Center(
                child: Text('Privacy Policy',style: TextStyle(fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark?Colors.black:Colors.white),),
              ),
              SizedBox(
                height: 20,
              ),
              Text('''${_policy}''',style: TextStyle(color: isDark?Colors.black:Colors.white,fontWeight: FontWeight.w400),),
              SizedBox(
                height:50 ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
