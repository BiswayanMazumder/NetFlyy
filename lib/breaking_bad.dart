import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/breaking_bad_s02.dart';
import 'package:netflix/breaking_bad_s03.dart';
import 'package:netflix/breaking_bad_s4.dart';
import 'package:netflix/breaking_s05.dart';
import 'package:netflix/breakingbad_s01_links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Breaking_bad extends StatefulWidget {
  const Breaking_bad({Key? key}) : super(key: key);

  @override
  State<Breaking_bad> createState() => _Breaking_badState();
}

class _Breaking_badState extends State<Breaking_bad> {
  String selectedOption = 'Season 1';
  final List<String> options = ['Season 1', 'Season 2', 'Season 3','Season 4','Season 5'];
  bool _isLikedButton = false;
  bool _isRated = false;
  bool isStarred = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkIfStarred();
  }
  void _checkIfStarred() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Breaking_Bad');
      final docSnapshot = await movieRef.get();
      if (docSnapshot.exists) {
        setState(() {
          isStarred = true;
        });
      }
    }
  }
  Future<void> _toggleStar() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Breaking_Bad');

      setState(() {
        isStarred = !isStarred;
        if (isStarred) {
          // Add the movie to the user's starredMovies subcollection.
          starredMoviesRef.set({
            'timestamp': FieldValue.serverTimestamp(),
          }).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Added to Wishlist'),
              ),
            );
          });
        } else {
          // Remove the movie from the user's starredMovies subcollection.
          starredMoviesRef.delete().then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Removed from Wishlist'),
              ),
            );
          });
        }
      });
    }
  }

  // Function to save the rating in Firestore
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_breaking_bad').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Padding(padding: EdgeInsets.all(8)),
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 800.0,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6541d02826033922fdad/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
                      opacity: 60.000),

                ),
              ),
              Container(
                height: 800.0,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.black,
                      Colors.transparent
                    ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter
                    )
                ),
              ),
              Positioned(child: SizedBox(
                width: 250.0,
                height: 800.0,
                child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6541dcb8dbf1e51bc322/view?project=64e0600003aac5802fbc&mode=admin'),
              )),
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              //Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  Image(
                    image: AssetImage('assets/images/netflix1.png'),
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'MOVIE',
                    style: TextStyle(
                        fontSize: 20,
                        wordSpacing: 3,
                        letterSpacing: 3,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                width: 50,
                height: 30,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '2015',
                    style: TextStyle(
                        fontSize: 15,
                        wordSpacing: 2,
                        letterSpacing: 2,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade500,
                        //borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: Colors.grey.shade500,
                        )),
                    child: Text(
                      ' A ',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '5 Seasons',
                    style: TextStyle(
                        fontSize: 15,
                        wordSpacing: 2,
                        letterSpacing: 2,
                        color: Colors.grey,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        //borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(
                          color: Colors.white,
                        )),
                    child: Text(
                      ' HD ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            width: 50,
            height: 20,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.red, width: 5),
                    color: Colors.red,
                  ),
                  child: Icon(
                    Icons.thumb_up_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Most Liked',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 20),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.grey)
                ),
                child:
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  child: Center(
                    child: IconButton(
                      onPressed: _toggleStar,
                      icon: Icon(
                        isStarred ? Icons.check : Icons.add,
                        color: Colors.yellow,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height:0,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, border: Border.all(width: 30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    DropdownButton<String>(
                      value: selectedOption,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedOption = newValue?? 'Season 1';
                        });
                      },
                      items: options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,
                              fontSize: 20),),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(800)),

                      ),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size(40, 40)),
                            // maximumSize: MaterialStateProperty.all(Size(100, 100)),
                            enableFeedback: true,
                            splashFactory: InkRipple.splashFactory,
                            backgroundColor: MaterialStatePropertyAll(Colors.white)
                        ),
                        onPressed: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('selected_breaking', selectedOption);
                          // Use Navigator to navigate to a new page based on the selected option
                          if (selectedOption == 'Season 1') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Breaking_bad_s01()),
                            );
                          } else if (selectedOption == 'Season 2') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Breaking_bad_s02()),
                            );
                          } else if (selectedOption == 'Season 3') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Breaking_bad_s03()),
                            );
                          } else if (selectedOption == 'Season 4') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Breaking_bad_s04()),
                            );
                          }
                          else if (selectedOption == 'Season 5') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Breaking_bad_s05()),
                            );
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.play_arrow,color: Colors.black,),
                            Text('Watch Trailer of ${selectedOption}',style:GoogleFonts.arya(
                                fontWeight: FontWeight.bold,
                                fontSize:20,
                                color: Colors.black
                            ),)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(
                      width: 20,
                      color: Colors.grey.shade300,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    Text(
                      'ABOUT',
                      style: GoogleFonts.amaranth(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        decorationColor: Colors.green,
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text(
                      'Breaking Bad is a gripping television series that tells the story of Walter White, a high school chemistry '
    'teacher turned methamphetamine manufacturer. Driven by a terminal cancer diagnosis and financial troubles, Walter partners with a '
    'former student, Jesse Pinkman, to enter the drug trade. The show explores their descent into the criminal underworld.'
    'Walters character transformation is central to the series. He evolves from a mild-mannered teacher into a ruthless drug lord'
    ' known as Heisenberg. The show delves into the consequences of his actions on his family and the people around him, showcasing '
    'moral dilemmas and ethical decay.Set in Albuquerque, New Mexico, Breaking Bad presents a gritty, realistic portrayal of the drug '
    'trade, crime, and the consequences of ones choices. It garnered critical acclaim for its writing, character development, and '
    'Bryan Cranstons and Aaron Pauls performances as Walter White and Jesse Pinkman, respectively.'

    'The series explores themes of morality, power, and the human capacity for change. Breaking Bad is a remarkable example of '
                          'storytelling that captivated audiences and became a cultural phenomenon, leaving a lasting legacy in the world of television.',
                      style: GoogleFonts.arizonia(
                          fontWeight: FontWeight.w400, fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(5)),
              SizedBox(
                height: 50,
              ),
              Container(
                child: Align(
                  alignment: Alignment.center,

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                          color: Colors.grey
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      radius: 25,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_isRated) {
                                // Decrease rating
                                _isLikedButton = false;
                              } else {
                                // Increase rating
                                _isLikedButton = true;
                              }
                              _isRated = !_isRated; // Toggle rating status
                            });
                            saveRatingToFirestore(_isLikedButton);
                          },
                          icon: const Icon(Icons.thumb_up),
                          iconSize: 30,
                          color: _isLikedButton ? Colors.red : Colors.green),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: _firestore.collection('ratings_breaking_bad').snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData) return CircularProgressIndicator();
                        int totalRatings = 0;
                        snapshot.data!.docs.forEach((doc) {
                          final data = doc.data() as Map<String, dynamic>?; // Cast the data to a Map
                          if (data != null && data['isLiked'] != null) {
                            totalRatings += data['isLiked'] ? 1 : 0;
                          }
                        });

                        return Text('Total Ratings: ${totalRatings}',style: TextStyle(color: Colors.white),);
                      }
                  )
              ),
              Padding(padding: EdgeInsets.all(20)),
            ],
          ),
          SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

}
