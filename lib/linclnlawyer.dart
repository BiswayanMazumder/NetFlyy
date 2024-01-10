import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/lincoln_lawyer_s1_links.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Lincoln extends StatefulWidget {
  const Lincoln({Key? key}) : super(key: key);

  @override
  State<Lincoln> createState() => _LincolnState();
}

class _LincolnState extends State<Lincoln> {

  bool _isLikedButton = false;
  bool _isRated = false;
  bool isStarred = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  @override
  void initState() {
    super.initState();
    getSelectedSeason();
    _checkIfStarred();
  }
  void _checkIfStarred() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Lincoln Lawyer');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Lincoln Lawyer');

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
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_lincoln').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  String selectedOption = 'Season 1';
  final List<String> options = ['Season 1', 'Season 2'];
  Future<void> getSelectedSeason() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSeason = prefs.getString('selected_lincoln');
    if (savedSeason != null) {
      setState(() {
        selectedOption = savedSeason;
      });
    }
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

                  image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/netflix-5002f.'
                      'appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer.gif?alt=media&token=e82'
                      '5d7f9-9b6d-4ab6-b413-fb3ddb5df913'),fit: BoxFit.fitHeight,
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
                width: 180.0,
                height: 800.0,
                child: Image.asset('assets/images/download.png'),
              )),
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
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
                    'SERIES',
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
                    '2022',
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
                    '2 Sessions',
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
            height: 5,
          ),
          Column(
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
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.grey)
                      ),
                      child: CircleAvatar(
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
                      height: 20,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          enableFeedback: true,
                          splashFactory: InkRipple.splashFactory,
                          backgroundColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      onPressed: ()async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('selected_lincoln', selectedOption);
                        // Use Navigator to navigate to a new page based on the selected option
                        if (selectedOption == 'Season 1') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Lincoln1()),
                          );
                        } else if (selectedOption == 'Season 2') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Lincoln1()),
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
                  ],
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height:2,
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
                      'The Lincoln Lawyer is an American legal drama streaming television series created for '
                      'television by David E. Kelley and developed by Ted Humphrey, based on the 2008 novel '
                      'The Brass Verdict by Michael Connelly, a sequel to his novel The Lincoln Lawyer. '
                      'It stars Manuel Garcia-Rulfo as Mickey Haller, a defense attorney in Los Angeles who '
                      'works out of a chauffeur-driven Lincoln Navigator rather than an office.',
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
                      stream: _firestore.collection('ratings_lincoln').snapshots(),
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
