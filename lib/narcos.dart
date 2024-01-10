import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/johny_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/narcos_s1.dart';
import 'package:netflix/naruto_links.dart';
import 'package:netflix/peaky02.dart';
import 'package:netflix/peaky3.dart';
import 'package:netflix/peakys1links.dart';
import 'package:netflix/peakys5links.dart';
import 'package:netflix/peakyseason04%20links.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Narcos extends StatefulWidget {
  const Narcos({Key? key}) : super(key: key);

  @override
  State<Narcos> createState() => _NarcosState();
}

class _NarcosState extends State<Narcos> {
  bool _isLikedButton = false;
  final List<String> options = ['Season 1', 'Season 2', 'Season 3','Season 4','Season 5'];
  Future<void> getSelectedSeason() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedSeason = prefs.getString('selectedSeason');
    if (savedSeason != null) {
      setState(() {
        selectedOption = savedSeason;
      });
    }
  }
  String selectedOption = 'Season 1';
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
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Narcos');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Narcos');

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
    _firestore.collection('ratings_narcos').add({
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
                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6543b06c19819c36ab24/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
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
                child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6543b1d1818a48fd3884/view?project=64e0600003aac5802fbc&mode=admin'),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    '2013',
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
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, border: Border.all(width: 30)),
                child:  Column(
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
                        onPressed: ()async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          prefs.setString('selectedSeason', selectedOption);
                          // Use Navigator to navigate to a new page based on the selected option
                          if (selectedOption == 'Season 1') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Narcos_s1()),
                            );
                          } else if (selectedOption == 'Season 2') {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Peaky02()),
                            );
                          } else if (selectedOption == 'Season 3') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Peakys1ep3()),
                            );
                          } else if (selectedOption == 'Season 4') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Peakys01ep04()),
                            );
                          } else if (selectedOption == 'Season 5') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Peakys01ep05()),
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
                      'Narcos is a gripping crime drama series that originally aired from 2015 to 2017. Set in both Colombia and'
                          ' the United States, the show revolves around the rise and fall of drug kingpin Pablo Escobar and the '
                          'Medellín Cartel. The series masterfully depicts the drug trades impact on society, law enforcement, and'
                          ' politics during the late 20th century.Wagner Moura delivers an outstanding performance as Pablo Escobar,'
                          ' capturing the drug lords charisma and ruthlessness. The series also highlights the efforts of law '
                          'enforcement, including DEA agents Steve Murphy (Boyd Holbrook) and Javier Peña (Pedro Pascal), as '
                          'they attempt to bring down the cartels. The show combines historical events with fictional elements, '
                          'creating a suspenseful narrative that keeps viewers on the edge of their seats.Narcos is renowned '
    'for its gritty storytelling, intense action, and its portrayal of the real-life complexities of the drug trade. It explores '
    'themes of power, corruption, and the moral dilemmas faced by those involved. If youre a fan of crime dramas with high stakes '
                          'and complex characters, "Narcos" is a must-watch series that offers a compelling look into the world of '
                          'drug trafficking and the time complexity of the war against it.',
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
                      stream: _firestore.collection('ratings_narcos').snapshots(),
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
