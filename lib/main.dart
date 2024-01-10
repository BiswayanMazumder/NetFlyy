import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:netflix/navbar.dart';
import 'package:netflix/user_account.dart';
import 'package:device_info/device_info.dart';
import 'package:netflix/forgot_password.dart';
import 'package:netflix/signup.dart';
import 'package:netflix/firebase_api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:device_info/device_info.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:netflix/Privacy%20Policy.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_text_reveal/random_text_reveal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
void main() async {
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
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBEzWmfzRUoRFRHlXNEssfR-3EtoElwjJc",
            appId: "1:977326144598:web:52026ea69e60f526738ff7",
            messagingSenderId: "977326144598",
            projectId: "netflix-5002f"));
  } else {
    await Firebase.initializeApp();
  }

  await Firebase.initializeApp();
  await firebaseapi().initNotifications();
  const fatalError = true;
  // Non-async exceptions
  FlutterError.onError = (errorDetails) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
    }
  };
  // Async exceptions
  PlatformDispatcher.instance.onError = (error, stack) {
    if (fatalError) {
      // If you want to record a "fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      // ignore: dead_code
    } else {
      // If you want to record a "non-fatal" exception
      FirebaseCrashlytics.instance.recordError(error, stack);
    }
    return true;
  };
  runApp(
      MyApp()
  );
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  User? user;
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    }).onError((error, stackTrace) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    });
    super.initState();
    user = FirebaseAuth.instance.currentUser;

  }

  triggernotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'alerts',
          title: 'Login To Your NetFly Account',
          body:
          '🚀 Welcome back to the NetFly universe! Its time to dive into the world of endless possibilities. Login now to access your personalized space, where your digital journey awaits. ✨',
          wakeUpScreen: true,
        ));
  }

  @override
  // void initstate() {
  //   _googleSignIn.onCurrentUserChanged.listen((account) {
  //     setState(() {
  //       _currentUser = account;
  //     });
  //   });
  //   _googleSignIn.signInOption;
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NetFly',
      home: AnimatedSplashScreen(
        splash: Image.network(
          'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin',
          width: 500,
          height: 500,
        ),
        backgroundColor: Colors.black,
        animationDuration: Duration(seconds: 2),
        splashTransition: SplashTransition.decoratedBoxTransition,
        centered: true,
        // nextScreen:HomeScreen(),
        nextScreen:user != null ? UserAccount(initialTimerValue: 300,): HomeScreen(),
      ),

      // home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  final FirebaseAuth _authh = FirebaseAuth.instance; // Rename _auth to _authh
  final Razorpay _razorpay = Razorpay();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;
  final Uri _url = Uri.parse(
      'https://docs.google.com/forms/d/e/1FAIpQLSfpnxnib5_fSHVf0CgCokNm0cq60uJrMiZzI7I7sUdZ7sLXSQ/viewform?usp=sf_link');
  Future<void> _launchURl() async {
    if (!await launchUrl(_url)) {
      throw "Cannot Launch $_url";
    }
  }final Uri _site = Uri.parse(
      'https://biswayanmazumder.wixsite.com/biswayanmazumder');
  Future<void> _launchsite() async {
    if (!await launchUrl(_site)) {
      throw "Cannot Launch $_site";
    }
  }
  final Uri _insta = Uri.parse(
      'https://www.instagram.com/itz_biswayan_for_you/');
  Future<void> _launchinsta() async {
    if (!await launchUrl(_insta)) {
      throw "Cannot Launch $_insta";
    }
  }
  final Uri _git = Uri.parse(
      'https://github.com/BiswayanMazumder');
  Future<void> _launchgithub() async {
    if (!await launchUrl(_git)) {
      throw "Cannot Launch $_git";
    }
  }
  String userEmail = '';
  String androidId = 'Fetching...';
  String ipAddress = "Fetching...";
  String currentandroidId='';
  String currentip='';
  @override
  void initState() {
    // TODO: implement initState
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    getEmailFromCache().then((email) {
      setState(() {
        userEmail = email;
      });
    });
    super.initState();
    getDeviceInfo();
    fetchIpAddress();
    fetchprice();
    fetchmac();
    fetchcurrentip();
  }

  Future<void> fetchcurrentip() async{
    final user=_auth.currentUser;
    if(user!=null)
    {
      try{
        final docsnap=await _firestore.collection('users').doc(user.uid).get();
        if(docsnap.exists){
          setState(() {
            currentip=docsnap.data()?['IP Address'];
          });
        }
      }catch(e){

      }
    }
  }
  Future<void> fetchmac() async{
    final user=_auth.currentUser;
    if(user!=null)
    {
      try{
        final docsnap=await _firestore.collection('users').doc(user.uid).get();
        if(docsnap.exists){
          setState(() {
            currentandroidId=docsnap.data()?['MAC Accress'];
          });
        }
      }catch(e){

      }
    }
  }
  String rent='';
  Future<void> fetchprice() async {
    final docsnap= await _firestore.collection('Subscription Cost').doc('Susbscription').get();
    if(docsnap.exists){
      setState(() {
        rent=docsnap.data()?['Price'];
      });
    }
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
  Future<void> saveEmailInCache(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  Future<String> getEmailFromCache() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? '';
  }

  multipledevice() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'alerts',
          title: 'Multiple Login Detected',
          body:
          'Our system has detected multiple concurrent logins from your account. For security reasons, please review and verify these access attempts.',
          wakeUpScreen: true,
          actionType: ActionType.Default,

          //notificationLayout: NotificationLayout.Messaging
        ));
  }
  //
  triggernotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'alerts',
          title: 'Login To Your NetFly Account',
          body:
          '🚀 Welcome back to the NetFly universe! Its time to dive into the world of endless possibilities. Login now to access your personalized space, where your digital journey awaits. ✨',
          wakeUpScreen: true,
          actionType: ActionType.Default,

          //notificationLayout: NotificationLayout.Messaging
        ));
  }
  // Function to schedule the isSubscribed update after 2 days

  bool isSubscribed = false;
  nosubscription() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'alerts',
            title: 'No Subscription Yet',
            body:
            'No Subscription Yet Found...',
            wakeUpScreen: true,
            criticalAlert: true,
            color: Colors.red,
            displayOnBackground: true,
            displayOnForeground: true,
            hideLargeIconOnExpand: false,
            summary: 'Sign-In Failed.....'));
  }
  failedsignin() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'alerts',
            title: 'Sign-In Failed',
            body:
            'You either entered wrong username/password or account does not exists',
            wakeUpScreen: true,
            criticalAlert: true,
            color: Colors.red,
            displayOnBackground: true,
            displayOnForeground: true,
            hideLargeIconOnExpand: false,
            summary: 'Sign-In Failed.....'));
  }
  signInwithGoogle()async{
    GoogleSignInAccount? googleUser=await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth=await googleUser?.authentication;
    AuthCredential credential=GoogleAuthProvider.credential(
        accessToken:googleAuth?.accessToken,
        idToken:googleAuth?.idToken
    );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
    if(userCredential.user!=Null){
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NavBar()),
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
          description: Text(
              "Welcome To NetFly"))
          .show(context);
    }
    else{
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
              "Please Check Your Google Account"))
          .show(context);
    }
  }
  static Future<User?> loginUsingEmailPassword(
      {required String email,
        required String password,
        required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'User Not Found') {
        print('User Not Founded');
      }
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6570975719b90f1c6acc/view?project=64e0600003aac5802fbc&mode=admin',),
              fit: BoxFit.fitHeight,
              opacity: 50,
              //colorFilter: ColorFilter.mode(Colors.b),
              filterQuality: FilterQuality.high,
              repeat: ImageRepeat.repeat,
            )),
        // decoration: BoxDecoration(
        //   image: DecorationImage(image: AssetImage('assets/images/spiderman.jpg'),fit: BoxFit.fitHeight),
        // ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(padding: EdgeInsets.all(30)),
              Align(
                alignment: Alignment.topLeft,
                child: Image(
                  image: NetworkImage(
                      'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'),
                  height: 60,
                ),
              ),

              Padding(padding: EdgeInsets.all(20)),
              Padding(padding: EdgeInsets.all(10)),
              Align(
                  alignment: Alignment.center,
                  child: RandomTextReveal(
                    text:'Welcome\nTo NetFly' ,
                    initialText: 'Ae8&vNQ32cK^dfndjvncjvncjvncvbncvdnjdnjdnvjdnvd',
                    shouldPlayOnStart: true,
                    duration: const Duration(seconds: 30),
                    style: GoogleFonts.orbitron(
                      textStyle: const TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 8,
                      ),
                    ),
                    onFinished: () {
                      debugPrint('Password cracked successfully');
                    },
                    curve: Curves.easeInOutCubic,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
              ),
              Padding(padding: EdgeInsets.all(20)),
              Center(
                  child: Column(
                    children: [
                      AnimatedIconButton(icons: [
                        AnimatedIconItem(
                            icon: Icon(Icons.mail),
                            onPressed: () {
                              print('Enter Email');
                            })
                      ]),
                      RandomTextReveal(
                        text:'Enter Email' ,
                        initialText: 'Ae8&vNQ32cK^dfndjvncjvncjvncvbncvdnjdnjdnvjdnvd',
                        shouldPlayOnStart: true,

                        duration: const Duration(seconds: 10),
                        style: GoogleFonts.arya(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        onFinished: () {
                          debugPrint('Password cracked successfully');
                        },
                        curve: Curves.easeInOutCubic,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  )),
              Padding(padding: EdgeInsets.all(20)),
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
                  controller: email,
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
              Padding(padding: EdgeInsets.all(20)),
              Center(
                  child: Column(
                    children: [
                      AnimatedIconButton(icons: [
                        AnimatedIconItem(
                            icon: Icon(Icons.lock),
                            onPressed: () {
                              print('Enter Password');
                            })
                      ]),
                      RandomTextReveal(
                        text:'Enter Password' ,
                        initialText: 'Ae8&vNQ32cK^dfndjvncjvncjvncvbncvdnjdnjdnvjdnvd',
                        shouldPlayOnStart: true,

                        duration: const Duration(seconds: 10),
                        style: GoogleFonts.arya(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        onFinished: () {
                          debugPrint('Password cracked successfully');
                        },
                        curve: Curves.easeInOutCubic,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      )
                    ],
                  )),
              Padding(padding: EdgeInsets.all(20)),
              Container(
                decoration: BoxDecoration(
                  //border: Border.all(color: Colors.white),
                    color: Colors.lightBlueAccent.shade200,

                    borderRadius: BorderRadius.all(Radius.circular(150)),
                    border: BorderDirectional(bottom: BorderSide.none)),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  obscuringCharacter: "*",
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    //border:OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.transparent,
                      hintText: 'Password',
                      hintStyle: GoogleFonts.azeretMono(
                        fontWeight: FontWeight.w500,
                      )),
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const forgotpassword()),
                        );
                      },
                      child: Text('Trouble Sign In?',
                          style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          )))),
              // Align(
              //   alignment:Alignment.bottomRight,
              //   child: TextButton(onPressed: (){}),
              //   child:Text('Forgot Password')),
              // ),
              Padding(padding: EdgeInsets.all(10)),
        ElevatedButton(
          onPressed: () async {
            if (_isLoading) {
              return; // If already loading, prevent multiple clicks
            }
            setState(() {
              _isLoading = true;
            });
            try{
              User? user = await loginUsingEmailPassword(
                  email: email.text,
                  password: password.text,
                  context: context);
              if (user != null) {
                if(user.emailVerified){

                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("The email address ${user.email} isn't verified"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
                print('Login Success');
                setState(() {
                  userEmail=email.text;
                });
                print("Email saved successfully");
                // Check subscription status
                DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
                print('isSubscribed: ${docSnap.data()??['isSubscribed']}');
                fetchcurrentip();
                fetchmac();
                if ((docSnap.data() as Map<String, dynamic>?)?['isSubscribed'] ?? false) {
                  if(ipAddress==currentip || androidId==currentandroidId){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
                    triggernotification();
                    MotionToast.success(
                        title: Text(
                          "Welcome Back",
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enableAnimation: true,
                        displayBorder: true,
                        displaySideBar: true,
                        animationDuration: Duration(seconds: 10),
                        description:
                        Text('Welcome To NetFly'))
                        .show(context);
                  }else{
                    multipledevice();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
                    MotionToast.error(
                        title: Text(
                          "Multiple Login Detected.",
                          style: GoogleFonts.aBeeZee(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        enableAnimation: true,
                        displayBorder: true,
                        displaySideBar: true,
                        animationDuration: Duration(seconds: 10),
                        description:
                        Text('Sorry account sharing is banned'))
                        .show(context);
                  }
                }
                else {
                  // Initialize Razorpay and open checkout
                  MotionToast.error(
                      title: Text(
                        "Subsccription Not Found",
                        style: GoogleFonts.aBeeZee(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      enableAnimation: true,
                      displayBorder: true,
                      displaySideBar: true,
                      animationDuration: Duration(seconds: 10),
                      description:
                      Text("No Subscription Found"))
                      .show(context);
                  nosubscription();
                  Razorpay razorpay = Razorpay();
                  var options = {
                    'key': 'rzp_test_WoKAUdpbPOQlXA',
                    'amount': rent, // amount in the smallest currency unit
                    'timeout': 300,
                    'name': 'NetFly',
                    'description': 'Subscription For NetFly.Only for two screens',
                    'theme': {
                      'color': '#FF0000',
                    },
                  };

                  razorpay.open(options);
                  razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
                    print('Payment Success');

                    try {
                      // Check if the document exists
                      DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

                      if (docSnap.exists) {
                        // Update the isSubscribed field to true
                        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
                          'isSubscribed': true,
                          'time_of_start': FieldValue.serverTimestamp(),
                          'subscription status':'Subscription Renewed',
                          'payment_ids': FieldValue.arrayUnion([response.paymentId]),
                          'order id':response.orderId,
                          'signature':response.signature,
                          'amount':int.parse(rent)/100,
                          'IP Address':ipAddress,
                          'MAC Accress':androidId,
                          'change mac address':false
                        });

                      } else {
                        // The document does not exist. Create a new document for the user with the isSubscribed field set to true.
                        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                          'isSubscribed': true,
                          'time_of_start': FieldValue.serverTimestamp(),
                          'subscription status':'Subscription Renewed',
                          'payment_ids': FieldValue.arrayUnion([response.paymentId]),
                          'order id':response.orderId,
                          'signature':response.signature,
                          'IP Address':ipAddress,
                          'amount':int.parse(rent)/100,
                          'MAC Accress':androidId,
                          'change mac address':false
                        });
                      }

                      // Get the updated document snapshot
                      DocumentSnapshot updatedDocSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

                      // Navigate to the UserAccount page
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
                    } catch (e) {
                      print('Error during Firestore operation: $e');
                      // Handle the error as needed
                    }
                  });

                }
              } else {
                print('Login Failed');
                user==null;
                failedsignin();
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
                    description:
                    Text("Please Check Your Email-ID and password"))
                    .show(context);
              }
            }catch (e) {
              print('Error during login: $e');
              // Handle login errors if needed...
            } finally {
              setState(() {
                _isLoading = false;
              });
            }
          },
          style: ButtonStyle(
            // side:
            // MaterialStatePropertyAll(BorderSide(color: Colors.red, style: BorderStyle.none,width: 5)),
            animationDuration: Duration(seconds: 3),
            backgroundColor:
            MaterialStatePropertyAll(Colors.red),
          ),
          child: _isLoading
              ? CircularProgressIndicator(
            color: Colors.black,

          ) // Show circular progress indicator if loading
              : RandomTextReveal(
            text: 'Sign In',
            initialText: 'Ae8&vNQ32cK^dfndjvncjvncjvncvbncvdnjdnjdnvjdnvd',
            shouldPlayOnStart: true,
            duration: const Duration(seconds: 10),
            style: GoogleFonts.arya(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            onFinished: () {
              debugPrint('Password cracked successfully');
            },
            curve: Curves.easeInOutCubic,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
              // Padding(padding: EdgeInsets.all(10)),
              // ElevatedButton(
              //   onPressed: () async {
              //     if (_isLoading) {
              //       return; // If already loading, prevent multiple clicks
              //     }
              //     setState(() {
              //       _isLoading = true;
              //     });
              //     try{
              //       User? user = await loginUsingEmailPassword(
              //           email: email.text,
              //           password: password.text,
              //           context: context);
              //       if (user != null) {
              //         if(user.emailVerified){
              //
              //         }else{
              //           ScaffoldMessenger.of(context).showSnackBar(
              //             SnackBar(
              //               content: Text("The email address ${user.email} isn't verified"),
              //               backgroundColor: Colors.red,
              //             ),
              //           );
              //         }
              //         print('Login Success');
              //         setState(() {
              //           userEmail=email.text;
              //         });
              //         print("Email saved successfully");
              //         // Check subscription status
              //         DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              //         print('isSubscribed: ${docSnap.data()??['isSubscribed']}');
              //         fetchcurrentip();
              //         fetchmac();
              //         if ((docSnap.data() as Map<String, dynamic>?)?['isSubscribed'] ?? false) {
              //           if(ipAddress==currentip || androidId==currentandroidId){
              //             Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
              //             triggernotification();
              //             MotionToast.success(
              //                 title: Text(
              //                   "Welcome Back",
              //                   style: GoogleFonts.aBeeZee(
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 enableAnimation: true,
              //                 displayBorder: true,
              //                 displaySideBar: true,
              //                 animationDuration: Duration(seconds: 10),
              //                 description:
              //                 Text('Welcome To NetFly'))
              //                 .show(context);
              //           }else{
              //             multipledevice();
              //             Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
              //             MotionToast.error(
              //                 title: Text(
              //                   "Multiple Login Detected.",
              //                   style: GoogleFonts.aBeeZee(
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 enableAnimation: true,
              //                 displayBorder: true,
              //                 displaySideBar: true,
              //                 animationDuration: Duration(seconds: 10),
              //                 description:
              //                 Text('Sorry account sharing is banned'))
              //                 .show(context);
              //           }
              //         }
              //         else {
              //           // Initialize Razorpay and open checkout
              //           MotionToast.error(
              //               title: Text(
              //                 "Subsccription Not Found",
              //                 style: GoogleFonts.aBeeZee(
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //               ),
              //               enableAnimation: true,
              //               displayBorder: true,
              //               displaySideBar: true,
              //               animationDuration: Duration(seconds: 10),
              //               description:
              //               Text("No Subscription Found"))
              //               .show(context);
              //           nosubscription();
              //           Razorpay razorpay = Razorpay();
              //           var options = {
              //             'key': 'rzp_test_WoKAUdpbPOQlXA',
              //             'amount': rent, // amount in the smallest currency unit
              //             'timeout': 300,
              //             'name': 'NetFly',
              //             'description': 'Subscription For NetFly.Only for two screens',
              //             'theme': {
              //               'color': '#FF0000',
              //             },
              //           };
              //
              //           razorpay.open(options);
              //           razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
              //             print('Payment Success');
              //
              //             try {
              //               // Check if the document exists
              //               DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              //
              //               if (docSnap.exists) {
              //                 // Update the isSubscribed field to true
              //                 await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
              //                   'isSubscribed': true,
              //                   'time_of_start': FieldValue.serverTimestamp(),
              //                   'subscription status':'Subscription Renewed',
              //                   'payment_ids': FieldValue.arrayUnion([response.paymentId]),
              //                   'order id':response.orderId,
              //                   'signature':response.signature,
              //                   'amount':int.parse(rent)/100,
              //                   'IP Address':ipAddress,
              //                   'MAC Accress':androidId,
              //                   'change mac address':false
              //                 });
              //
              //               } else {
              //                 // The document does not exist. Create a new document for the user with the isSubscribed field set to true.
              //                 await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
              //                   'isSubscribed': true,
              //                   'time_of_start': FieldValue.serverTimestamp(),
              //                   'subscription status':'Subscription Renewed',
              //                   'payment_ids': FieldValue.arrayUnion([response.paymentId]),
              //                   'order id':response.orderId,
              //                   'signature':response.signature,
              //                   'IP Address':ipAddress,
              //                   'amount':int.parse(rent)/100,
              //                   'MAC Accress':androidId,
              //                   'change mac address':false
              //                 });
              //               }
              //
              //               // Get the updated document snapshot
              //               DocumentSnapshot updatedDocSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
              //
              //               // Navigate to the UserAccount page
              //               Navigator.push(context, MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300,)));
              //             } catch (e) {
              //               print('Error during Firestore operation: $e');
              //               // Handle the error as needed
              //             }
              //           });
              //
              //         }
              //       } else {
              //         print('Login Failed');
              //         user==null;
              //         failedsignin();
              //         MotionToast.error(
              //             title: Text(
              //               "Sign-In Failed",
              //               style: GoogleFonts.aBeeZee(
              //                 fontWeight: FontWeight.bold,
              //               ),
              //             ),
              //             enableAnimation: true,
              //             displayBorder: true,
              //             displaySideBar: true,
              //             animationDuration: Duration(seconds: 10),
              //             description:
              //             Text("Please Check Your Email-ID and password"))
              //             .show(context);
              //       }
              //     }catch (e) {
              //       print('Error during login: $e');
              //       // Handle login errors if needed...
              //     } finally {
              //       setState(() {
              //         _isLoading = false;
              //       });
              //     }
              //   },
              //   style: ButtonStyle(
              //     // side:
              //     // MaterialStatePropertyAll(BorderSide(color: Colors.red, style: BorderStyle.none,width: 5)),
              //     animationDuration: Duration(seconds: 3),
              //     backgroundColor:
              //     MaterialStatePropertyAll(Colors.red),
              //   ),
              //   child: _isLoading
              //       ? CircularProgressIndicator(
              //     color: Colors.black,
              //
              //   ) // Show circular progress indicator if loading
              //       : RandomTextReveal(
              //     text: 'Sign In To WhatsCall',
              //     initialText: 'Ae8&vNQ32cK^dfndjvncjvncjvncvbncvdnjdnjdnvjdnvd',
              //     shouldPlayOnStart: true,
              //     duration: const Duration(seconds: 10),
              //     style: GoogleFonts.arya(
              //       textStyle: const TextStyle(
              //         fontSize: 20,
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     onFinished: () {
              //       debugPrint('Password cracked successfully');
              //     },
              //     curve: Curves.easeInOutCubic,
              //     overflow: TextOverflow.ellipsis,
              //     maxLines: 2,
              //   ),
              // ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Privacy()),
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: GoogleFonts.arya(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  )),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    _launchURl();
                  },
                  child: Text(
                    'Need Help?',
                    style: GoogleFonts.arya(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Dont Have An Account?',
                        style: GoogleFonts.aBeeZee(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.arya(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text('Follow the Socials of NetFly',style: GoogleFonts.amaranth(color: Colors.white),)),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Button at extreme left
                  ElevatedButton(
                    onPressed: () {
                      _launchinsta();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Image(
                      image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6550cac0a2203f625acf/view?project=64e0600003aac5802fbc&mode=admin',
                      ),
                      height: 45,
                    ),
                  ),

                  // Button at center (expanded)
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () {
                          _launchsite();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child: Image(
                          image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6550cdf630d19012eff3/view?project=64e0600003aac5802fbc&mode=admin'),
                          height: 50,
                        ),
                      ),
                    ),
                  ),

                  // Button at extreme right
                  ElevatedButton(
                    onPressed: () {
                      _launchgithub();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: Image(
                      image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6550cbf04dc63b88e6f4/view?project=64e0600003aac5802fbc&mode=admin',
                      ),
                      height: 50,
                    ),
                  ),
                ],
              ),


              Align(
                alignment: Alignment.centerRight,
                child: Text('A Biswayan Mazumder Work      ',style: GoogleFonts.aBeeZee(
                    color: Colors.white,
                    fontSize: 5,
                    fontWeight: FontWeight.bold
                ),),
              ),
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
