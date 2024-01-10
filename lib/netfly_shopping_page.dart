import 'package:flutter/material.dart';
import 'package:carousel_images/carousel_images.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/edge_30_pro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/login.dart';

class Shopping extends StatelessWidget {
  final String email;

  Shopping({required this.email});
  final auth=FirebaseAuth.instance;
  final List<String> listImages = [
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652ba330af8cadcf3b34/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652ba328690454a11ea2/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652ba5f293ae6fa32126/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652ba725a9c0616a36b1/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652ba7e57b0379c1f4fb/view?project=64e0600003aac5802fbc&mode=admin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 50,
        shadowColor: Colors.black,
        automaticallyImplyLeading: true,
        title: Text('NetKart'),
        actions: [

          SizedBox(width: 10),
          Icon(Icons.shopping_cart),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Welcome To\nNetFly Mobile\nStore...',
                    textStyle: GoogleFonts.abel(
                      color: Colors.black,
                      fontSize: 70,
                      letterSpacing: 2,
                      wordSpacing: 2,
                      fontWeight: FontWeight.w300,
                    ),
                    speed: Duration(milliseconds: 500),
                    textAlign: TextAlign.justify,
                  ),
                ],
                totalRepeatCount: 2,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                isRepeatingAnimation: true,
                stopPauseOnTap: true,
              ),

              SizedBox(
                height: 50,
              ),
              CarouselImages(
                scaleFactor: 0.6,
                listImages: listImages,
                height: 300.0,
                borderRadius: 30.0,
                cachedNetworkImage: true,
                verticalAlignment: Alignment.topCenter,
                onTap: (index) {
                  print('Tapped on page $index');
                },
              ),
              SizedBox(
                height: 40,
              ),

              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Edge30pro()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb00276392e4da35b/view?project=64e0600003aac5802fbc&mode=admin'),
                                height: 100,
                              ),
                            ),
                            Text(
                              'Motorola Edge 30 pro\n'
                                  '₹24999 3̶0̶9̶9̶9̶ (19% off)',
                              style: GoogleFonts.arya(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Text(' • 6 GB RAM | 128 GB ROM\n'
                        ' • 16.64 cm (6.55 inch) Full HD+ Display\n'
                        ' • 50MP + 50MP + 2MP | 32MP Front Camera\n'
                        ' • 4020 mAh Lithium Battery\n'
                        ' • Qualcomm Snapdragon 778G Plus Processor', style: GoogleFonts.arya(fontWeight: FontWeight.w500),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Edge30pro()),
                        );
                      },
                      child: Text(
                        'View Details',
                        style: GoogleFonts.arya(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb528c9b9b9455ca0/view?project=64e0600003aac5802fbc&mode=admin'),
                                height: 100,
                              ),
                            ),
                            Text(
                              'Iphone 14 Pro Max\n'
                                  '₹108999 1̶3̶4̶9̶0̶0̶ (19% off)',
                              style: GoogleFonts.arya(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Text(' • 128 GB ROM\n'
                        ' • 17.02 cm (6.7 inch) Super Retina XDR Display\n'
                        ' • 48MP + 12MP + 12MP | 12MP Front Camera\n'
                        ' • 4020 mAh Lithium Battery\n'
                      , style: GoogleFonts.arya(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb528c9b9b9455ca0/view?project=64e0600003aac5802fbc&mode=admin'),
                                height: 100,
                              ),
                            ),
                            Text(
                              'Iphone 15 Pro Max\n'
                                  '185000 1̶9̶9̶0̶0̶0̶ (7.5% off)',
                              style: GoogleFonts.arya(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Text(' • 128 GB ROM\n'
                        ' • 17.00 cm (6.7 inch) Super Retina XDR Display\n'
                        ' • 50MP + 12MP + 12MP | 12MP Front Camera\n'
                        ' • 4034 mAh Lithium Battery\n'
                        ' • A17 Pro Bionic Chip',
                      style: GoogleFonts.arya(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    SizedBox(
                      child: Column(children: [
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                elevation: MaterialStateProperty.all(0),
                              ),
                              child: Image(
                                image: NetworkImage(
                                    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb528c9b9b9455ca0/view?project=64e0600003aac5802fbc&mode=admin'),
                                height: 100,
                              ),
                            ),
                            Text(
                              'Iphone 15 Pro\n'
                                  '150000 1̶8̶0̶0̶0̶0̶ (7.5% off)',
                              style: GoogleFonts.arya(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.5,
                              ),
                            ),
                          ],
                        ),
                      ],
                      ),
                    ),
                    Text(' • 128 GB ROM\n'
                        ' • 16.00 cm (6.0 inch) Super Retina XDR Display\n'
                        ' • 50MP + 12MP + 12MP | 12MP Front Camera\n'
                        ' • 4034 mAh Lithium Battery\n'
                        ' • A17 Bionic Chip',
                      style: GoogleFonts.arya(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
