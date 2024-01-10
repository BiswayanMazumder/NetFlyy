import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:netflix/cherrylinks.dart';
import 'package:netflix/otto_links.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
class otto extends StatefulWidget {
  const otto({Key? key}) : super(key: key);

  @override
  State<otto> createState() => _ottoState();
}

class _ottoState extends State<otto> {
  bool _isLikedButton = false;
  bool _isRated = false;
  bool isStarred = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_otto').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
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
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('A Man Named OTTO');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('A Man Named OTTO');

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

                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/654fb0603142d3748145/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
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
                child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/654fb1df3e5c7b5d8d06/view?project=64e0600003aac5802fbc&mode=admin'),
              )),
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(20)),
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
                    '2:30 Minutes',
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
            height: 12,
          ),
          Column(
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(width: 30),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const otto_links()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.white
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                    children: [

                      Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 30,
                      ),
                      SizedBox(width: 2),
                      Text(

                        'Watch Trailer',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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
                      'A man, lets call him Alex, traversed through the bustling city streets, each step a testament to his journey. In'
    ' the symphony of urban life, his existence was a subtle melody, resonating with the pulse of the metropolis. With a silhouette that'
    'echoed tales of resilience, Alex bore the weight of his experiences in the lines etched on his face.His eyes, deep pools of wisdom,'
    ' reflected the myriad stories hidden within the folds of time. Alex was a navigator of both concrete jungles and the nuanced '
    'landscapes of human emotion. His footsteps, neither hurried nor lethargic, painted a narrative of measured determination.'

    'In the mosaic of daily encounters, Alex was a mosaic himself—a patchwork of triumphs and tribulations. The city was his canvas, '
    'and he, an artist, left an indelible mark with every interaction. Conversations with strangers became vignettes of shared humanity,'
    ' brief yet profound.In the kaleidoscope of his existence, relationships formed constellations that adorned the tapestry of his '
    'life. Each interaction, a celestial event, held the promise of connection and understanding. Alex, a wanderer of the human soul, '
    'embraced the ephemerality of moments, cherishing the beauty found in transience.As the sun dipped below the skyline, Alex continued'
                          ' his odyssey through the city. His silhouette, a testament to the richness of a life lived authentically, blended seamlessly into the urban panorama. A man, nameless in the crowd, but a protagonist in the vibrant narrative of existence.',
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
                      stream: _firestore.collection('ratings_otto').snapshots(),
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
