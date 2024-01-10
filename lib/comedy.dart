import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class Comedy extends StatefulWidget {
  const Comedy({Key? key}) : super(key: key);

  @override
  State<Comedy> createState() => _ComedyState();
}

class _ComedyState extends State<Comedy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 800.0,
                decoration: BoxDecoration(

                  image: DecorationImage(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/netf'
                      'lix-5002f.appspot.com/o/Anubhav%20Singh%20Bassi%20-%20Bas%20Kar%20Bassi%20_%20Official%20T'
                      'railer%20_%20%40AnubhavSinghBassi%20_%20Prime%20Video%20India.gif?alt=media&token=346718b6-3e10'
                      '-4318-aa32-39f31cf254a3'),fit: BoxFit.fitHeight,
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
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter
                    )
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(padding: EdgeInsets.all(20)),
              Align(
                alignment: Alignment.topLeft,
                child: Text(' Comedy',style: GoogleFonts.amaranth(color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 50),),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Comedy Movies',style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: 20,),
              SingleChildScrollView(
                // physics: ScrollPhysics(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.black,Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))
                      ),
                      child: ElevatedButton(onPressed: (){},
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googlea'
                              'pis.com/v0/b/netflix-5002f.appspot.com/o/meter.webp?alt=media&token=8e58d'
                              'b90-6da4-490d-8799-2847fa25a798',
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                            errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googlea'
                            'pis.com/v0/b/netflix-5002f.appspot.com/o/download%20(7).jpeg?alt=media&token=8e58d'
                            'b90-6da4-490d-8799-2847fa25a798',
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googlea'
                            'pis.com/v0/b/netflix-5002f.appspot.com/o/rrr.webp?alt=media&token=8e58d'
                            'b90-6da4-490d-8799-2847fa25a798',
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:Image(image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/twoandahald.webp?alt=media&token=6aa3f08a-090a-4893-836a-dcf66aa45449'),fit: BoxFit.fitHeight,)),
                  ],
                ),
              ),
              SizedBox(height: 40,),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Award Winning Movies',style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
              SizedBox(height: 20,),
              SingleChildScrollView(
                // physics: ScrollPhysics(),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [Colors.black,Colors.transparent]),
                          borderRadius: BorderRadius.all(Radius.circular(80))
                      ),
                      child: ElevatedButton(onPressed: (){},
                          style: ButtonStyle(
                            // elevation:MaterialStatePropertyAll(50),
                            // shadowColor: MaterialStatePropertyAll(Colors.white),

                            backgroundColor: MaterialStatePropertyAll(Colors.black),
                          ),
                          child:Image(image: NetworkImage('https://wallpapercave.com/dwp1x/wp12034927.jpg'),width:335 ,)
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://images3.alphacoders.com/112/thumbbig-1129019.webp',
                          width: 320,
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://picfiles.alphacoders.com/473/thumb-473846.jpg',
                          width: 200,
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/murder.'
                            'jpg?alt=media&token=a1fd66dc-fbf7-4867-98aa-53450607454d',
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://images4.alphacoders.com/130/thumbbig-1307467.webp',
                          width: 300,
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:80,
              ),
              LoadingAnimationWidget.threeArchedCircle(color: Colors.red.shade400, size: 50),
              SizedBox(
                height:20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
