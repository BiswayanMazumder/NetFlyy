import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String? userEmail;
  User? user = FirebaseAuth.instance.currentUser;
  String user_name='';
  @override
  void initState() {
    super.initState();
    getUserEmail();
    fetchusername();
  }

  TextEditingController _moviename = TextEditingController();
  TextEditingController _problemdescription = TextEditingController();
  TextEditingController _soundproblem = TextEditingController();
  TextEditingController _details = TextEditingController();
  TextEditingController _bugs = TextEditingController();
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

  bool misspelled = false;
  bool problem_with_video = false;
  bool bugs = false;
  bool sound = false;
  Color field = Colors.green;
  void refreshAllTextFields(String newText) {
    setState(() {
      _bugs.text=newText;
      // _soundproblem.text='';
      // _problemdescription.text='';
      // _moviename.text='';
      // _details.text='';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'NetFly',
          style: GoogleFonts.amaranth(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          // Image(
          //   image: NetworkImage(
          //       'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'),
          // ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Image(
                image: NetworkImage(
                    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin'),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Problem In Watching Video',
                style: GoogleFonts.amaranth(
                  color: Colors.red,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: 1.9,
                    child: Checkbox(
                      checkColor: Colors.green,
                      fillColor: MaterialStatePropertyAll(Colors.green),
                      value: misspelled,
                      onChanged: (value) {
                        setState(() {
                          misspelled = !misspelled;
                          _moviename.clear();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Misspelled Film Or TV Episode',
                    style: GoogleFonts.amaranth(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  )
                ],
              ),
              if (misspelled)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: field)),
                      child: Column(
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.ltr,
                            controller: _moviename,
                            // onChanged: (value){
                            //   setState(() {
                            //     _moviename.text=value;
                            //   });
                            // },
                            decoration: InputDecoration(
                              hintText:
                              '  Please type the movie name $userEmail',
                              // errorMaxLines: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: 1.9,
                    child: Checkbox(
                      checkColor: Colors.green,
                      fillColor: MaterialStatePropertyAll(Colors.green),
                      value: problem_with_video,
                      onChanged: (value) {
                        setState(() {
                          problem_with_video = !problem_with_video;
                          _problemdescription.clear();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Problem With Video',
                    style: GoogleFonts.amaranth(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  )
                ],
              ),
              if (problem_with_video)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: field)),
                      child: Column(
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            controller: _problemdescription,
                            decoration: InputDecoration(
                              hintText:
                              '    Describe Your Problem in video $userEmail',
                              errorMaxLines: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: 1.9,
                    child: Checkbox(
                      checkColor: Colors.green,
                      fillColor: MaterialStatePropertyAll(Colors.green),
                      value: sound,
                      onChanged: (value) {
                        setState(() {
                          sound = !sound;
                          _soundproblem.clear();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Problem With Sound',
                    style: GoogleFonts.amaranth(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  )
                ],
              ),
              if (sound)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: field)),
                      child: Column(
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            controller: _soundproblem,
                            decoration: InputDecoration(
                              hintText:
                              '    Please Type The Movie Name $userEmail',
                              errorMaxLines: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Transform.scale(
                    scale: 1.9,
                    child: Checkbox(
                      checkColor: Colors.green,
                      fillColor: MaterialStatePropertyAll(Colors.green),
                      value: bugs,
                      onChanged: (value) {
                        setState(() {
                          bugs = !bugs;
                          _bugs.clear();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Faced Any Bugs',
                    style: GoogleFonts.amaranth(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 20),
                  )
                ],
              ),
              if (bugs)
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: field)),
                      child: Column(
                        children: [
                          TextField(
                            textAlign: TextAlign.center,
                            controller: _bugs,
                            decoration: InputDecoration(
                              hintText: '    More Details $userEmail',
                              errorMaxLines: 100,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Any more details? (Optional)\n',
                style: GoogleFonts.amaranth(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    border: Border.all(color: Colors.black)),
                child: TextField(
                  controller: _details,
                  scrollPhysics: AlwaysScrollableScrollPhysics(),
                  autocorrect: true,
                  enableSuggestions: true,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if (user != null) {
                        if (_moviename.text.isNotEmpty || _bugs.text.isNotEmpty || _soundproblem.text.isNotEmpty || _problemdescription.text.isNotEmpty) {
                          // At least one field is not empty, proceed to submit the report.
                          await FirebaseFirestore.instance.collection('Reports').add(
                            {
                              'e)User Email': userEmail.toString(),
                              'a)Misspelled Check Box':misspelled,
                              'f)Misspelled Film Name': _moviename.text,
                              'b)Video  Check Box':problem_with_video,
                              'g)Problem With Video': _problemdescription.text,
                              'c)Sound Check Box': sound,
                              'h)Problem With Sound': _soundproblem.text,
                              'd)Bugs Check Box':bugs,
                              'i)Bugs Faced': _bugs.text,
                              "j)Additional Details": _details.text,
                              'k)Time Of Report': FieldValue.serverTimestamp(),
                              'l)User Name': user_name.toString()
                            },
                          );

                          // Clear text controllers after submitting the report
                          _moviename.clear();
                          _problemdescription.clear();
                          _soundproblem.clear();
                          _details.clear();
                          _bugs.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Report Submitted Successfully $user_name'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          // All fields are empty, show an error message.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('All Fields Are Empty $user_name'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else {
                        // User is null, show an error message.
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Please Try Again Later $user_name'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        print('User is null or some conditions are not met');
                      }

                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                    ),
                    child: Text('Report Problem'),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                      MaterialStatePropertyAll(Colors.red),
                    ),
                    child: Text('Cancel'),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
      ),
    );
  }
}
