import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
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
class Account_details extends StatefulWidget {
  const Account_details({Key? key}) : super(key: key);

  @override
  State<Account_details> createState() => _Account_detailsState();
}

class _Account_detailsState extends State<Account_details> {
  TextEditingController _name=TextEditingController();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  String usertime = '';
  String emailchangedates='';
  bool isDarkMode = false;
  Icon currentIcon = Icon(Icons.sunny);
  bool showElevatedButton = false;
  User? user = FirebaseAuth.instance.currentUser;
  bool ispaid=false;
  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      currentIcon = isDarkMode ? Icon(Icons.sunny) : Icon(Icons.nightlight);
    });
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final auth=FirebaseAuth.instance;
  String? userEmail;
  String user_name='';
  String userPassword = ''; // Updated to store the user's password
  late User? _user;
  String user_payment='';
  String emailChangeDates = "";
  final ImagePicker _imagePicker = ImagePicker();
  File? _image;
  String? _imageUrl;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool _uploading = false;
  String phone='';
  @override
  void initState() {
    super.initState();
    getUserEmail();
    _user = _auth.currentUser;
    fetchPassword();
    fetchusername();
    fetchPayment_id();
    fetchEmailChangeDate();
    _loadProfilePicture();
    getPaymentIds();
    fetchTime();// Fetch the user's password when the widget initializes
  }
  Future<void> deleteAccountAndPhoneNumber() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Check if the user is not null
      if (user != null) {
        // Reference to the Firestore collection
        CollectionReference users = FirebaseFirestore.instance.collection('Clients');

        // Get the user's document from Firestore
        DocumentSnapshot userDoc = await users.doc(user.uid).get();

        // Get the associated phone number from the document
        String phoneNumber = userDoc.get('phoneNumber');

        // Delete the user account
        await user.delete();

        // If the user had a phone number, remove it from Firebase Authentication
        if (phoneNumber != null && phoneNumber.isNotEmpty) {
          // Optional: You can add additional logic here to remove the phone number from your authentication system.
          print("Phone number ($phoneNumber) removed from Firebase Authentication");
        }

        print("User account deleted successfully");
      } else {
        print("User is not authenticated");
      }
    } catch (e) {
      print("Error deleting user account and phone number: $e");
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
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
  Future<void> changeEmail(String newEmail, String password) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Step 0: Verify user's password
        AuthCredential credential = EmailAuthProvider.credential(email: user.email!, password: password);
        await user.reauthenticateWithCredential(credential);

        // Step 1: Send verification email
        await user.updateEmail(newEmail);

        // Step 2: Update the 'time of email change' in Firestore
        var userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);
        var userData = await userDocRef.get();
        var timeOfEmailChange = userData.data()?['time of email change'];

        if (timeOfEmailChange == null) {
          // 'time of email change' field does not exist, create and set the value
          await userDocRef.update({
            'time of email change': FieldValue.serverTimestamp(),
          });

          // Display a message to the user about the update
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Time of Email Change Updated'),
                content: Text(
                  'The time of email change has been updated. Thank you!',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Continue with the rest of your logic
                      updateEmail(newEmail);
                      _newEmailController.clear();
                      _auth.signOut();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        print('Verification email sent to: $newEmail');

        // Display a message to the user indicating that a verification email has been sent.
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Email Changed Successfully'),
              content: Text(
                'Email Updated to ${newEmail}.\nPlease contact us if you feel anything is a mistake.\nPlease login again for changes to take place',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Continue with the rest of your logic
                    updateEmail(newEmail);
                    _newEmailController.clear();
                    _auth.signOut();
                  },
                  child: Text('OK'),
                ),

              ],
            );
          },
        );
      } catch (e) {
        print('Error sending verification email: $e');
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error Sending Email'),
              content: Text(
                'Error Sending Email as email already exists or incorrect password.\nIf you feel it\'s a mistake, please sign in and try again',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Continue with the rest of your logic
                    updateEmail(newEmail);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        // Handle the error, such as displaying an error message to the user.
      }
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Not Signed In'),
            content: Text(
              'User Must Be signed in to continue',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // Continue with the rest of your logic
                  updateEmail(newEmail);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      print('User is not signed in.');
      // Handle the case where the user is not signed in.
    }
  }


  triggernotification() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'alerts',
          title: 'Subscription Renewed',
          body:
          'Subscription Renewed for ${user_name}',
          wakeUpScreen: true,
        ));
  }
  Future<void> updateEmail(String newEmail) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Step 2: Update the email in Firebase Authentication
        await user.updateEmail(newEmail);
        await FirebaseFirestore.instance
            .collection('Clients')
            .doc(user?.uid)
            .update({
          'email id': _newEmailController.text,
          'Time Of Change':FieldValue.serverTimestamp()
        });
        setState(() {
          userEmail=_newEmailController.text;
        });
        print('Email updated in Firebase to: $newEmail');
      } catch (e) {
        print('Error updating email: $e');
        // Handle the error, such as displaying an error message to the user.
      }
    } else {
      print('User is not signed in.');
      // Handle the case where the user is not signed in.
    }
  }

  Future<void> _clearMessages() async {
    setState(() async {
      // Clear the local _messages list

      // Access the Firestore collection
      CollectionReference messagesCollection = FirebaseFirestore.instance.collection('chat_history').doc(_user!.uid).collection('messages');

      // Get a reference to all documents in the collection
      QuerySnapshot querySnapshot = await messagesCollection.get();

      // Iterate through the documents and delete them
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    });
  }
  triggernotifications() {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'alerts',
          title: 'Subscription succesfully cancelled',
          body:
          'Dear ${user_name},\nYour Subscription has been succesfully cancelled on ${DateTime.now()}.\n'
              'Thank You for using NetFly\n'
              'Team NetFly.',
          wakeUpScreen: true,
        ));
  }

  Future<void> fetchEmailChangeDate() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          // Ensure the 'time_of_start' field is a valid timestamp in Firestore
          Timestamp timestamp = snapshot.data()?['time of email change'] ?? Timestamp.now();
          DateTime emailChangeDate = timestamp.toDate(); // Convert Firestore timestamp to DateTime

          // Calculate the time difference
          Duration difference = DateTime.now().difference(emailChangeDate);
          int daysDifference = difference.inDays;
          setState(() {
            // Show the elevated button only after 10 days
            showElevatedButton = daysDifference ==0;
            emailChangeDates = emailChangeDate.toString();
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
  Future<List<String>> getPaymentIds() async {
    try {
      // Fetch payment IDs from Firestore
      final user = _auth.currentUser;

      if (user != null) {
        DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (docSnap.exists) {
          // Retrieve payment IDs from Firestore
          List<String> paymentIds = List<String>.from(docSnap['payment_ids']);
          return paymentIds;
        } else {
          // Handle the case when the document doesn't exist
          print('Error fetching payment IDs: Document does not exist');
          return [];
        }
      } else {
        // Handle the case when the user is not signed in
        print('Error fetching payment IDs: User not signed in');
        return [];
      }
    } catch (e) {
      // Handle other errors
      print('Error fetching payment IDs: $e');
      return [];
    }
  }

  Future<void> fetchPassword() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Clients').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            userPassword = snapshot.data()?['password'] ?? '';
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
  bool isChecked=false;
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
  TextEditingController _password=TextEditingController();
  Future<void> fetchPayment_id() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            user_payment = snapshot.data()?['payment id'] ?? '';
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
  TextEditingController _passwordcancelmembership=TextEditingController();
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
  //365 days membership days

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
      if(daysLeft<=0){
        updateFirestoreSubscription(false);
      }
      return daysLeft;
    } else {
      return -1; // Return a negative value to indicate an error or no timestamp available
    }
  }
  void updateFirestoreSubscription(bool isSubscribed) async {
    try {
      // Check if the document exists
      if (user?.uid != null) {
        await FirebaseFirestore.instance.collection('users').doc(user?.uid).update({
          'subscription status':'Subscription Over'
        });
        triggernotification();
        print('Firestore document updated. User is no longer subscribed.');
      } else {
        print('User or user.uid is null. Unable to update Firestore document.');
      }
    } catch (e) {
      print('Error during Firestore update: $e');
      // Handle the error as needed
    }
  }
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<void> deleteUserAndFirestoreData() async {
    // Get the current authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Delete the user from Firebase Authentication
        await FirebaseAuth.instance.currentUser?.delete();

        // Delete the user's document from Firestore
        await FirebaseFirestore.instance.collection('Clients').doc(user.uid).delete();
        //await FirebaseFirestore.instance.collection('users_search').doc(user.uid).delete();

        print('User deleted successfully from Authentication and Firestore');
      } catch (e) {
        print('Error deleting user: $e');
      }
    } else {
      print('No current user found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          'NetFly',
          style: GoogleFonts.amaranth(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: currentIcon,
            onPressed: toggleTheme,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          // IconButton(
          //   onPressed: () {
          //     _auth.signOut();
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const HomeScreen()),
          //     );
          //   },
          //   color: isDarkMode ? Colors.white : Colors.black,
          //   icon: Icon(Icons.logout),
          // ),
        ],
      ),
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  ' Account Details',
                  style: GoogleFonts.arya(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      letterSpacing: 2,
                      wordSpacing: 1),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              Divider(
                color: isDarkMode ? Colors.yellowAccent : Colors.black,
                indent: 60,
                endIndent: 60,
                thickness: 0.5,
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  ' Membership And Billing',
                  style: GoogleFonts.arya(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize:35 ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  Text(
                    ' User-Email:',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  Text(
                    '${userEmail}',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.yellow : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  SizedBox(
                    height: 20,
                  ),


    ],),
              SizedBox(
                height: 20,
              ),
              // Text('Email-Verified', style: GoogleFonts.aboreto(
              //     color: isDarkMode ? Colors.white : Colors.black,
              //     fontWeight: FontWeight.w300,
              //     fontSize: 30,
              //     letterSpacing: 2,
              //     wordSpacing: 1),),

              SizedBox(
                height: 10,
              ),
              Column(
                children: [

                  Text(
                    ' Password:',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  Text(
                    '********',
                    style:  GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.yellow : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),

                  // SizedBox(
                  //   height: 1,
                  // ),

                  // SizedBox(
                  //   height: 1,
                  // ),
                  Text(
                    ' Member Since:',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  Text(
                    '${usertime.toString().split(' ')[0]}',
                    style:  GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.yellow : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Text(
                    ' Membership End:',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  Text(
                    '${calculateTimestampPlus365Days().toString().split(' ')[0]}',
                    style:  GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.yellow : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '${user_payment}',
                    style:  GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.yellow : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Days Left:',style: GoogleFonts.aboreto(
                      color: isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: 30,
                      letterSpacing: 2,
                      wordSpacing: 1),),
            calculateDaysLeft() > 0
                ? Text(
              '${calculateDaysLeft()}',
              style: GoogleFonts.aboreto(
                color: isDarkMode ? Colors.yellow : Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: 20,
                letterSpacing: 2,
                wordSpacing: 1,
              ),
            )
                :Text(
              'Subscription Over',

              style: TextStyle(
                color: isDarkMode ? Colors.red : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
                  SizedBox(
                    height: 20,
                  ),
            if(calculateDaysLeft()<=5)
              TextButton(onPressed: (){
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
                  child:Text('Renew Plan Again',style: GoogleFonts.arya(
                    color: isDarkMode ? Colors.black : Colors.black,
                  ),)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    ' UserName:',
                    style: GoogleFonts.aboreto(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 30,
                        letterSpacing: 2,
                        wordSpacing: 1),
                  ),


                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${user_name}',
                        style: GoogleFonts.aboreto(
                          color: isDarkMode ? Colors.yellow : Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          letterSpacing: 2,
                          wordSpacing: 1,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),

                      if(user!.emailVerified)
                        Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/656e14a775bd67ca290d/view?project=64e0600003aac5802fbc&mode=admin'),
                        height: 30,width: 30,),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Account Actions', style: GoogleFonts.aboreto(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          letterSpacing: 2,
                          wordSpacing: 1),),
                      IconButton(onPressed: (){
                        setState(() {
                          isChecked=!isChecked;
                        });
                        print(isChecked);
                      }, icon: Icon(isChecked?Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded,color: isDarkMode ? Colors.white : Colors.black,))
                    ],
                  ),
                  if(isChecked)
                    Column(
                      children: [
                        Center(
                          child: FutureBuilder(
                              future: _auth.currentUser?.reload(),
                              builder: (context,snapshot){
                                if(snapshot.connectionState==ConnectionState.waiting){
                                  return CircularProgressIndicator(
                                    color: Colors.red,
                                  );
                                }else{
                                  final user=_auth.currentUser;
                                  final isEmailVerified = user?.emailVerified ?? false;
                                  return Column(
                                    children: [

                                      if(!isEmailVerified)
                                        TextButton(
                                          onPressed: () async {
                                            try {
                                              await user?.sendEmailVerification();
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Verification email sent to:${userEmail}'),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                            } catch (e) {
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Error sending verification email:${userEmail}'),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            }
                                          },
                                          child: Text('Verify Email',style: GoogleFonts.arya(
                                            color: isDarkMode ? Colors.blue : Colors.red,
                                          ),),
                                        ),
                                    ],
                                  );
                                }
                              }
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext) {
                                return AlertDialog(
                                  title: Column(
                                    children: [
                                      TextField(
                                        controller: _newEmailController,
                                        decoration: InputDecoration(
                                          hintText: '${userEmail}',
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      TextField(  // Add a new TextField for password input
                                        controller: _passwordController,  // Assuming you have a TextEditingController named _passwordController
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          hintText: 'Enter your password',
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      ElevatedButton(
                                        onPressed: () {
                                          String newEmail = _newEmailController.text;
                                          String password = _passwordController.text;  // Retrieve the password from the second TextField
                                          changeEmail(newEmail, password);
                                        },
                                        child: Text('Change Email'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text('Change Email',style: GoogleFonts.arya(
                            color: isDarkMode ? Colors.red : Colors.red,
                          ),),
                        ),
                        TextButton(onPressed: ()async{
                          auth.sendPasswordResetEmail(email: userEmail.toString()).then((value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Reset Link Sent to ${userEmail}'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }).onError((error, stackTrace){
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error Occurred Sending reset link to ${userEmail}'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          });
                        },
                            child: Text('Change Password',style: GoogleFonts.arya(
                              color: isDarkMode ? Colors.red : Colors.red,
                            ),
                            )
                        ),
                        TextButton(onPressed: (){
                          showDialog(context: context,
                            builder:(BuildContext context) {

                              return AlertDialog(
                                scrollable: true,
                                elevation: 10,
                                shadowColor: Colors.white,
                                surfaceTintColor: Colors.green,
                                title: Text('Change User Name',style: TextStyle(color: Colors.blue),),
                                content: Column(
                                  children: [
                                    Text('Welcome To NetFly User-Name Changing Portal',style: GoogleFonts.aBeeZee(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin')),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    Text('Please Type Your New User-Name',style: GoogleFonts.aBeeZee(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w300
                                    ),),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(color: Colors.green),
                                          borderRadius: BorderRadius.all(Radius.circular(50))
                                      ),
                                      child: TextField(
                                        controller: _name,
                                        maxLines: 1,
                                        maxLength: 17,
                                        decoration: InputDecoration(
                                          counterText: '',
                                            prefixIcon: Icon(Icons.person),
                                            hintText: "  ${user_name}"
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    ElevatedButton(onPressed: (){
                                      Navigator.pop(context);
                                      _name.clear();
                                    },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.red)
                                        ),
                                        child: Text('Cancel')),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(onPressed: ()async{
                                      if(_name.toString().isNotEmpty){
                                        await FirebaseFirestore.instance
                                            .collection('Clients')
                                            .doc(user?.uid)
                                            .update({
                                          'username': _name.text,
                                        });
                                        await FirebaseFirestore.instance
                                            .collection('Clients')
                                            .doc(user?.uid)
                                            .update({
                                          'username': _name.text,
                                        });

                                        // Update the displayed username
                                        setState(() {
                                          user_name = _name.text;
                                        });
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('User Name Changed To ${user_name}'),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                        _name.clear();
                                      }else if(_name.toString().isEmpty){
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Please Enter Your User-Name'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStatePropertyAll(Colors.green)
                                        ),
                                        child: Text('Confirm Changes')),
                                  ],
                                ),
                              );
                            },);
                        },

                            child: Text('Change User Name',style: GoogleFonts.arya(
                                color: isDarkMode ? Colors.red : Colors.red,
                                fontWeight: FontWeight.bold
                            ),
                            )
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () async {
                            bool isChecked = false; // Initial checkbox state

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  scrollable: true,
                                  title: Text(
                                    'Are You Sure You Want to Delete Your Subscription?',
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value ?? false;
                                                  });
                                                },
                                              ),
                                              Center(
                                                child: Text(
                                                  'Subscription Once\ncancelled cannot be\nrefunded',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          if(isChecked)
                                            TextField(
                                              controller: _passwordcancelmembership,
                                              decoration: InputDecoration(
                                                hintText: 'Please enter password to continue ${user_name}',
                                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                              ),
                                              obscureText: true,
                                            ),
                                          Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                                                  ),
                                                  child: Text('Go Back'),
                                                ),
                                                SizedBox(height: 20),
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    if (isChecked) {
                                                      // Only cancel subscription if checkbox is checked
                                                      final user=_auth.currentUser;
                                                      if(user!=null){
                                                        if(_passwordcancelmembership.text.isNotEmpty){
                                                          try{
                                                            AuthCredential credential=EmailAuthProvider.credential(email: user.email!,
                                                                password: _passwordcancelmembership.text);
                                                            await user.reauthenticateWithCredential(credential);
                                                            await FirebaseFirestore.instance
                                                                .collection('users')
                                                                .doc(user?.uid)
                                                                .update({
                                                              'isSubscribed': false,
                                                              'subscription status': 'User Cancelled Membership',
                                                              'time of cancellation': FieldValue.serverTimestamp(),
                                                              'T&C Status Cancellation':isChecked,
                                                            });
                                                            _clearMessages();
                                                            triggernotifications();
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Subscription Ended For ${user_name}'),
                                                                backgroundColor: Colors.red,
                                                              ),
                                                            );
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(builder: (context) => HomeScreen()),
                                                            );
                                                            await sendEmail(
                                                              name: user_name, // Replace with the user's name
                                                              subject: 'Confirmation: Your Subscription Has Successfully Ended',
                                                              message: 'Dear ${user_name},\n'

                                                                  '\n We hope this message finds you well.'

                                                                  ' We would like to inform you that your subscription with '
                                                                  ' NetFly has been successfully canceled. We appreciate the time you '
                                                                  ' spent as a valued member of our community.'

                                                                  ' Here are some key details regarding the cancellation: \n'

                                                                  ' \n Subscription End Date:${DateTime.now().toString().split(' ')} \n'
                                                                  ' \n Membership Status: Cancelled \n'
                                                                  ' \n Subscription Plan: 1199 for 1 year \n'
                                                                  ' \n Final Charge:No amount to be refunded as per the T&C \n'
                                                                  ' Should you have any questions or concerns about the cancellation, billing, or any other matter, please do not hesitate to contact our customer support team at support@netfly.org. We are here to assist you.'

                                                                  ' We sincerely thank you for being a part of NetFly. If you ever decide to rejoin our community, we would be more than happy to welcome you back.'

                                                                  ' Wishing you all the best in your future endeavors.',
                                                            );
                                                          }catch(e){
                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                              SnackBar(
                                                                content: Text('Please enter correct password ${user_name}.'),
                                                                backgroundColor: Colors.red,
                                                              ),
                                                            );
                                                            _passwordcancelmembership.clear();
                                                            Navigator.pop(context);
                                                          }
                                                        }else{
                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                            SnackBar(
                                                              content: Text('Please enter password ${user_name}.'),
                                                              backgroundColor: Colors.red,
                                                            ),
                                                          );

                                                        }
                                                      }
                                                    } else {
                                                      // Show a message or alert indicating the checkbox must be checked
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Please check the box to confirm cancellation.'),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  child: Text('Cancel Membership'),
                                                  style: ButtonStyle(
                                                    backgroundColor: isChecked
                                                        ? MaterialStatePropertyAll(Colors.red)
                                                        : MaterialStatePropertyAll(Colors.grey),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  actions: [
                                    SizedBox(height: 20),

                                  ],
                                );
                              },
                            );
                          },
                          child: Text('Cancel My Membership',style: TextStyle(color: Colors.red),),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextButton(
                          onPressed: () async {
                            bool isChecked = false; // Initial checkbox state

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Column(
                                        children: [
                                          Text(
                                            'Once deleted, the account and subscription would never be recovered.',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: [
                                              Checkbox(
                                                value: isChecked,
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isChecked = value ?? false;
                                                  });
                                                },
                                              ),
                                              Text(
                                                'I understand the\nconsequences\nand am doing it',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          if(isChecked)
                                            TextField(
                                              controller: _password,
                                              decoration: InputDecoration(
                                                hintText: 'Please enter password to continue ${user_name}',
                                                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(2))),
                                              ),
                                              obscureText: true,
                                            ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: MaterialStatePropertyAll(Colors.green),
                                            ),
                                            child: Text('Go Back'),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (isChecked) {
                                                final user=_auth.currentUser;
                                                // Proceed with account deletion only if checkbox is checked
                                                if(user!=null){
                                                  if(_password.text.isNotEmpty){
                                                    try{
                                                      AuthCredential credential=EmailAuthProvider.credential(email: user.email!, password: _password.text);
                                                      await user.reauthenticateWithCredential(credential);
                                                      deleteUserAndFirestoreData();
                                                      debugPrint('Account Deleted');
                                                      await FirebaseFirestore.instance
                                                          .collection('users')
                                                          .doc(user?.uid)
                                                          .update({
                                                        'isSubscribed': false,
                                                        'subscription status': 'Account Deleted',
                                                        'time of cancellation': FieldValue.serverTimestamp(),
                                                        'T&C Status Deletion':isChecked
                                                      });
                                                      _clearMessages();
                                                      await sendEmail(
                                                        name: user_name, // Replace with the user's name
                                                        subject: 'Confirmation: Your Account Has Successfully deleted',
                                                        message: 'Dear ${user_name},\n'

                                                            '\nWe hope this message finds you well.'

                                                            ' We would like to inform you that your account with '
                                                            ' NetFly has been successfully been deleted. We appreciate the time you '
                                                            ' spent as a valued member of our community.'

                                                            'Here are some key details regarding the cancellation:\n'

                                                            '\n Account Deletion Date:${DateTime.now().toString().split(' ')}\n'
                                                            '\n Membership Status: Cancelled\n'
                                                            '\n Subscription Plan: 1199 for 1 year\n'
                                                            '\n Final Charge:No amount to be refunded as per the T&C\n'
                                                            ' Should you have any questions or concerns about the cancellation, billing, or any other matter, please do not hesitate to contact our customer support team at support@netfly.org. We are here to assist you.'

                                                            ' We sincerely thank you for being a part of NetFly. If you ever decide to rejoin our community, we would be more than happy to welcome you back.'

                                                            ' Wishing you all the best in your future endeavors.',
                                                      );
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Account Deleted'),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => HomeScreen()),
                                                      );
                                                    }catch(e){
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Please enter correct pasword'),
                                                          backgroundColor: Colors.red,
                                                        ),
                                                      );
                                                      _passwordcancelmembership.clear();
                                                      Navigator.pop(context);
                                                    }
                                                    _password.clear();
                                                  }else{
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(
                                                        content: Text('Please enter password.'),
                                                        backgroundColor: Colors.red,
                                                      ),
                                                    );
                                                    _password.clear();
                                                  }
                                                }
                                              } else {
                                                // Show a message or alert indicating the checkbox must be checked
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Please check the box to confirm account deletion.'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            },
                                            style: ButtonStyle(
                                              backgroundColor: isChecked
                                                  ? MaterialStatePropertyAll(Colors.red)
                                                  : MaterialStatePropertyAll(Colors.grey),
                                            ),
                                            child: Text('Delete My Account'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                );
                              },
                            );
                          },
                          child: Text('Delete Account', style: TextStyle(color: Colors.red)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Payment Details',style: GoogleFonts.aboreto(
                          color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                          letterSpacing: 2,
                          wordSpacing: 1),),
                      IconButton(onPressed: (){
                        setState(() {
                          ispaid=!ispaid;
                        });
                      },
                          icon:Icon(ispaid? Icons.arrow_drop_up_rounded:Icons.arrow_drop_down_rounded,color: isDarkMode ? Colors.white : Colors.black,))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(ispaid)
                    Column(
                      children: [
                        Text('Payment IDs of subscriptions so far',style: TextStyle( color: isDarkMode ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w500,fontSize: 15),),
                        SizedBox(
                          height: 20,
                        ),
                        FutureBuilder<List<String>>(
                          future: getPaymentIds(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.red)),
                              );
                            } else {
                              List<String> paymentIds = snapshot.data ?? [];

                              if (paymentIds.isEmpty) {
                                return Center(
                                  child: Text('No payment history available.', style: TextStyle(color: Colors.red)),
                                );
                              }

                              // Create a list of Text widgets with padding and numbering
                              List<Widget> paymentIdWidgets = paymentIds.asMap().entries.map((entry) {
                                int index = entry.key + 1;
                                String paymentId = entry.value;
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text('$index.$paymentId',style: TextStyle(color: Colors.green,fontWeight: FontWeight.w400,fontSize: 15),),
                                );
                              }).toList();

                              // Display numbered and padded payment IDs in a Column
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: paymentIdWidgets,
                                ),
                              );
                            }
                          },
                        )



                      ],
                    ),
                  SizedBox(
                    height: 80,
                  ),
                  
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _uploadImage() async {
    try {
      final user = _auth.currentUser;
      if (user != null && _image != null) {
        final ref = _storage.ref().child('profile_pictures/${user.uid}');
        await ref.putFile(_image!);
        final imageUrl = await ref.getDownloadURL();

        await user.updateProfile(photoURL: imageUrl);

        // Store the URL in Firestore
        await _firestore.collection('profile_pictures').doc(user.uid).set({'url_user1': imageUrl,
          'time stamp':FieldValue.serverTimestamp()
        });

        setState(() {
          _imageUrl = imageUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Profile picture uploaded successfully!'),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Uploading'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error uploading profile picture: $e'),
      ));
    }
  }
}
