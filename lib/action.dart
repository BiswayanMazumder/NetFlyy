import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/mission_majnu.dart';
import 'package:netflix/peakyblinders.dart';
import 'package:netflix/raees.dart';
import 'package:netflix/raw_beast.dart';
import 'package:netflix/twoandahalf.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix/uncharted.dart';
import 'package:netflix/uri.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Actionpage extends StatefulWidget {
  const Actionpage({Key? key}) : super(key: key);

  @override
  State<Actionpage> createState() => _ActionpageState();
}

class _ActionpageState extends State<Actionpage> {
  @override
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String url1='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbannerlink();
  }
  Future<void> fetchbannerlink() async{
    final docsnap=await _firestore.collection('Action Page').doc('Action Page Big Picture').get();
    if(docsnap.exists){
      setState(() {
        url1=docsnap.data()?['link'];
      });
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(
            children: [
              Padding(padding: EdgeInsets.all(8)),
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 800.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6566dac7d54993a27c43/view?project=64e0600003aac5802fbc&mode=admin'),fit: BoxFit.fitHeight,
                          opacity: 60.000),

                    ),
                  ),
                  Container(
                    height: 800.0,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.black,
                          Colors.transparent,
                          Colors.black
                        ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter
                        )
                    ),
                  ),
                  Positioned(child: SizedBox(
                    width: 250.0,
                    height: 800.0,
                    child: Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6566de032a68b60f37c6/view?project=64e0600003aac5802fbc&mode=admin'),
                  )),
                ],
              ),
              Padding(padding: EdgeInsets.all(20)),
              Text(
                'Action And Adventure',
                style: GoogleFonts.amaranth(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Indian Action Movies',
                    style: GoogleFonts.aboreto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                // physics: ScrollPhysics(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          height: 250,
                          width: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Mission_majnu()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6566dac7d54993a27c43/view?project=64e0600003aac5802fbc&mode=admin',
                                height: 300,
                                width: 300,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Text('Mission Majnu',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),

                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          height: 250,
                          width: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Raees()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/65675c1fa79c8f5e59c7/view?project=64e0600003aac5802fbc&mode=admin',
                                height: 300,
                                width: 300,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Text('Raees',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          height: 250,
                          width: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Raw_Beast()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/raw%20beast%20-%20Made%20with%20Clipchamp.gif?t=2023-11-30T13%3A36%3A49.684Z',
                                height: 300,
                                width: 300,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Text('Raw:Beast',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'WorldWide Action Movies',
                    style: GoogleFonts.aboreto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                // physics: ScrollPhysics(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          height: 250,
                          width: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Raees()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/65675c1fa79c8f5e59c7/view?project=64e0600003aac5802fbc&mode=admin',
                                height: 300,
                                width: 300,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Text('Raees',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          height: 250,
                          width: 400,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Raw_Beast()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/raw%20beast%20-%20Made%20with%20Clipchamp.gif?t=2023-11-30T13%3A36%3A49.684Z',
                                height: 300,
                                width: 300,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        Text('Raw:Beast',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const uncharted()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653a93821d4ff90a1b13/view?project=64e0600003aac5802fbc&mode=admin',
                                height: 250,
                                width: 350,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,

                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        SizedBox(
                          height:5,
                        ),
                        Text('Uncharted',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Peaky()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Peaky%20Blinders.gif?alt=media&token=76491ebc-f90e-4c0f-9482-d5911fdc55cf&_gl=1*99voax*_ga*MTY4NDM2OTcxLjE2ODI3NjAxMTQ.*_ga_CW55HF8NVT*MTY5ODMyNjU4NC4xNzQuMS4xNjk4MzMwMTA2LjEwLjAuMA..',
                                height: 220,
                                width: 250,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        SizedBox(
                          height:5,
                        ),
                        Text('Peaky Blinders',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent]),
                              borderRadius: BorderRadius.all(Radius.circular(80))),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Peaky()),
                                );
                              },
                              style: ButtonStyle(
                                // elevation:MaterialStatePropertyAll(50),
                                // shadowColor: MaterialStatePropertyAll(Colors.white),

                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                'https://emkldzxxityxmjkxiggw.supabase.co/storage/v1/object/public/Netfly%20Storage/aka%20-%20Made%20with%20Clipchamp.gif?t=2023-11-30T14%3A17%3A19.006Z',
                                height: 220,
                                width: 250,
                                filterQuality: FilterQuality.high,
                                fadeInDuration: Duration(seconds: 2),
                                fadeOutDuration: Duration(seconds: 2),
                                fadeInCurve: Curves.decelerate,
                                placeholder: (context, url) =>
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                errorWidget: (context, url, error) => Text(
                                  'Image Not Found',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        SizedBox(
                          height:5,
                        ),
                        Text('AKA',style: GoogleFonts.aBeeZee(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Award Winning Movies',
                    style: GoogleFonts.aboreto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              SingleChildScrollView(
                // physics: ScrollPhysics(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor:
                                MaterialStatePropertyAll(Colors.black),
                          ),
                          child: Image(
                              image:
                                  AssetImage('assets/images/possessed.webp'))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/Queens.jpg'),
                          fit: BoxFit.fitHeight,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/timetrap.webp'),
                          fit: BoxFit.fitHeight,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/murder.jpg'),
                          fit: BoxFit.fitHeight,
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                        ),
                        child: Image(
                          image: AssetImage('assets/images/aka.jpg'),
                          fit: BoxFit.fitHeight,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 80,
              )
            ],
          )
        ],
      ),
    );
  }
}
