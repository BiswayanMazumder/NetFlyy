import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/FAQ.dart';
import 'package:netflix/Helppage.dart';
import 'package:netflix/Privacy%20Policy.dart';
import 'package:netflix/T&C.dart';
import 'package:netflix/T&C_acceptance.dart';
import 'package:netflix/a_man_named_otto.dart';
import 'package:netflix/account__details.dart';
import 'package:netflix/disagreement_ban.dart';
import 'package:netflix/legal.dart';
import 'package:netflix/the_railway_men.dart';
import 'package:motion_toast/motion_toast.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:netflix/breaking_bad.dart';
import 'package:netflix/chatbot_netfly.dart';
import 'package:netflix/delhi_crime.dart';
import 'package:netflix/no_internet_page.dart';
import 'package:netflix/report_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:connectivity/connectivity.dart';
import 'package:netflix/delhi_crime_s2_links.dart';
import 'package:netflix/fairytail.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:netflix/godfather_og_hindi.dart';
import 'package:netflix/godzilla.dart';
import 'package:netflix/narcos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:netflix/one_punch.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:akar_icons_flutter/akar_icons_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:netflix/Horro.dart';
import 'package:netflix/action.dart';
import 'package:netflix/amsterdam.dart';
import 'package:netflix/brandnewcherryflavour.dart';
import 'package:netflix/brooklyn_main.dart';
import 'package:netflix/chainsaw.dart';
import 'package:netflix/comedy.dart';
import 'package:netflix/crime.dart';
import 'package:netflix/demon_slayer.dart';
import 'package:netflix/extraction.dart';
import 'package:netflix/godfather.dart';
import 'package:netflix/johny.dart';
import 'package:netflix/jujutsu.dart';
import 'package:netflix/linclnlawyer.dart';
import 'package:netflix/login.dart';
import 'package:netflix/main.dart';
import 'package:netflix/naruto.dart';
import 'package:netflix/netfly_shopping_page.dart';
import 'package:netflix/peakyblinders.dart';
import 'package:netflix/profile.dart';
import 'package:netflix/rednotice.dart';
import 'package:netflix/romance.dart';
import 'package:netflix/sanandreas.dart';
import 'package:netflix/search.dart';
import 'package:netflix/seinfield.dart';
import 'package:netflix/sex_ed_main.dart';
import 'package:netflix/strangerthings.dart';
import 'package:neon/neon.dart';
import 'package:netflix/toohottohandle.dart';
import 'package:netflix/twoandahalf.dart';
import 'package:netflix/uncharted.dart';
import 'package:netflix/uri.dart';
import 'package:motion_toast/motion_toast.dart';
void main() async {
  AwesomeNotifications().initialize(
      null,
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

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final GlobalKey<AnimatedFloatingActionButtonState> key =
  GlobalKey<AnimatedFloatingActionButtonState>();
  Widget rate() {
    return Container(
      child: FloatingActionButton(
        onPressed: fetchrating,
        heroTag: "Image",
        tooltip: 'Rate',
        child: Icon(Icons.rate_review_outlined),
      ),
    );
  }
  Widget add() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Report()
            ),
          );
        },
        heroTag: "Image",
        tooltip: 'Add',
        child: Icon(Icons.error_outline),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Account_details()
            ),
          );
        },
        heroTag: "Image",
        tooltip: 'Image',
        child: Icon(Icons.person_outlined),
      ),
    );
  }
  bool termsacceptance=false;
  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatBotApp()
            ),
          );
    },
        heroTag: "Inbox",
        tooltip: 'Inbox',
        child: Icon(Icons.chat_bubble_outline),
      ),
    );
  }
  String usertime = '';
  User? user = FirebaseAuth.instance.currentUser;
  signoutnotification(){
    AwesomeNotifications().createNotification(content:NotificationContent(id: 10,
      channelKey:'alerts',
      title: 'Thank You For using NetFly',
      body: '🚀 You have succesfully logged\nout of NetFly\nSign-In Again to continue✨',
      wakeUpScreen:true,
      actionType: ActionType.Default,

      //notificationLayout: NotificationLayout.Messaging
    ));
  }
  final Uri _insta = Uri.parse('mailto:biswayanmazumder27@gmail.com');
  Future<void> _launchmail() async {
    if (!await launchUrl(_insta)) {
      throw "Cannot Launch $_insta";
    }
  }
  final Uri _call = Uri.parse('tel:6290714012');
  Future<void> _launchcall() async {
    if (!await launchUrl(_call)) {
      throw "Cannot Launch $_call";
    }
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  bool isMuted = false;
  String user_name='';
  String _connectionStatus = 'Unknown';
  late Timer _connectivityTimer;
  bool _isConnected=true;
  bool _isallowed=true;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allowedtoenter();
    // Initialize the connectivity plugin
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
        _handleNavigation(result);
      });
    });

    // Check the initial connection state
    _checkConnection();

    // Start a timer to check connectivity periodically
    _connectivityTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _checkConnection();
    });
    fetchusername();
    fetchTime();
    _showVerificationDialog();
    // fetchProfileImages();'

  }
  bool allowedtoenterhelp=true;
  Future<void>allowedtoenter() async{
    final docsnap=await _firestore.collection('Help Forum T&C').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        allowedtoenterhelp=docsnap.data()?['haveaccess'];
      });
    }
  }
  double rating=0;
  Future<void> fetchrating() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('Ratings Of Users').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          rating=docsnap.data()?['Rating star'];
        });
        showDialog(context: context,
          // barrierDismissible: true,
          builder:(context)=>
              RatingDialog(
                title:Text( 'Please rate NetFly ${user_name}',style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),),
                onSubmitted: (response)async{
                  print('${response.rating}');
                  if(response.rating==0){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('Rating can not be zero $user_name')),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }else{
                    if(user.emailVerified){
                      await _firestore.collection('Ratings Of Users').doc(user.uid).set(
                          {
                            'User name':user_name,
                            'Rating star':response.rating,
                            'Comments':response.comment,
                            'Time Of Rating':FieldValue.serverTimestamp(),
                          }
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Report Submitted Successfully $user_name'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }else{
                      await _firestore.collection('Ratings Of Users').doc(user.uid).set(
                          {
                            'User name':user_name,
                            'Rating star':response.rating,
                            'Comments':response.comment,
                            'Time Of Rating':FieldValue.serverTimestamp(),
                          });
                      user.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Report Submitted Successfully $user_name'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
                onCancelled: (){
                  Navigator.pop(context);
                },
                enableComment: true,
                initialRating: rating,
                showCloseButton: false,
                // showCloseButton: true,
                commentHint: 'Tell us more ${user_name}',
                image: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/64e1e37989a65cfaf68e/view?project=64e0600003aac5802fbc&mode=admin'),
                message: Text('Rating will help us to know you more better'),
                submitButtonText: 'Submit',
                starColor: Colors.yellow,

              ),
        );
      }else{
        showDialog(context: context,
          barrierDismissible: true,

          builder:(context)=>
              RatingDialog(
                title:Text( 'Please rate NetFly ${user_name}',style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),),
                onSubmitted: (response)async{
                  print('${response.rating}');
                  if(response.rating==0){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(child: Text('Rating can not be zero $user_name')),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }else{
                    if(user.emailVerified){
                      await _firestore.collection('Ratings Of Users').doc(user.uid).set(
                          {
                            'User name':user_name,
                          'Rating star':response.rating,
                            'Comments':response.comment,
                            'Time Of Rating':FieldValue.serverTimestamp(),
                          }
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Report Submitted Successfully $user_name'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }else{
                      await _firestore.collection('Ratings Of Users').doc(user.uid).set(
                          {
                            'User name':user_name,
                            'Rating star':response.rating,
                            'Comments':response.comment,
                            'Time Of Rating':FieldValue.serverTimestamp(),
                          }

                          );
                      user.sendEmailVerification();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Report Submitted Successfully $user_name'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
                onCancelled: (){
                  Navigator.pop(context);
                },
                enableComment: true,
                initialRating: rating,
                showCloseButton: false,
                // showCloseButton: true,
                commentHint: 'Tell us more ${user_name}',
                image: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/64e1e37989a65cfaf68e/view?project=64e0600003aac5802fbc&mode=admin'),
                message: Text('Rating will help us to know you more better'),
                submitButtonText: 'Submit',
                starColor: Colors.yellow,

              ),

        );
      }
    }
  }
  void signoutdialogue()async{
    showDialog(context: context,
        builder: (context){
      return AlertDialog(
        backgroundColor: Colors.greenAccent,
        title: Text('Are you sure you want to signout?',style: TextStyle(fontWeight: FontWeight.w400),),
        actions: [
          TextButton(onPressed: (){
            _auth.signOut();
            signoutnotification();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
              child:Text('Yes',style: TextStyle(color: Colors.black))),
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
              child: Text('No',style: TextStyle(color: Colors.black)))
        ],
      );
        });
  }
  void _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = _getStatusString(connectivityResult);
      _handleNavigation(connectivityResult);
    });
  }

  void _handleNavigation(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // Navigate to another page when not connected
      if (_isConnected) {
        _isConnected = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('No Internet Connection'),
            ),
            backgroundColor: Colors.red,

          ),
        );
        Future.delayed(Duration(seconds:2), () {
          // Delay for a short period before navigating
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Error404()),
          );
        });
      }
    } else {
      // If connected, navigate back to the original page
      if (!_isConnected) {
        _isConnected = true;

      }
    }
  }

  String _getStatusString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return 'Not connected to the internet';
      case ConnectivityResult.wifi:
        return 'Connected to WiFi';
      case ConnectivityResult.mobile:
        return 'Connected to mobile network';
      default:
        return 'Unknown';
    }
  }
  Widget _verificationText = Text('');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _showVerificationDialog() async {
    final user=_auth.currentUser;
    if(user!=null){
      if(user.emailVerified){
        try{
        }catch(e){

        }
      }else{
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Your email address isn't verified",style: GoogleFonts.amaranth(color:Colors.white)),
                backgroundColor: Colors.lightGreen.shade500,
                content: Text('Click the link in the email we will send to\n${user.email}',style: GoogleFonts.amaranth(color:Colors.white,
                fontSize: 15,fontWeight: FontWeight.w100)),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _sendVerificationEmail();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Verification Email Succesfully Sent to:${user.email}'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: Text('Send Email',style: GoogleFonts.amaranth(color:Colors.black),),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // You can add additional actions or navigate to other screens if needed.
                    },
                    child: Text('Close',style: GoogleFonts.amaranth(color:Colors.black)),
                  ),
                ],
              );
            },
          );
        });
      }
    }

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

  Future<void> _sendVerificationEmail() async {
    final user = _auth.currentUser;
    await user?.sendEmailVerification();
    // Add any additional logic after sending the verification email.
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
  Future<void> fetchTime() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          setState(() {
            // Ensure the 'time_of_start' field is a valid timestamp in Firestore
            Timestamp timestamp = snapshot.data()?['time_of_start'] ?? Timestamp.now();
            usertime = timestamp.toDate().toString(); // Convert Firestore timestamp to DateTime
          });
        } else {
          print('Document does not exist.');
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print('Error retrieving timestamp: $e');
    }
  }
  DateTime calculateTimestampPlus365Days() {
    if (usertime.isNotEmpty) {
      DateTime originalDate = DateTime.parse(usertime);
      DateTime calculatedDate = originalDate.add(Duration(days: 365));

      return calculatedDate;
    } else {
      // Return a default DateTime if usertime is not available
      return DateTime.now();
    }
  }

  int calculateDaysLeft() {
    if (usertime.isNotEmpty) {
      DateTime originalDate = DateTime.now(); // Set originalDate to today's date
      DateTime calculatedDate = calculateTimestampPlus365Days();
      DateTime currentDate = DateTime.now();

      Duration difference = calculatedDate.difference(currentDate);
      int daysLeft = difference.inDays;

      print('Original Date: $originalDate');
      print('Calculated Date: $calculatedDate');
      print('Current Date: $currentDate');
      print('Days Left: $daysLeft');
      return daysLeft;
    } else {
      return -1; // Return a negative value to indicate an error or no timestamp available
    }
  }
  IconData volumeIcon = Icons.volume_off_outlined;
  Future<void> _handleGoogleSignOut() async {
    try {
      await _googleSignIn.signOut();
      print("Google Sign-Out Successful");
      // You can also navigate to your app's sign-in page or perform other actions here.
    } catch (error) {
      print("Error signing out from Google: $error");
      // Handle the error appropriately.
    }
  }
  final auth=FirebaseAuth.instance;
  final player = AudioPlayer();
  Future<void>playfromURL(String url)async{
    await player.play(UrlSource(url));
    await player.setVolume(2.0);
    await player.setBalance(0.0); // right channel only
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        // leading: Image.network(
        //   'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin',
        //   width:200,
        //   height: 20,
        //   filterQuality: FilterQuality.high,
        //   colorBlendMode: BlendMode.color,
        // ),
         centerTitle: true,
        title: Text('NetFly',style: GoogleFonts.amaranth(
            color: Colors.red,
            fontSize: 25,
            fontWeight: FontWeight.bold
        ),),

        actions: [
          TextButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Account_details()),
            );
          },

              child: Text('${user_name?.isNotEmpty ?? false ? user_name[0] : ""}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchScreen()),
            );
          },
              icon:Icon(Icons.search,size: 20,)),
          IconButton(
              onPressed: () {
                signoutnotification();
                signoutdialogue();
              },
              icon: Icon(Icons.logout_rounded,size: 20,)),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      //extendBodyBehindAppBar: true,
      // backgroundColor: Colors.transparent,
      floatingActionButton: AnimatedFloatingActionButton(
        key: key,
        fabButtons: <Widget>[
          rate(),
          add(),
          image(),
          inbox(),
        ],
        colorStartAnimation: Colors.green,
        colorEndAnimation: Colors.red,
        animatedIconData: AnimatedIcons.home_menu,
      ),
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          Padding(padding: EdgeInsets.all(10)),

          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 800.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6549afa3455fd7f81359/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
                  opacity: 100.000),

                ),
              ),
              Container(
                height: 800.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    // Colors.black,
                    // Colors.black,
                    Colors.black,
                    Colors.transparent,
                    Colors.black
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
                  )
                ),
              ),
              Positioned(
                top:5,
                left: 10,
                  child: Center(
                    child: Row(
                      children: [
                        Text(
                          'Welcome, ${user_name} ',
                          style: GoogleFonts.amaranth(
                              fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                        ),
                        if(user!.emailVerified)
                          Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/656e14a775bd67ca290d/view?project=64e0600003aac5802fbc&mode=admin'),
                            height: 30,width: 30,),
                        if(user!.emailVerified==false)
                          Text(
                            '🖐️',
                            style: GoogleFonts.arya(
                                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
                          ),
                      ],
                    ),
                  ),),
              SizedBox(
                height: 10,
              ),
              Positioned(
                top: 20,
                right: 10,
                child:  IconButton(
                  style: ButtonStyle(
                    iconSize: MaterialStatePropertyAll(150)
                  ),
                  onPressed: (){
                    setState(() {
                      if (isMuted) {
                        volumeIcon = Icons.volume_up;
                        playfromURL('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6549e540e93dd8350b40/view?project=64e0600003aac5802fbc&mode=admin');
                        print('playing');
                      } else {
                        volumeIcon = Icons.volume_off_outlined;
                        player.pause();
                      }
                      isMuted = !isMuted;
                    });
                  },
                  icon: Icon(volumeIcon, color: Colors.white,size: 25,),
                ),
              ),
              Positioned(child: SizedBox(
                width: 250.0,
                height: 800.0,
                child: Column(
                  children: [
                    SizedBox(
                      height:350,
                    ),
                    Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6549d9c8efb258717735/view?project=64e0600003aac5802fbc&mode=admin'),

                  ],
                )
              )
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          if(calculateDaysLeft()<=5 && calculateDaysLeft()>=2)
            Column(
              children: [
                Text('Please Renew Your Subscription Only ${calculateDaysLeft()} days left',style: GoogleFonts.aBeeZee(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
                SizedBox(
                    height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_WoKAUdpbPOQlXA',
                      'amount': 39600, // amount in the smallest currency unit
                      'timeout': 300,
                      'name': 'NetFly',
                      'description': 'Subscription',
                      'theme': {
                        'color': '#FF0000',
                      },
                    };
                    razorpay.open(options);

                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
                      print('Payment Success');

                      try {
                        // Check if the document exists
                        if (user?.uid != null) {
                          DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

                          if (docSnap.exists) {
                            // Update the isSubscribed field to true
                            await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                              'isSubscribed': true,
                              'time_of_start': FieldValue.serverTimestamp(),
                              'subscription status':'Subscription Renewed'
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Payment Successful for ${user_name}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            //Navigator.pop(context);
                          } else {
                            // The document does not exist. Create a new document for the user with the isSubscribed field set to true.
                            await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
                              'isSubscribed': true,
                              'time_of_start': FieldValue.serverTimestamp(),

                            });

                          }

                          // Get the updated document snapshot
                          DocumentSnapshot updatedDocSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

                          // Check if the isSubscribed field was updated successfully
                          // print('Updated isSubscribed: ${updatedDocSnap.data()?['isSubscribed']}');

                          // Navigate to the UserAccount page
                        } else {
                          // Handle the case when 'user' or 'user.uid' is null
                          print('User or user.uid is null. Unable to process payment.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Payment failed for ${user_name}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error during Firestore operation: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Payment failed for ${user_name}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        // Handle the error as needed
                      }
                    });
                    SizedBox(
                      height: 20,
                    );
                  },
                      style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color(0xFFFFD700))),
                      child:Text('Renew Plan Again',style: GoogleFonts.aboreto(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                      ),)),
                ),
              ],
            ),
          if(calculateDaysLeft()==1)
            Column(
              children: [
                SizedBox(height: 50,),
                Text('Please Renew Your Subscription Only ${calculateDaysLeft()} day left',style: GoogleFonts.aBeeZee(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                ),),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.center,
                  child: TextButton(onPressed: (){
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_WoKAUdpbPOQlXA',
                      'amount': 39600, // amount in the smallest currency unit
                      'timeout': 300,
                      'name': 'NetFly',
                      'description': 'Subscription',
                      'theme': {
                        'color': '#FF0000',
                      },
                    };
                    razorpay.open(options);

                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, (PaymentSuccessResponse response) async {
                      print('Payment Success');

                      try {
                        // Check if the document exists
                        if (user?.uid != null) {
                          DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

                          if (docSnap.exists) {
                            // Update the isSubscribed field to true
                            await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
                              'isSubscribed': true,
                              'time_of_start': FieldValue.serverTimestamp(),
                              'subscription status':'Subscription Renewed'
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Payment Successful for ${user_name}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                            //Navigator.pop(context);
                          } else {
                            // The document does not exist. Create a new document for the user with the isSubscribed field set to true.
                            await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
                              'isSubscribed': true,
                              'time_of_start': FieldValue.serverTimestamp(),

                            });

                          }

                          // Get the updated document snapshot
                          DocumentSnapshot updatedDocSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();

                          // Check if the isSubscribed field was updated successfully
                          // print('Updated isSubscribed: ${updatedDocSnap.data()?['isSubscribed']}');

                          // Navigate to the UserAccount page
                        } else {
                          // Handle the case when 'user' or 'user.uid' is null
                          print('User or user.uid is null. Unable to process payment.');
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Payment failed for ${user_name}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } catch (e) {
                        print('Error during Firestore operation: $e');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Payment failed for ${user_name}'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        // Handle the error as needed
                      }
                    });
                    SizedBox(
                      height: 20,
                    );
                  },
                      style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color(0xFFFFD700))
                      ),
                      child:Text('Renew Plan Again',style: GoogleFonts.aboreto(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),)),
                ),
              ],
            ),
          SizedBox(
            height: 20,
          ),

          Padding(padding: EdgeInsets.all(20)),
          Text(
            '  Categories',
            style: GoogleFonts.abhayaLibre(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          _verificationText,
          SizedBox(height: 20),
          Padding(padding: EdgeInsets.all(10)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20)
                        )
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          player.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Actionpage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'Action',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border:
                            Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          player.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Comedy()),
                          );
                        },
                        style: ButtonStyle(

                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'Comedy',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border:
                            Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          player.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Romance()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'Romance',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border:
                            Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          player.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CrimePage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'Crime',
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border:
                            Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          player.stop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HorrorPage()),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'Horror',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold
                          ),
                        ))),
                SizedBox(
                  width: 10,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border:
                        Border.all(color: Colors.grey.shade100, width: 2.5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Shopping(email: 'email')),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStatePropertyAll(Colors.grey.shade100),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: Text(
                          'NetKart',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            //fontWeight: FontWeight.bold
                          ),
                        ))),
                SizedBox(
                  width: 10,
                ),

              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(30)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Most Popular',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){
                    player.stop();
                  },
                      child:Text('See more>',style: GoogleFonts.arya(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [

                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Uri_movie()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Uri.gif?alt=media&token=0b8c568f-9f6b-4341-91d8-f284ed1ee060&_gl=1*dl0lr9*_ga*MTY4NDM2OTcxLjE2ODI3NjAxMTQ.*_ga_CW55HF8NVT*MTY5ODMyNjU4NC4xNzQuMS4xNjk4MzI5NzIzLjYwLjAuMA..',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                      ),
                    ),
                    Text('URI: The Surgical Strike',style: GoogleFonts.aBeeZee(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Peaky()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Peaky%20Blinders.gif?alt=media&token=76491ebc-f90e-4c0f-9482-d5911fdc55cf&_gl=1*99voax*_ga*MTY4NDM2OTcxLjE2ODI3NjAxMTQ.*_ga_CW55HF8NVT*MTY5ODMyNjU4NC4xNzQuMS4xNjk4MzMwMTA2LjEwLjAuMA..',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Peaky Blinders',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                // Text('$user')
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Lincoln()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a78dc400c0c335524/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Lincoln Lawyer',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Stranger()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a859c171eff1406cb/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Stranger Things',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Godfather()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a87a00218fda62dfb/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('GodFather',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const cherry()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a8d25e77a13776b51/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Brand New Cherry Flavour',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Latest Release',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){
                    player.stop();
                  },
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const demon()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a8f6f11d1410526a5/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 220,
                            width: 250,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Demon Slayer',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const red()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a91a72227b3f7e6ea/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Red Notice',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const uncharted()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a93821d4ff90a1b13/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Uncharted',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Extraction()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a981adc9fe4173ab9/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Extraction',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Sanandreas()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a9b5abd8129a00b2f/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Sanandreas',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Johny()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653aa482784ce6c4f040/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Johny English Reborn',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Casual Viewing',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){
                    player.stop();
                  },
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SeinField()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653aa8d4d7721028ba78/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('SeinField',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Amsterdam()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653aabcbc53ce2f47e3a/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('New Amsterdam',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const hot()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ab09a04aaec46c8e4/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Too Hot To Handle',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const brooklyn_main()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ab2e9333d9bca0be0/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Brooklyn Nine Nine',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const twoandahalf()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ab5483e4b21d0f474/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('TWO and a half MEN',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Anime',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){
                    player.stop();
                  },
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Jujutsu()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/jujutsu_gif/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Jujutsu Kaisen',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Naruto()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/naruto_gif/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Naruto Shippuden',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Chainsaw()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653e86d522d116348a90/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Chainsaw Man',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Fairytail()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(

                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653fe4dd2b1aa04bdc81/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),

                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('Fairy Tail',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {
                            player.stop();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Onepunch()),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(

                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/65413635b4e4bbf2010e/view?project=64e0600003aac5802fbc&mode=admin',
                            height: 250,
                            width: 350,
                            filterQuality: FilterQuality.high,
                            fadeInDuration: Duration(seconds: 2),
                            fadeOutDuration: Duration(seconds: 2),
                            fadeInCurve: Curves.decelerate,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.black,

                                ),

                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height:5,
                    ),
                    Text('One Punch Man',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    )),
                  ],
                ),

              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Crime Dramas',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){},
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Breaking_bad()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6541d02826033922fdad/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 250,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('Breaking Bad',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Narcos()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6543b06c19819c36ab24/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 250,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('Narcos',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => delhi_crime()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6549afa3455fd7f81359/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 250,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('Delhi Crime',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Godfather_s1()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/654a053e2fa306d97330/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 250,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('GodFather',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' English Movies',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){},
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => otto()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/654fb0603142d3748145/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 250,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('A Man Called OTTO',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Godzilla()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6550f64a4fabc36ffaff/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 270,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('Godzilla Vs Kong',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SexEducation()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/655233a3ba65360b162a/view?project=64e0600003aac5802fbc&mode=admin',
                              height: 270,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('Sex Education',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.c'
                          'om/o/money.jpg?alt=media&token=d34e5318-5334-4d51-915a-9c29a0208719',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Colors.black,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/'
                          'lucifer.jpg?alt=media&token=9e2eeef8-1cdc-4d89-b246-553b4f64dcb5',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Colors.black,
                          )),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/kota.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: Colors.black,
                          )),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Hindi Series',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){},
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        child: ElevatedButton(
                            onPressed: () {
                              player.stop();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => The_railway_men()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/the%20railway%20men%20%20trailer.gif?t=2023-12-01T15%3A30%3A35.293Z',
                              height: 270,
                              width: 350,
                              filterQuality: FilterQuality.high,
                              fadeInDuration: Duration(seconds: 2),
                              fadeOutDuration: Duration(seconds: 2),
                              fadeInCurve: Curves.decelerate,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.black,

                                  ),

                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                      SizedBox(
                        height:5,
                      ),
                      Text('The Railway Men',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/jamtara.jpg?alt=media&token=14d00b85-7b5a-448d-a4ce-66fa5df8c4f1',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.co'
                          'm/o/tara.webp?alt=media&token=75f54904-11f5-4f30-ad7d-0596012e305b',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/'
                          'delhi.jpg?alt=media&token=9bc90cae-4e97-4765-b24e-4dbbae7d8787',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o'
                          '/bhool.webp?alt=media&token=06b70ac8-8735-4043-aeb6-5929bb72ef11',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/kabhi.w'
                          'ebp?alt=media&token=d6a13e59-8b57-44aa-a7df-9d6662a6bece',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(20)),
          Row(
            children: [
              Row(
                children: [
                  Text(
                    ' Documentaries',
                    style: GoogleFonts.abhayaLibre(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  TextButton(onPressed: (){},
                      child:Text('See more>',style: GoogleFonts.arya(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),))
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            // physics: ScrollPhysics(),
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent]),
                      borderRadius: BorderRadius.all(Radius.circular(80))),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      // elevation:MaterialStatePropertyAll(50),
                      // shadowColor: MaterialStatePropertyAll(Colors.white),

                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: CachedNetworkImage(
                        imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.c'
                            'om/o/doc1.jpg?alt=media&token=72f69833-73ac-4289-9529-a4b59194d285',
                        errorWidget: (context, url, error) => Text(
                            'Image Not Found',
                            style: TextStyle(color: Colors.white)),
                        placeholder: (context, url) =>
                            CircularProgressIndicator(
                              color: Colors.white,
                            )),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/doc2.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/doc3.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/doc4.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/doc5.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child: CachedNetworkImage(
                      imageUrl:
                          'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com'
                          '/o/doc6.jpg?alt=media&token=64fc9c4c-b0bd-4169-8a2d-189db85b6264',
                      errorWidget: (context, url, error) => Text(
                          'Image Not Found',
                          style: TextStyle(color: Colors.white)),
                      placeholder: (context, url) => CircularProgressIndicator(
                            color: Colors.white,
                          )),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(30)),
          Align(
            alignment:Alignment.centerLeft,
            child: Row(
              children: [
                TextButton(onPressed: (){
                  player.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FAQ()),
                  );

                }, child:Text('FAQ',style: TextStyle(color: Colors.grey,
                fontSize: 8),)),
                TextButton(onPressed: (){
                  player.stop();
                  showDialog(
                    context: context,
                      builder:(BuildContext) {
                        return AlertDialog(
                          title: Column(
                            children: [
                              ElevatedButton(onPressed: (){
                                _launchcall();
                              },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.green)
                                  ),
                                  child: Text('Call Us 📞',style: GoogleFonts.amaranth(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200

                                  ),)),
                              SizedBox(
                                height:20
                              ),
                              ElevatedButton(onPressed: (){
                                _launchmail();
                              },
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(Colors.red)
                                  ),
                                  child: Text('Email Us 📧',style: GoogleFonts.amaranth(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w200

                                  ),)),
                            ],
                          ),
                        );
                      },);
                  }, child:Text('Contact Us',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
                TextButton(onPressed: (){player.stop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Legal()),
                );
                  }, child:Text('Legal Policy',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
                TextButton(
                  onPressed: () async {
                    player.stop();
                    allowedtoenter();  // Ensure this function sets values as needed.

                    final user = _auth.currentUser;
                    if (user != null) {
                      final allowed = await _firestore.collection('Help Forum T&C').doc(user.uid).get();
                      if (allowed.exists) {
                        setState(() {
                          _isallowed = allowed.data()?['haveaccess'];
                        });
                      }

                      final docsnap = await _firestore.collection('Help Forum T&C').doc(user.uid).get();
                      if (docsnap.exists) {
                        setState(() {
                          termsacceptance = docsnap.data()?['T&C Accepted for help forum'];
                        });

                        print(termsacceptance);
                        print(_isallowed);

                        if (termsacceptance == true && _isallowed == true) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
                        } else if (termsacceptance == false && _isallowed == false) {
                          print('User is banned because terms are not accepted.');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                        } else if (termsacceptance == true && _isallowed == false) {
                          print('User is banned due to access restrictions.');
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Ban()));
                        } else {
                          print('Unexpected case.');
                        }
                      } else if (termsacceptance == true && _isallowed == false) {
                        print('User is banned due to access restrictions.');
                      } else {
                        print('User is banned. Navigating to Terms and Conditions page.');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TermsAndConditionsPage()));
                      }
                    }
                  },
                  child: Text(
                    allowedtoenterhelp ? 'Help Page' : 'Help Page: Account Suspended',
                    style: TextStyle(color: Colors.grey, fontSize: 8),
                  ),
                ),


              ],
            ),
          ),
          Align(
            alignment:Alignment.centerLeft,
            child: Row(
              children: [
                TextButton(onPressed: (){player.stop();
                Navigator.push(context,MaterialPageRoute(builder: (context)=>Termsofuse()));
                }, child:Text('Terms Of Use',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
                TextButton(onPressed: (){
                  player.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Report()),
                  );
                }, child:Text('Director? Need Help',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
                TextButton(onPressed: (){
                  player.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Privacy()),
                  );
                }, child:Text('Privacy Policy',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
                TextButton(onPressed: (){
                  player.stop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Report()),
                  );
                }, child:Text('Report Something',style: TextStyle(color: Colors.grey,
                    fontSize: 8),)),
              ],
            ),
          ),
          SizedBox(
            height: 80,
          ),
          // ElevatedButton(onPressed: () async{
          //   AppRating appRating = AppRating(context);
          //   await appRating.initRating();
          // }, child:AnimatedIconButton(icons: [
          //   AnimatedIconItem(icon: Icon(Icons.star))
          // ])
          // )
        ],
      ),
    );
  }
}
