import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/narcos.dart';
class Trending extends StatefulWidget {
  const Trending({Key? key}) : super(key: key);

  @override
  State<Trending> createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,

        automaticallyImplyLeading: false,
        leading: Image.network(
          'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/64e1e37989a65cfaf68e/vi'
              'ew?project=64e0600003aac5802fbc&mode=admin',
          width: 500,
          filterQuality: FilterQuality.high,
          colorBlendMode: BlendMode.color,
        ),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    height: 800.0,
                    decoration: BoxDecoration(

                      image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v'
                          '0/b/netflix-5002f.appspot.com/o/UNCHARTED%20-%20Official%20Trailer%20(HD)%20(1)'
                          '.gif?alt=media&token=02b04097-414e-430d-832c-5aee0a685f05'),fit: BoxFit.fitHeight,
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
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SingleChildScrollView(
                child:Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #1',style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Narcos()),
                            );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://thedrum-media.imgix.net/thedrum-prod/s3/news/tmp/116055/narcos-.jpg?w=1280&ar'
                                '=default&fit=crop&crop=faces,edges&auto=format',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #2',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child:Container(

                        decoration: BoxDecoration(
                            border:Border.all(color: Colors.yellow),
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        height: 250,
                        width: 400,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const uri()),
                              // );
                            },
                            style: ButtonStyle(
                              // elevation:MaterialStatePropertyAll(50),
                              // shadowColor: MaterialStatePropertyAll(Colors.white),

                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://miro.medium.com/v2/resize:fit:1000/1*Nxaz2PmGHZYJv0gIcBOOWg.jpeg',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #3',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      child:Container(

                        decoration: BoxDecoration(
                            border:Border.all(color: Colors.yellow),
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent]),
                            borderRadius: BorderRadius.all(Radius.circular(80))),
                        height: 250,
                        width: 400,
                        child: ElevatedButton(
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => const uri()),
                              // );
                            },
                            style: ButtonStyle(
                              // elevation:MaterialStatePropertyAll(50),
                              // shadowColor: MaterialStatePropertyAll(Colors.white),

                              backgroundColor: MaterialStatePropertyAll(Colors.black),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                              'https://i.pinimg.com/originals/4e/3f/41/4e3f41bab342202c89c677305ef4071c.jpg',
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                              errorWidget: (context, url, error) => Text(
                                'Image Not Found',
                                style: TextStyle(color: Colors.white),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #4',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/download%20(7).jpeg?alt=media&token=8e58d''b90-6da4-490d-8799-2847fa25a798',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #5',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/65073a94a27d72878fef/view?proje'
                                'ct=64e0600003aac5802fbc&mode=admin',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #6',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/65073b498b2180eb7d'
                                'a6/view?project=64e0600003aac5802fbc&mode=admin',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #7',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://wallpapercave.com/wp/wp6761196.jpg',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #8',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://wallpapercave.com/wp/wp7285333.jpg',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #9',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(

                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://wallpapercave.com/wp/wp6075960.jpg',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(' Trending #10',style: GoogleFonts.aBeeZee(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border:Border.all(color: Colors.yellow),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                      height: 250,
                      width: 400,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => const uri()),
                            // );
                          },
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS5hdfoEKtqRSbEAB0mcJa8hzv0nsZZVERTqA&usqp=CAU',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                            errorWidget: (context, url, error) => Text(
                              'Image Not Found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
