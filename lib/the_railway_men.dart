import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/firstpage.dart';
import 'package:netflix/navbar.dart';
import 'package:netflix/railway_men_ep1.dart';
import 'package:netflix/railway_men_ep2.dart';
import 'package:netflix/railway_men_ep_03.dart';
import 'package:netflix/stranger%20things%20link.dart';
import 'package:netflix/stranger-03.dart';
import 'package:netflix/stranger-s02.dart';
import 'package:netflix/stranger04.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:appsize/appsize.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main(){
  runApp(MyApps());
}
class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => AppSize(
        builder: (context, orientation, deviceType) {
          return AppSizeUtil.deviceType == DeviceType.mobile
              ? Container(   // Widget for Mobile
            width: 100.w,
            height: 20.5.h,
          )
              : Container(   // Widget for Tablet
            width: 100.w,
            height: 12.5.h,
          );
        },
      ),
    );
  }
}

class The_railway_men extends StatefulWidget {
  const The_railway_men({Key? key}) : super(key: key);

  @override
  State<The_railway_men> createState() => _The_railway_menState();
}

class _The_railway_menState extends State<The_railway_men> {
  String selectedOption = 'Season 1';
  final List<String> optionss = ['Season 1', 'Episode 2', 'Episode 3','Episode 4',
    //'Season 4',
  ];
  bool _isLikedButton=false;
  bool _isRated = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  bool isStarred = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_the_railway_men').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
  String lastseen='Welcome To The Railway Men';
  @override
  void initState() {
    super.initState();
    getSelectedSeason();
    _checkIfStarred();
    fetchlastseen();
  }
  Future<void> fetchlastseen() async{
    final user=_auth.currentUser;
    if(user!=null){
      final docsnap=await _firestore.collection('The Railway Men').doc(user.uid).get();
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
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('The Railway Men');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('The Railway Men');

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
    String? savedSeason = prefs.getString('selected_stranger');
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

                  image: DecorationImage(image: NetworkImage('https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/the%20railway%20men%20%20trailer.gif?t=2023-12-01T15%3A30%3A35.293Z'),fit: BoxFit.fitHeight,
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
                child: Image.network('https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/images.png?t=2023-12-01T15%3A37%3A49.996Z'),
              )),
            ],
          ),

          Column(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              //Padding(padding: EdgeInsets.all(10)),
              Row(
                children: [
                  Image(image: AssetImage('assets/images/netflix1.png'),width: 30,),
                  SizedBox(
                    width: 10,
                  ),
                  Text('SERIES',style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 3,
                      letterSpacing: 3,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
              Padding(padding: EdgeInsets.all(10)),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('2023',style: TextStyle(fontSize:15,
                      wordSpacing: 2,
                      letterSpacing: 2,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700
                  ),),
                  SizedBox(
                    width:10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.grey.shade500,
                        //borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Colors.grey.shade500,)
                    ),
                    child: Text(' A ',style:TextStyle(color: Colors.black),),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text('4 Seasons',style: TextStyle(fontSize:15,
                      wordSpacing: 2,
                      letterSpacing: 2,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.transparent,
                        //borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Colors.white,)
                    ),
                    child: Text(' HD ',style:TextStyle(color: Colors.white),),
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
                    border:Border.all(color: Colors.red,width:5),
                    color: Colors.red,
                  ),
                  child: Icon(Icons.thumb_up_rounded,color: Colors.white,size: 20,),
                ),
                SizedBox(
                  width: 10,
                ),
                Text('Most Liked',style:TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20),)
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 10,
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
                    items: optionss.map<DropdownMenuItem<String>>((String value) {
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
                              minimumSize: MaterialStateProperty.all(Size(40, 40)),
                              // maximumSize: MaterialStateProperty.all(Size(100, 100)),
                              enableFeedback: true,
                              splashFactory: InkRipple.splashFactory,
                              backgroundColor: MaterialStatePropertyAll(Colors.white)
                          ),
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('selected_stranger', selectedOption);
                            // Use Navigator to navigate to a new page based on the selected option
                            if (selectedOption == 'Season 1') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => railwaymens01ep01()),
                              );
                              final user=_auth.currentUser;
                              await _firestore.collection('The Railway Men').doc(user!.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 1'
                                  });
                            } else if (selectedOption == 'Episode 2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => railwaymens01ep02()),
                              );
                              final user=_auth.currentUser;
                              await _firestore.collection('The Railway Men').doc(user!.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 2'
                                  });
                            } else if (selectedOption == 'Episode 3') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => railwaymens01ep03()),
                              );
                              final user=_auth.currentUser;
                              await _firestore.collection('The Railway Men').doc(user!.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 3'
                                  });
                            } else if (selectedOption == 'Episode 4') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => railwaymens01ep03()),
                              );
                              final user=_auth.currentUser;
                              await _firestore.collection('The Railway Men').doc(user!.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 4'
                                  });
                            }else if (selectedOption == 'Season 4') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => NavBar()),
                              );
                              final user=_auth.currentUser;
                              await _firestore.collection('The Railway Men').doc(user!.uid).set(
                                  {
                                    'Last Seen':'Season 1 Episode 4'
                                  });
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
                        Text('Continue Watching ${lastseen}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(width:20,color: Colors.grey.shade300,style: BorderStyle.solid),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Column(
                  children: [
                    Text('ABOUT',style:GoogleFonts.amaranth(
                      color: Colors.black,
                      fontSize:40,
                      fontWeight: FontWeight.bold,
                      decorationColor: Colors.green,
                    ),),
                    Padding(padding: EdgeInsets.all(10)),
                    Text('A real life story based on most dangerous gas tragedy that is Bhopal gas Tragedy. It happened due to UCL fertilizer company.'
                        'This series depicts how the railway workers bravery saved millions of people lives.',
                      style:GoogleFonts.arizonia(
                          fontWeight: FontWeight.w400,
                          fontSize:30
                      ),),
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
                      stream: _firestore.collection('ratings_the_railway_men').snapshots(),
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
