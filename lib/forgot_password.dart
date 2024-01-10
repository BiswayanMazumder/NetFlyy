import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/main.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
void main() async{
  AwesomeNotifications().initialize(
      null, //'resource://drawable/res_app_icon',//
      [
        NotificationChannel(
          channelKey: 'alerts',
          channelName: 'Alerts',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
        )
      ],
      debug: true);
}
class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed){
      if(isAllowed){
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    }).onError((error, stackTrace){
      AwesomeNotifications().requestPermissionToSendNotifications();
    });
    super.initState();
  }
  signinsuccess(){
    AwesomeNotifications().createNotification(content: NotificationContent(id: 10,
        channelKey:'alerts',
        title: 'Password Succesfully Updated',
        body: 'Your Password has been reset'
    ));
  }
  signinfailed(){
    AwesomeNotifications().createNotification(content: NotificationContent(id: 10,
        channelKey:'alerts',
        title: 'password cannot be changed',
        body: 'Please try again later'
    ));
  }
  final emailcontroller=TextEditingController();
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        title: Text('Forgot Password'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin',
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Enter Email ID',style: GoogleFonts.arya(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(
              height: 20,
            ),
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
                controller: emailcontroller,
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
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: (){

              auth.sendPasswordResetEmail(email: emailcontroller.text.toString()).then((value){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen()),
                );
                signinsuccess();
                MotionToast.success(
                    title:  Text("Password Reset Successful",style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                    ),),
                    enableAnimation: true,
                    displayBorder: true,
                    displaySideBar: true,
                    animationDuration: Duration(seconds: 10),
                    description:  Text("Email sent please Check email")
                ).show(context);


              }).onError((error, stackTrace){
                signinfailed();
                MotionToast.error(
                    title:  Text("Password Reset Failed",style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                    ),),
                    enableAnimation: true,
                    displayBorder: true,
                    displaySideBar: true,
                    animationDuration: Duration(seconds: 10),
                    description:  Text("Email ID not registered or wrong email")
                ).show(context);
              });
            },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                    elevation: MaterialStatePropertyAll(50),
                    shadowColor: MaterialStatePropertyAll(Colors.white)
                ),
                child:Text('Reset Password',style: GoogleFonts.arya(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),))
          ],
        ),
      ),
    );
  }
}
