import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/sex_ed_01.dart';
import 'package:netflix/sex_ed_02.dart';
import 'package:netflix/sex_ed_03.dart';
import 'package:netflix/sex_ed_04.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class SexEducation extends StatefulWidget {

  const SexEducation({Key? key}) : super(key: key);

  @override
  State<SexEducation> createState() => _SexEducationState();
}

class _SexEducationState extends State<SexEducation> {
  bool _isRated = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  bool isStarred = false;
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_Sex_Education').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  final List<String> options = ['Season 1', 'Episode 2', 'Episode 3','Episode 4',
    //'Episode 5'
  ];
  bool _isLikedButton = false;
  @override
  void initState() {
    super.initState();
    getSelectedSeason();
    _checkIfStarred();
    _fetchlastseen();
  }
  String? lastseen='Welcome To Sex Education!';
  Future<void> _fetchlastseen()async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap= await _firestore.collection('Sex Education Lst Seen').doc(user.uid).get();
      if(docsnap.exists){
        setState(() {
          lastseen=docsnap.data()?['Last Seen'];
        });
      }
    }
  }
  void _checkIfStarred() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Sex Education');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Sex Education');

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

                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/655233a3ba65360b162a/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
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
                child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/655241e946864ac6cb6b/view?project=64e0600003aac5802fbc&mode=admin'),
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
                width: 30,
                height: 50,
              ),
              Row(
                children: [
                  Text(
                    '2012',
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
                    '4 Sessions',
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
          SizedBox(height: 10,),
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
                            padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 4, horizontal: 8)),
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
                            final user=_auth.currentUser;
                            if(user!=null){
                              await _firestore.collection('Sex Education Lst Seen').doc(user.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 1',
                                    'Time Seen':FieldValue.serverTimestamp()
                                  });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sex_ed_01()),
                            );
                          } else if (selectedOption == 'Episode 2') {
                            final user=_auth.currentUser;
                            if(user!=null){
                              await _firestore.collection('Sex Education Lst Seen').doc(user.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 2',
                                    'Time Seen':FieldValue.serverTimestamp()
                                  });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sex_ed_02()),
                            );
                          } else if (selectedOption == 'Episode 3') {
                            final user=_auth.currentUser;
                            if(user!=null){
                              await _firestore.collection('Sex Education Lst Seen').doc(user.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 3',
                                    'Time Seen':FieldValue.serverTimestamp()
                                  });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sex_ed_03()),
                            );
                          } else if (selectedOption == 'Episode 4') {
                            final user=_auth.currentUser;
                            if(user!=null){
                              await _firestore.collection('Sex Education Lst Seen').doc(user.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 4',
                                    'Time Seen':FieldValue.serverTimestamp()
                                  });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => sex_ed_04()),
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
                      SizedBox(
                        height: 20,
                      ),
                      Text('Continue Watching: ${lastseen}',style: GoogleFonts.amaranth(color: Colors.white,fontWeight: FontWeight.w100),),
                    ],
                  )
              )
            ],
          ),

          Column(
            children: [
              SizedBox(
                height: 20,
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
                      '"Sex Education" is a popular Netflix series that skillfully blends humor, drama, and important conversations '
                          'about relationships and sexuality. The show revolves around Otis Milburn, a socially awkward high school '
                          'student whose mother is a sex therapist. Drawing from his unconventional upbringing, Otis teams up with Maeve'
                          ' Wiley, a rebellious classmate, to set up an underground sex therapy clinic at their school.The series delves'
                          ' into the complexities of adolescence, addressing topics such as consent, identity, and the challenges of '
                          'navigating relationships. The characters grapple with a myriad of issues, from self-discovery to the highs'
                          ' and lows of teenage romance. The shows unique mix of wit and sincerity allows it to explore sensitive'
                          ' subjects with a refreshing and non-judgmental perspective."Sex Education" stands out not only for its '
                          'humor and engaging plotlines but also for its diverse and well-developed characters. It portrays a spectrum'
                          ' of sexual orientations, gender identities, and backgrounds, promoting inclusivity and representation.Beyond '
                          'its entertainment value, the series encourages open conversations about sex and relationships, breaking down'
                          ' societal taboos. It subtly educates viewers on important aspects of sexual health while highlighting the '
                          'importance of communication and empathy.In essence, "Sex Education" is more than just a coming-of-age '
    'series; its a thoughtful exploration of the challenges young people face in understanding themselves and their relationships, '
                          'all while managing the complexities of high school life.',
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
                      stream: _firestore.collection('ratings_Sex_Education').snapshots(),
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
