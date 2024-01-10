import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/extraction_2_links.dart';
import 'package:netflix/extractionlinks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Extraction extends StatefulWidget {
  const Extraction({Key? key}) : super(key: key);

  @override
  State<Extraction> createState() => _ExtractionState();
}

class _ExtractionState extends State<Extraction> {
  bool _isLikedButton = false;
  bool _isRated = false;
  bool isStarred = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  void _checkIfStarred() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Extraction');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Extraction');

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
    _firestore.collection('ratings_extraction').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  String selectedOption = 'Season 1';
  final List<String> options = ['Season 1', 'Season 2'];
  @override
  void initState() {
    super.initState();
    getSelectedSeason();
    _checkIfStarred();
  }

  Future<void> getSelectedSeason() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSeason = prefs.getString('selected_extraction');
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
                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/651d97dfcf2c40f663f1/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
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
                child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653def90e8989985befb/view?project=64e0600003aac5802fbc&mode=admin',
                width: 120,
                  height: 500,
                ),
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
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  ' Season-1',
                  style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 3,
                      letterSpacing: 3,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '2019',
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
                    '2 Seasons',
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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
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
                    prefs.setString('selected_extraction', selectedOption);
                    // Use Navigator to navigate to a new page based on the selected option
                    if (selectedOption == 'Season 1') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Extraction_links()),
                      );
                    } else if (selectedOption == 'Season 2') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Extraction2_links()),
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
          Column(
            children: [
              SizedBox(
                height: 10,
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
                      '"Extraction" is a gripping action thriller film released in 2020, directed by Sam Hargrave and starring Chris '
    'Hemsworth as Tyler Rake. The story unfolds in the chaotic underbelly of Dhaka, Bangladesh, and revolves around the character of '
    'Tyler Rake, a fearless and battle-hardened black market mercenary.'

    'Tyler Rake is approached with a high-stakes mission: to rescue Ovi Mahajan, the kidnapped son of an imprisoned international crime '
    'lord. This mission quickly becomes the most dangerous extraction operation of his career. As Tyler delves into this perilous task, '
    'the film takes viewers on an adrenaline-pumping journey through a world of corruption, violence, and moral ambiguity.'

    'The film''s relentless action sequences, breathtaking stunts, and visceral combat scenes keep audiences on the edge of their seats'
    ' throughout its runtime. As Tyler Rake navigates the treacherous terrain of Dhaka, he forms an unlikely bond with Ovi, adding '
    'emotional depth to the storyline.'

    "Extraction not only excels in its action-packed moments but also explores the complexities of its characters. Tyler Rake's "
    "character is portrayed as a man haunted by his past, seeking redemption through this dangerous mission. Ovi, on the other hand, "
    "is a young boy trapped in a world of privilege and danger, seeking escape and protection."

    "The film's time complexity lies in its intricate choreography of action sequences and the deepening of character"
    "relationships against the backdrop of a chaotic and unforgiving city. It explores themes of sacrifice, redemption, and the "
    "blurred lines between heroism and villainy."

    'In conclusion, "Extraction" is a high-octane action thriller that combines heart-pounding excitement with compelling '
                          "character development. Chris Hemsworth's portrayal of Tyler Rake and the film's stunning visuals make it a "
                          "must-watch for fans of intense action cinema. With its gripping storyline and thrilling action sequences,Extraction"
                          'is a standout addition to the genre, leaving a lasting impact on viewers.',
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
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                  ],
                ),
              ),
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
                      stream: _firestore.collection('ratings_extraction').snapshots(),
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
