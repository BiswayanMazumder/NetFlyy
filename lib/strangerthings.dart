import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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

class Stranger extends StatefulWidget {
  const Stranger({Key? key}) : super(key: key);

  @override
  State<Stranger> createState() => _StrangerState();
}

class _StrangerState extends State<Stranger> {
  String selectedOption = 'Season 1';
  final List<String> options = ['Season 1', 'Season 2', 'Season 3','Season 4'];
  bool _isLikedButton=false;
  bool _isRated = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final List<String> starredMovies = [];
  bool isStarred = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  void saveRatingToFirestore(bool isLiked) {
    _firestore.collection('ratings_stranger').add({
      'isLiked': isLiked,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
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
      final movieRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Stranger Things');
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
      final starredMoviesRef = _firestore.collection('starred').doc(userId).collection('starredMovies').doc('Stranger Things');

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

                  image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a859c171eff1406cb/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
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
                child: Image.asset('assets/images/strangerlogo.jpg'),
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
                  Text('2016',style: TextStyle(fontSize:15,
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
                  Text('5 Sessions',style: TextStyle(fontSize:15,
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
                                MaterialPageRoute(builder: (context) => Stranger01()),
                              );
                            } else if (selectedOption == 'Season 2') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Stranger02()),
                              );
                            } else if (selectedOption == 'Season 3') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Stranger03()),
                              );
                            } else if (selectedOption == 'Season 4') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Stranger04()),
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
                    Text('When a young boy vanishes, a small town uncovers a mystery involving '
                        'secret experiments, terrifying supernatural forces and one strange little girl.',
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
                      stream: _firestore.collection('ratings_stranger').snapshots(),
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
