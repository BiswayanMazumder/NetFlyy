import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:netflix/account_sharing.dart';
import 'package:http/http.dart' as http;
import 'package:netflix/coming.dart';
import 'package:netflix/no_internet_page.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:connectivity/connectivity.dart';
import 'package:device_info/device_info.dart';
import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:netflix/account__details.dart';
import 'package:netflix/main.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:netflix/navbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:appwrite/appwrite.dart';
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
}
class UserAccount extends StatefulWidget {
  // const UserAccount({Key? key}) : super(key: key);
  final int initialTimerValue;

  UserAccount({required this.initialTimerValue});

  @override
  State<UserAccount> createState() => _UserAccountState();
}
class _UserAccountState extends State<UserAccount> {
  LocationData? _currentLocation;
  String? userId; // Set this to the authenticated user's ID
  final TextEditingController nameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? userEmail;
  String? user_name='';
  late Client client;
  late Storage storages;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  String? _imageUrl;
  String? _imageURL;
  String? _imageURL_user3;
  String? _imageURL_kids;
  String? user1='User 1';
  String? user2='User 2';
  String? user3='User 3';
  String? kidss='Kids';
  String ipcamera_alt_outlinedress = "Fetching...";
  String androidId = 'Fetching...';
  String currentandroidId='';
  String currentip='';
  double rating=0;
  String _connectionStatus = 'Unknown';
  late Timer _connectivityTimer;
  bool _isConnected=true;
  late BuildContext dialogContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    _getLocation();
    _loadProfilePicture();
    _loadProfilePictureuser2();
    _loadProfilePictureuser3();
    _loaduser3();
    _loadProfilePicturekids();
    _loadusernamekidss();
    _uploadLocationToFirebase();
    _loadusernameuser2();
    fetchTime();
    _loaduser1();
    client = Client();
    storages = Storage(client);
    client
        .setEndpoint('https://cloud.appwrite.io/v1')
        .setProject('64e0600003aac5802fbc');
    getUserEmail();
    fetchusername();
    fetchTime();
    _loadStartTime();
    _startTimer();
    fetchIpcamera_alt_outlinedress();
    fetchcurrentip();
    getDeviceInfo();
    fetchmac();
    startFetchingQuotes();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      dialogContext = context;
      // Call the fetchrating function when the page is loaded
      fetchrating();
    });
  }
  void startFetchingQuotes() {
    // Fetch a new quote initially
    fetchQuote();

    // Set up a periodic timer to fetch a new quote every minute
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      fetchQuote();
    });
  }
  Future<void> fetchrating() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('Ratings Of Users').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          rating=docsnap.data()?['Rating star'];
        });

      }else{
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
      }
    }
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
  String quote = 'Loading Quote of the day';

  Future<void> fetchQuote() async {
    final url = 'https://quotes15.p.rapidapi.com/quotes/random/';
    final headers = {
      'X-RapidAPI-Key': '6992fa44c5msh33494370d8be396p1025d7jsnf75644f6e3ff',
      'X-RapidAPI-Host': 'quotes15.p.rapidapi.com',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          quote = responseData['content'];
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  Future<void> fetchIpcamera_alt_outlinedress() async {
    try {
      var response = await http.get(Uri.parse('https://api64.ipify.org'));
      if (response.statusCode == 200) {
        // Parse the JSON response and update the state with the IP camera_alt_outlinedress.
        setState(() {
          ipcamera_alt_outlinedress = response.body;
        });
        print(ipcamera_alt_outlinedress);
      } else {
        throw Exception('Failed to load IP camera_alt_outlinedress');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  TextEditingController _passwordauth=TextEditingController();
  TextEditingController _passwordauth_user1=TextEditingController();
  TextEditingController _passwordauth_user2=TextEditingController();
  TextEditingController _passwordauth_user3=TextEditingController();
  Future<void> _getLocation() async {
    Location location = Location();
    try {
      LocationData currentLocation = await location.getLocation();
      setState(() {
        _currentLocation = currentLocation;
      });
    } catch (e) {
      print('Error getting location: $e');
    }
  }
  //kids
  Future<void> _loadusernamekidss() async{
    final user=_auth.currentUser;
    if(user!=null){
      try{
        final docsnapkids= await _firestore.collection('User_names_kids').doc(user.uid).get();
        if(docsnapkids.exists){
          setState(() {
            kidss=docsnapkids.data()?['Kids'];
          });
        }
      }catch(e){
        
      }
    }
  }
  File? _selectedImage_kids;
  Future<void> _pickImageuserkids() async {
    final user=_auth.currentUser;
    if(user!.emailVerified){
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _selectedImage_kids = File(pickedFile.path);
        }
      });
      _uploadProfileImagekids();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please verify your email: ${user.email}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> _uploadLocationToFirebase() async {
    try {
      LocationData? currentLocation = _currentLocation;
      User? user = _auth.currentUser;

      if (currentLocation != null && user != null) {
        await _firestore.collection('user_locations').doc(user.uid).set({
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude,
          'speed':currentLocation.speed,
          'time':currentLocation.time,
          'timestamp': FieldValue.serverTimestamp(),
        });

        print('Location data uploaded to Firebase for user ${user.uid}');
      } else {
        print('User not authenticated or location not available');
      }
    } catch (e) {
      print('Error uploading location to Firebase: $e');
    }
  }
  Future<void> _loadProfilePicturekids() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await _firestore.collection('profile_pictures_kids').doc(user.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _imageURL_kids = docSnapshot.data()?['url_kids'];
          });
        }
      } catch (e) {
        print('Error loading profile picture: $e');
      }
    }
  }
  // user 3
  File? _selectedImage;
  File? _selectedImage_user3;
  //user 3
  Future<void> _loaduser3() async{
    final user=_auth.currentUser;
    if(user!=null){
      try{
        final user3usernames=await _firestore.collection('User_names_user3').doc(user.uid).get();
        if(user3usernames.exists){
          setState(() {
            user3=user3usernames.data()?['User 3'];
          });
        }
      }catch(e){

      }
    }
  }
  Future<void> _pickImageuser3() async {
    final user=_auth.currentUser;
    if(user!.emailVerified){
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _selectedImage_user3 = File(pickedFile.path);
        }
      });
      _uploadProfileImageuser3();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please verify your email:${user.email}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> _loadProfilePictureuser3() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await _firestore.collection('profile_pictures_user3').doc(user.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _imageURL_user3 = docSnapshot.data()?['url_user3'];
          });
        }
      } catch (e) {
        print('Error loading profile picture: $e');
      }
    }
  }
  //user 2
  Future<void> _pickImageuser2() async {
    final user=_auth.currentUser;
    if(user!.emailVerified){
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _selectedImage = File(pickedFile.path);
        }
      });
      _uploadProfileImageuser2();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please verify your email: ${user.email}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> _loadusernameuser2() async{
    final user=_auth.currentUser;
    if(user!=null){
      try{
        final usernameuser2=await _firestore.collection('User_names_user2').doc(user.uid).get();
        if(usernameuser2.exists){
          setState(() {
            user2=usernameuser2.data()?['User 2'];
          });
        }
      }catch(e){}
    }
  }
  Future<void> _loadProfilePictureuser2() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await _firestore.collection('profile_pictures_user2').doc(user.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _imageURL = docSnapshot.data()?['url_user2'];
          });
        }
      } catch (e) {
        print('Error loading profile picture: $e');
      }
    }
  }
  // user 1
  Future<void> _pickImage() async {
    final user=_auth.currentUser;
    if(user!.emailVerified){
      final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
        _uploadImage();
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please verify your email: ${user.email}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  Future<void> _loaduser1() async{
    final user =_auth.currentUser;
    if(user!=null){
      try{
        final usernameuser1=await _firestore.collection('User_names').doc(user.uid).get();
        if(usernameuser1.exists){
          setState(() {
            user1=usernameuser1.data()?['User 1'];
          });
        }
      }catch(e){
        print('The error is ${e}');
      }
    }
  }
  Future<void> _loadProfilePicture() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnapshot = await _firestore.collection('profile_pictures').doc(user.uid).get();
        if (docSnapshot.exists) {
          setState(() {
            _imageUrl = docSnapshot.data()?['url_user1'];
          });
        }
      } catch (e) {
        print('Error loading profile picture: $e');
      }
    }
  }
  late Timer _timer;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  int _startTime = 300;
  String username='';
  bool _pictureRevealed=false;
  String usertime = '';
  Future<void> fetchTime() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String uid = user.uid;
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            Timestamp timestamp = snapshot.data()?['time_of_start'] ?? Timestamp.now();
            usertime = timestamp.toDate().toString();
          });
          print('user time ${usertime}');
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
      return DateTime.now();
    }
  }

  int calculateDaysLeft() {
    if (usertime.isNotEmpty) {
      DateTime originalDate = DateTime.now();
      DateTime calculatedDate = calculateTimestampPlus365Days();
      DateTime currentDate = DateTime.now();

      Duration difference = calculatedDate.difference(currentDate);
      int daysLeft = difference.inDays;
      print(daysLeft);
      print('Original Date: $originalDate');
      print('Calculated Date: $calculatedDate');
      print('Current Date: $currentDate');
      print('Days Left: $daysLeft');
      if (daysLeft >0) {
        updateFirestoreSubscription(true);
      }else if (daysLeft <=0) {
        updateFirestoreSubscription(false);
      }
      return daysLeft;
    } else {
      return -1;
    }
  }


  void updateFirestoreSubscription(bool isSubscribed) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user?.uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
          'isSubscribed': isSubscribed,
          'subscription status':'Subscription Over'
        });
      } else {
        debugPrint('User or user.uid is null. Unable to update Firestore document.');
      }
    } catch (e) {
      debugPrint('Error during Firestore update: $e');
    }
  }
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

  bool _uploading = false;
  final auth=FirebaseAuth.instance;
  signoutnotification(){
    AwesomeNotifications().createNotification(content:NotificationContent(id: 10,
      channelKey:'alerts',
      title: 'Thank You For using NetFly',
      body: '🚀 You have succesfully logged\nout of NetFly\nSign-In Again to continue✨',
      wakeUpScreen:true,
      actionType: ActionType.Default,
    ));
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

  User? user = FirebaseAuth.instance.currentUser;
  TextEditingController _usernameController = TextEditingController();
  String _currentUsername = 'User 1';
  String _newUsername = '';
  // Method for user authentication
  void loginUser() async {
    // Existing login logic...

    // Fetch the username from Firestore
    if (user != null) {
      DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users_names').doc(user?.uid).get();
      String storedUsername = docSnap['username'] ?? 'User 1';

      // Update the current username
      setState(() {
        _currentUsername = storedUsername;
      });
    }
  }
  // var namefromhome;
  // _UserAccountState(this.namefromhome);
  TextEditingController _user1name=TextEditingController();
  TextEditingController _user2name=TextEditingController();
  TextEditingController _user3name=TextEditingController();
  TextEditingController _kidsname=TextEditingController();
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
                MotionToast.success(
                    title:  Text("Sign-Out Successful",style: GoogleFonts.aBeeZee(
                      fontWeight: FontWeight.bold,
                    ),),
                    enableAnimation: true,
                    displayBorder: true,
                    displaySideBar: true,
                    animationDuration: Duration(seconds: 10),
                    description:  Text("Thank You For Using NetFly")
                ).show(context);
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
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('NetFly',style: GoogleFonts.amaranth(
          color: Colors.red,
          fontSize: 30,
          fontWeight: FontWeight.bold
        ),),
        actions: [
          IconButton(onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Account_details()),
            );
          },
              icon:Icon(Icons.person)),
          IconButton(onPressed:signoutdialogue,
      icon:Icon(Icons.logout_rounded)
          )],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text('Welcome Back!',style: GoogleFonts.abhayaLibre(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize:20
              )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text('$user_name',style: GoogleFonts.aBeeZee(color: Colors.white,fontSize: 20),),
                  ),
                  SizedBox(width: 5,),
                  if(user!.emailVerified)
                    Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/656e14a775bd67ca290d/view?project=64e0600003aac5802fbc&mode=admin'),
                      height: 30,width: 30,),
                ],
              ),
              SizedBox(height: 20,),
              Text('Who is watching?',style: GoogleFonts.arya(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize:30
              )),
              SizedBox(
                height: 50,
              ),
              // Text(ipcamera_alt_outlinedress,style: TextStyle(color: Colors.white),),Text(currentip,style: TextStyle(color: Colors.white),),

              Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final user=_auth.currentUser;
                          if(user!=null){
                            showDialog(context: context,
                              builder:(context) {
                                return AlertDialog(
                                  title: Text("Please enter password to access ${user1}'s account",style: GoogleFonts.amaranth(
                                    fontWeight:FontWeight.w100,

                                  ),),
                                  content: SingleChildScrollView(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                          //start
                                          TextField(
                                            controller: _passwordauth,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                                hintText: 'Enter Password To Continue'
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                              onPressed: () async{
                                                if (_passwordauth.text.isNotEmpty) {
                                                  try{
                                                    AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: _passwordauth.text);
                                                    await user.reauthenticateWithCredential(credential);
                                                    calculateDaysLeft();
                                                    DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                                                    bool isSubscribed = docSnap['isSubscribed'] ?? false;

                                                    _uploadLocationToFirebase();
                                                    fetchcurrentip();
                                                    fetchIpcamera_alt_outlinedress();

                                                    if (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId) {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => isSubscribed ? const NavBar() : const HomeScreen(),
                                                        ),
                                                      ).then((_) {
                                                        // This code will run after the new screen has been dismissed
                                                        Navigator.pop(context);
                                                      });

                                                      _passwordauth.clear();

                                                      if (isSubscribed && (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId)) {
                                                        _uploadLocationToFirebase();
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Welcome To NetFly\n${user_name}'),
                                                            backgroundColor: Colors.green,
                                                          ),
                                                        );
                                                      }

                                                      if (!isSubscribed) {
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Please Check Your Subscription'),
                                                            backgroundColor: Colors.red,
                                                          ),
                                                        );
                                                      } else if (ipcamera_alt_outlinedress != currentip && androidId != currentandroidId) {
                                                        Navigator.pop(context);
                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                          SnackBar(
                                                            content: Text('Account Sharing is strictly banned by NetFly'),
                                                            backgroundColor: Colors.red,
                                                          ),
                                                        );
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) => const Account_sharing(),
                                                          ),
                                                        );
                                                      }
                                                    } else {
                                                      // Conditions not fulfilled, navigate to Account_sharing() page
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => const Account_sharing(),
                                                        ),
                                                      );
                                                    }
                                                  }catch(e){
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Please enter correct password'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                    _passwordauth.clear();
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Please enter password'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                }

                                              },
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll(Colors.green)
                                              ),
                                              child:Text('Authroise access')),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(onPressed: (){
                                            _passwordauth.clear();
                                            Navigator.pop(context);
                                          },
                                              style: ButtonStyle(
                                                  backgroundColor: MaterialStatePropertyAll(Colors.red)
                                              ),
                                              child:Text('Close'))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },);
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                        ),
                        child: Column(
                          children: [
                            // ... existing code ...
                           Stack(
                             children: [
                               _uploading
                                   ? CircularProgressIndicator(
                                 color: Colors.red,
                               ) // Show the progress indicator while uploading
                                   : _imageUrl == null
                                   ? CircleAvatar(
                                   backgroundColor: Colors.black,
                                   radius: 50,
                                   child: Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'))
                               )
                                   : CircleAvatar(
                                 backgroundColor: Colors.black,
                                 radius: 50,
                                 backgroundImage: NetworkImage(_imageUrl!),
                               ),
                               Positioned(child: IconButton(onPressed: (){
                                 _pickImage();

                               }, icon:Icon(Icons.add_a_photo,size: 15,)),
                               bottom: -10,
                               left: 70,)
                             ],
                           ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  '${user1}',
                                  style: GoogleFonts.amaranth(
                                    color: Colors.white,
                                    fontSize: 15,
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  showDialog(context: context,
                                    builder:(context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        backgroundColor: Colors.white,
                                        title: Text('Rename User Name'),
                                        content: Column(
                                          children: [
                                            Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                            TextField(
                                              controller: _user1name,

                                              decoration: InputDecoration(
                                                  hintText: '${user1}'
                                              ),
                                            ),
                                          ],

                                        ),
                                        actions: [
                                          ElevatedButton(onPressed: ()async{
                                            await _firestore.collection('User_names').doc(user?.uid).set({
                                              'User 1':_user1name.text
                                            });
                                            setState(() {
                                              user1=_user1name.text;
                                            });
                                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text('User name changed to ${_user1name.text}'),
                                            ));
                                            Navigator.pop(context);
                                            _user1name.clear();
                                          },
                                              child:Text('Save'))
                                        ],
                                      );
                                    },);
                                },
                                    icon:Icon(Icons.drive_file_rename_outline,size: 15,))
                              ],
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(onPressed: ()async{
                        final user=_auth.currentUser;
                        if(user!=null){
                          showDialog(context: context,
                            builder:(context) {
                              return AlertDialog(
                                title: Text("Please enter password to access ${user2}'s account",style: GoogleFonts.amaranth(
                                  fontWeight:FontWeight.w100,

                                ),),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                        //start
                                        TextField(
                                          obscureText: true,
                                          controller: _passwordauth_user2,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Password To Continue'
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: () async{
                                          if (_passwordauth_user2.text.isNotEmpty) {
                                            try{
                                              AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: _passwordauth_user2.text);
                                              await user.reauthenticateWithCredential(credential);
                                              calculateDaysLeft();
                                              DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                                              bool isSubscribed = docSnap['isSubscribed'] ?? false;

                                              _uploadLocationToFirebase();
                                              fetchcurrentip();
                                              fetchIpcamera_alt_outlinedress();

                                              if (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => isSubscribed ? const NavBar() : const HomeScreen(),
                                                  ),
                                                ).then((_) {
                                                  // This code will run after the new screen has been dismissed
                                                  Navigator.pop(context);
                                                });

                                                _passwordauth_user2.clear();

                                                if (isSubscribed && (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId)) {
                                                  _uploadLocationToFirebase();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Welcome To NetFly\n${user_name}'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                }

                                                if (!isSubscribed) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Please Check Your Subscription'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                } else if (ipcamera_alt_outlinedress != currentip && androidId != currentandroidId) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Account Sharing is strictly banned by NetFly'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const Account_sharing(),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                // Conditions not fulfilled, navigate to Account_sharing() page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const Account_sharing(),
                                                  ),
                                                );
                                              }
                                            } catch(e){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Please enter correct password'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              _passwordauth_user2.clear();
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Please enter password'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.green)
                                            ),
                                            child:Text('Authroise access')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: (){
                                          _passwordauth_user2.clear();
                                          Navigator.pop(context);
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                                            ),
                                            child:Text('Close'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },);
                        }
                      },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                          ),

                          child:Column(
                            children: [
                              Stack(
                                children: [
                                  _uploading
                                      ? CircularProgressIndicator(
                                    color: Colors.red,
                                  ) // Show the progress indicator while uploading
                                      : _imageURL == null
                                      ? CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 50,
                                      child: Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'))
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 50,
                                    backgroundImage: NetworkImage(_imageURL!),
                                  ),
                                  Positioned(child: IconButton(onPressed: (){
                                    // _deleteprofileimageuser();
                                    _pickImageuser2();

                                  }, icon:Icon(Icons.add_a_photo,size: 15,)),
                                  bottom: -10,
                                  left: 70,),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${user2}',
                                    style: GoogleFonts.amaranth(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                      builder:(context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          backgroundColor: Colors.white,
                                          title: Text('Rename User Name'),
                                          content: Column(
                                            children: [
                                              Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                              TextField(
                                                controller: _user2name,
                                                decoration: InputDecoration(
                                                    hintText: '${user2}'
                                                ),
                                              ),

                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(onPressed: ()async{
                                              await _firestore.collection('User_names_user2').doc(user?.uid).set({
                                                'User 2':_user2name.text
                                              });
                                              setState(() {
                                                user2=_user2name.text;
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text('User name changed to ${_user2name.text}'),
                                              ));
                                              Navigator.pop(context);
                                              _user2name.clear();
                                            },
                                                child:Text('Save'))
                                          ],
                                        );
                                      },);
                                  },
                                      icon:Icon(Icons.drive_file_rename_outline,size: 15,))
                                ],
                              ),
                            ],
                          )
                      ),
                      ElevatedButton(onPressed: ()async{
                        final user=_auth.currentUser;
                        if(user!=null){
                          showDialog(context: context,
                            builder:(context) {
                              return AlertDialog(
                                title: Text("Please enter password to access ${user3}'s account",style: GoogleFonts.amaranth(
                                  fontWeight:FontWeight.w100,

                                ),),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                        //start
                                        TextField(
                                          obscureText: true,
                                          controller: _passwordauth_user3,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Password To Continue'
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: () async{
                                          if (_passwordauth_user3.text.isNotEmpty) {
                                            try{
                                              AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: _passwordauth_user3.text);
                                              await user.reauthenticateWithCredential(credential);
                                              calculateDaysLeft();
                                              DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                                              bool isSubscribed = docSnap['isSubscribed'] ?? false;

                                              _uploadLocationToFirebase();
                                              fetchcurrentip();
                                              fetchIpcamera_alt_outlinedress();

                                              if (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => isSubscribed ? const NavBar() : const HomeScreen(),
                                                  ),
                                                ).then((_) {
                                                  // This code will run after the new screen has been dismissed
                                                  Navigator.pop(context);
                                                });

                                                _passwordauth_user3.clear();

                                                if (isSubscribed && (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId)) {
                                                  _uploadLocationToFirebase();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Welcome To NetFly\n${user_name}'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                }

                                                if (!isSubscribed) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Please Check Your Subscription'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                } else if (ipcamera_alt_outlinedress != currentip && androidId != currentandroidId) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Account Sharing is strictly banned by NetFly'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const Account_sharing(),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                // Conditions not fulfilled, navigate to Account_sharing() page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const Account_sharing(),
                                                  ),
                                                );
                                              }
                                            }catch(e){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Please enter correct password'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Please enter password'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.green)
                                            ),
                                            child:Text('Authroise access')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: (){
                                          _passwordauth_user3.clear();
                                          Navigator.pop(context);
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                                            ),
                                            child:Text('Close'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },);
                        }
                      },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                          ),
                          child:Column(
                            children: [
                             Stack(
                               children: [
                                 _uploading
                                     ? CircularProgressIndicator(
                                   color: Colors.red,
                                 ) // Show the progress indicator while uploading
                                     : _imageURL_user3 == null
                                     ? CircleAvatar(
                                     backgroundColor: Colors.black,
                                     radius: 50,
                                     child: Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'))
                                 )
                                     : CircleAvatar(
                                   backgroundColor: Colors.black,
                                   radius: 50,
                                   backgroundImage: NetworkImage(_imageURL_user3!),
                                 ),
                                 Positioned(child: IconButton(onPressed: (){
                                   _pickImageuser3();

                                 }, icon:Icon(Icons.add_a_photo,size: 15,)),
                                 bottom: -10,
                                 left: 70,),
                               ],
                             ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${user3}',
                                    style: GoogleFonts.amaranth(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                      builder:(context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          backgroundColor: Colors.white,
                                          title: Text('Rename User Name'),
                                          content: Column(
                                            children: [
                                              Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                              TextField(
                                                controller: _user3name,
                                                decoration: InputDecoration(
                                                    hintText: '${user3}'
                                                ),
                                              ),

                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(onPressed: ()async{
                                              await _firestore.collection('User_names_user3').doc(user?.uid).set({
                                                'User 3':_user3name.text
                                              });
                                              setState(() {
                                                user3=_user3name.text;
                                              });
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor: Colors.green,
                                                content: Text('User name changed to ${_user3name.text}'),
                                              ));
                                              Navigator.pop(context);
                                              _user3name.clear();
                                            },
                                                child:Text('Save'))
                                          ],
                                        );
                                      },);
                                  },
                                      icon:Icon(Icons.drive_file_rename_outline,size: 15,))
                                ],
                              ),
                            ],
                          )
                      ),
                      ElevatedButton(onPressed: ()async{
                        final user=_auth.currentUser;
                        if(user!=null){
                          showDialog(context: context,
                            builder:(context) {
                              return AlertDialog(
                                title: Text("Please enter password to access ${kidss}'s account ",style: GoogleFonts.amaranth(
                                  fontWeight:FontWeight.w100,
                                ),),
                                content: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                        //start
                                        TextField(
                                          obscureText: true,
                                          controller: _passwordauth_user1,
                                          decoration: InputDecoration(
                                              hintText: 'Enter Password To Continue'
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: () async{
                                          if (_passwordauth_user1.text.isNotEmpty) {
                                            try{
                                              AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: _passwordauth_user1.text);
                                              await user.reauthenticateWithCredential(credential);
                                              calculateDaysLeft();
                                              DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
                                              bool isSubscribed = docSnap['isSubscribed'] ?? false;

                                              _uploadLocationToFirebase();
                                              fetchcurrentip();
                                              fetchIpcamera_alt_outlinedress();

                                              if (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => isSubscribed ? const NavBar() : const HomeScreen(),
                                                  ),
                                                ).then((_) {
                                                  // This code will run after the new screen has been dismissed
                                                  Navigator.pop(context);
                                                });

                                                _passwordauth_user1.clear();

                                                if (isSubscribed && (ipcamera_alt_outlinedress == currentip || androidId == currentandroidId)) {
                                                  _uploadLocationToFirebase();
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Welcome To NetFly\n${user_name}'),
                                                      backgroundColor: Colors.green,
                                                    ),
                                                  );
                                                }

                                                if (!isSubscribed) {
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Please Check Your Subscription'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                } else if (ipcamera_alt_outlinedress != currentip && androidId != currentandroidId) {
                                                  Navigator.pop(context);
                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Text('Account Sharing is strictly banned by NetFly'),
                                                      backgroundColor: Colors.red,
                                                    ),
                                                  );
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const Account_sharing(),
                                                    ),
                                                  );
                                                }
                                              } else {
                                                // Conditions not fulfilled, navigate to Account_sharing() page
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => const Account_sharing(),
                                                  ),
                                                );
                                              }
                                            } catch(e){
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Please enter correct password'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                              _passwordauth_user1.clear();
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Please enter password'),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.green)
                                            ),
                                            child:Text('Authroise access')),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(onPressed: (){
                                          _passwordauth_user3.clear();
                                          Navigator.pop(context);
                                        },
                                            style: ButtonStyle(
                                                backgroundColor: MaterialStatePropertyAll(Colors.red)
                                            ),
                                            child:Text('Close'))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },);
                        }
                      },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.transparent)
                          ),
                          child:Column(
                            children: [
                              Stack(
                                children: [
                                  _uploading
                                      ? CircularProgressIndicator(
                                    color: Colors.red,
                                  ) // Show the progress indicator while uploading
                                      : _imageURL_kids == null
                                      ? CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 50,
                                      child: Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'))
                                  )
                                      : CircleAvatar(
                                    backgroundColor: Colors.black,
                                    radius: 50,
                                    backgroundImage: NetworkImage(_imageURL_kids!),
                                  ),
                                  Positioned(child: IconButton(onPressed: (){
                                    _pickImageuserkids();
                                  }, icon:Icon(Icons.add_a_photo,size: 15,)),
                                  bottom: -10,
                                  left: 70,)
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    '${kidss}',
                                    style: GoogleFonts.amaranth(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                  IconButton(onPressed: (){
                                    showDialog(context: context,
                                      builder:(context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          backgroundColor: Colors.white,
                                          title: Text('Rename User Name'),
                                          content: Column(

                                            children: [
                                              Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                              TextField(
                                                controller: _kidsname,
                                                decoration: InputDecoration(
                                                    hintText: '${kidss}'
                                                ),
                                              ),

                                            ],
                                          ),
                                          actions: [
                                            ElevatedButton(onPressed: ()async{
                                              if(_kidsname.text.isNotEmpty){
                                                await _firestore.collection('User_names_kids').doc(user?.uid).set({
                                                  'Kids':_kidsname.text
                                                });
                                                setState(() {
                                                  kidss=_kidsname.text;
                                                });
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: Colors.green,
                                                  content: Text('User name changed to ${_kidsname.text}'),
                                                ));
                                                Navigator.pop(context);
                                                _kidsname.clear();
                                              }else{
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content: Text('Please enter a username ${user_name}'),
                                                ));
                                              }
                                            },
                                                child:Text('Save'))
                                          ],
                                        );
                                      },);
                                  },
                                      icon:Icon(Icons.drive_file_rename_outline,size: 15,))
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                )
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
                          style: ButtonStyle(backgroundColor:MaterialStatePropertyAll(Color(0xFFFFD700))),
                          child:Text('Renew Plan Again',style: GoogleFonts.aboreto(
                              color: Colors.black,
                              fontWeight: FontWeight.bold
                          ),)),
                    ),
                  ],
                ),
              if(calculateDaysLeft()==0)
                Column(
                  children: [
                    SizedBox(height: 50,),
                    Text('Your Subscription is over\n\nPlease renew to continue',style: GoogleFonts.aBeeZee(
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
              if(calculateDaysLeft()>=2 && calculateDaysLeft()<=5)
                Column(
                  children: [
                    SizedBox(height: 50,),
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
              if(calculateDaysLeft()>5)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Center(child: Text('Quote Of the day:',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 18),)),
                    SizedBox(
                      height: 20,
                    ),
                    Center(child: Text( quote,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w200,fontSize: 18),)),
                  ],
                ),
              SizedBox(
                height: 100,
              )
            ],
          ),

        ),
      ),
    );
  }
  Future<void> _delteprofileimagekids() async{
    final user=_auth.currentUser;
    if(user!=null && user.emailVerified){
      try{
        await _firestore.collection('profile_pictures_kids').doc(user.uid).update({
          'url_kids':'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'
        });
        setState(() {
          _imageURL_kids='https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Profile picture removed successfully!'),
          )
          );
        });
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Removing Profile Picture!'),
        )
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please verify your email: ${user!.email}'),
      )
      );
    }
  }
  Future<void> _uploadProfileImagekids() async {
    try {
      final user = _auth.currentUser;
      if (user != null &&  _selectedImage_kids!= null) {

        // Upload image to Firebase Storage
        final reference = _storage.ref().child('profile_pictures_kids/${user.uid}');
        await reference.putFile(_selectedImage_kids!);
        final imageURL = await reference.getDownloadURL();

        // Update user profile in Firebase Authentication
        await user.updateProfile(photoURL: imageURL);

        // Store the URL in Firestore
        await _firestore
            .collection('profile_pictures_kids')
            .doc(user.uid)
            .set({
          'url_kids': imageURL,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _imageURL_kids = imageURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }
  Future<void> _delteprofileimageuser3() async{
    final user=_auth.currentUser;
    if(user!=null && user.emailVerified){
      try{
        await _firestore.collection('profile_pictures_user3').doc(user.uid).update({
          'url_user3':'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'
        });
        setState(() {
          _imageURL_user3='https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Profile picture removed successfully!'),
          )
          );
        });
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Removing Profile Picture!'),
        )
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please verify your email: ${user!.email}'),
      )
      );
    }

  }
  Future<void> _uploadProfileImageuser3() async {
    try {
      final user = _auth.currentUser;
      if (user != null &&  _selectedImage_user3!= null) {

        // Upload image to Firebase Storage
        final reference = _storage.ref().child('profile_pictures_user3/${user.uid}');
        await reference.putFile(_selectedImage_user3!);
        final imageURL = await reference.getDownloadURL();

        // Update user profile in Firebase Authentication
        await user.updateProfile(photoURL: imageURL);

        // Store the URL in Firestore
        await _firestore
            .collection('profile_pictures_user3')
            .doc(user.uid)
            .set({
          'url_user3': imageURL,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _imageURL_user3 = imageURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }

  Future<void> _deleteprofileimageuser2() async{
    try{
      final user=_auth.currentUser;
      if(user!=null && user.emailVerified){
        await _firestore.collection('profile_pictures_user2').doc(user.uid).update(
            {
              'url_user2':'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'
            });
        setState(() {
          _imageURL='https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin';
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture removed successfully!'),

        )
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please verify your email: ${user!.email}'),
        )
        );
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Couldnot remove profile picture!'),
      )
      );
    }
  }
  Future<void> _uploadProfileImageuser2() async {
    try {
      final user = _auth.currentUser;
      if (user != null && _selectedImage != null) {

        // Upload image to Firebase Storage
        final reference = _storage.ref().child('profile_pictures_user2/${user.uid}');
        await reference.putFile(_selectedImage!);
        final imageURL = await reference.getDownloadURL();

        // Update user profile in Firebase Authentication
        await user.updateProfile(photoURL: imageURL);

        // Store the URL in Firestore
        await _firestore
            .collection('profile_pictures_user2')
            .doc(user.uid)
            .set({
          'url_user2': imageURL,
          'timestamp': FieldValue.serverTimestamp(),
        });

        setState(() {
          _imageURL = imageURL;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        )
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }
  Future<void> _deleteimageuser1() async{
    final user=_auth.currentUser;
    if(user!=null && user.emailVerified){
      try{
        await _firestore.collection('profile_pictures').doc(user?.uid).update({
          'url_user1':'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'
        });
        setState(() {
          _imageUrl='https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin';
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green,
            content: Text('Profile picture removed successfully!'),
          )
          );
        });
      }catch(e){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Error Removing Profile Picture'),
        )
        );
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please verify your email: ${user!.email}'),
      )
      );
    }
  }
  Future<void> _uploadImage() async {
    try {
      final user = _auth.currentUser;
      if (user != null && _image != null) {
        setState(() {
          _uploading = true;
        });
        final ref = _storage.ref().child('profile_pictures/${user.uid}');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();

        await user.updateProfile(photoURL: imageUrl);

        // Store the URL in Firestore
        await _firestore.collection('profile_pictures').doc(user.uid).set({'url_user1': imageUrl,
        'time stamp':FieldValue.serverTimestamp()
        });

        setState(() {
          _uploading = false;
          _imageUrl = imageUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        ));
      }
    } catch (e) {
      setState(() {
        _uploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }
  void _loadStartTime() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
    await FirebaseFirestore.instance.collection('timers').doc('timer').get();

    if (snapshot.exists) {
      setState(() {
        _startTime = snapshot.data()!['timerValue'] ?? widget.initialTimerValue;
      });
    }
  }

  void _startTimer() {
    const oneSecond = Duration(seconds: 1);

    _timer = Timer.periodic(oneSecond, (timer) {
      if (_startTime > 0) {
        setState(() {
          _startTime--;
        });
        _saveStartTime();
      } else {
        timer.cancel();
        setState(() {
          _pictureRevealed = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _saveStartTime(); // Save the final timer value when the widget is disposed
    super.dispose();
  }

  void _saveStartTime() async {
    // Save the current timer value to Firestore
    await FirebaseFirestore.instance
        .collection('timers')
        .doc('timer')
        .set({'timerValue': _startTime});
  }
}
