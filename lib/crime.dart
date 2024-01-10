import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
class CrimePage extends StatefulWidget {
  const CrimePage({Key? key}) : super(key: key);

  @override
  State<CrimePage> createState() => _CrimePageState();
}

class _CrimePageState extends State<CrimePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(height: 20,),
              // SizedBox(
              //   height:620,
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(colors: [Colors.black,Colors.transparent],begin: AlignmentDirectional.bottomCenter,
              //           end: Alignment.topCenter),
              //       //border: Border.all(color: Colors.yellow.shade200)
              //     ),
              //     child: AnotherCarousel(
              //         boxFit: BoxFit.fill,
              //         overlayShadowColors: Colors.transparent,
              //         overlayShadow: false,
              //         dotIncreasedColor: Colors.white,
              //         dotColor: Colors.transparent,
              //         overlayShadowSize: 0,
              //         dotSpacing: 20,
              //         showIndicator: false,
              //         borderRadius: false,
              //         //ADD IMAGE TAP
              //         radius: Radius.circular(80),
              //         images: [AssetImage('assets/images/rrr.webp',),
              //           AssetImage('assets/images/raw.webp'),
              //           AssetImage('assets/images/rednotice.jpg'),
              //           AssetImage('assets/images/peakyblinders.jpg'),
              //           AssetImage('assets/images/majnu.jpg')]),
              //   ),
              // ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius:BorderRadius.all(Radius.circular(80)),
                    //border: Border.all(color: Colors.white)
                  ),
                  child:  CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/v0/b/netflix-'
                      '5002f.appspot.com/o/Peaky%20Blinders%20_%20Season%205%20Trailer%20_%20Netflix.gif?'
                      'alt=media&token=c55bbe61-a6ac-4e44-860c-13fcb57a0581',
                    // width: 500,
                    // height: 900,
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.high,
                    colorBlendMode: BlendMode.color,
                    placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                    errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),),
              ),
              Padding(padding: EdgeInsets.all(30)),
              LoadingAnimationWidget.dotsTriangle(color: Colors.yellow.shade200, size: 50),
              Padding(padding: EdgeInsets.all(20)),
              Text('Crime',style: GoogleFonts.amaranth(color: Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 50),),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Crime And Thriller',style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
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
                          child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                              'v0/b/netflix-5002f.appspot.com/o/majnu.jpg?alt=media&token=7c3250e7-cfab-'
                              '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                            errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/raw.webp?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/uncharted.webp?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/rrr.webp?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/twoandahald.webp?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                  ],
                ),
              ),
              // SizedBox(height: 40,),
              // Align(
              //     alignment: Alignment.topLeft,
              //     child: Text('WorldWide Action Movies',style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
              // SizedBox(height: 20,),
              // SingleChildScrollView(
              //   // physics: ScrollPhysics(),
              //   physics: BouncingScrollPhysics(),
              //   scrollDirection: Axis.horizontal,
              //   child: Row(
              //     children: [
              //       Container(
              //         decoration: BoxDecoration(
              //             gradient: LinearGradient(colors: [Colors.black,Colors.transparent]),
              //             borderRadius: BorderRadius.all(Radius.circular(80))
              //         ),
              //         child: ElevatedButton(onPressed: (){},
              //             style: ButtonStyle(
              //               // elevation:MaterialStatePropertyAll(50),
              //               // shadowColor: MaterialStatePropertyAll(Colors.white),
              //
              //               backgroundColor: MaterialStatePropertyAll(Colors.black),
              //             ),
              //             child:Image(image: AssetImage('assets/images/raes.webp'))),
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       ElevatedButton(onPressed: (){},
              //           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
              //           ),
              //           child:Image(image: AssetImage('assets/images/raw.webp'),fit: BoxFit.fitHeight,)),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       ElevatedButton(onPressed: (){},
              //           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
              //           ),
              //           child:Image(image: AssetImage('assets/images/uncharted.webp'),fit: BoxFit.fitHeight,)),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       ElevatedButton(onPressed: (){},
              //           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
              //           ),
              //           child:Image(image: AssetImage('assets/images/murder.jpg'),fit: BoxFit.fitHeight,)),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       ElevatedButton(onPressed: (){},
              //           style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
              //           ),
              //           child:Image(image: AssetImage('assets/images/aka.jpg'),fit: BoxFit.fitHeight,)),
              //     ],
              //   ),
              // ),
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
                          child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                              'v0/b/netflix-5002f.appspot.com/o/possessed.webp?alt=media&token=7c3250e7-cfab-'
                              '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                            errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/Queens.jpg?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/timetrap.webp?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/murder.jpg?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.googleapis.com/'
                            'v0/b/netflix-5002f.appspot.com/o/aka.jpg?alt=media&token=7c3250e7-cfab-'
                            '455c-bc27-7e8061d0a477',fit: BoxFit.fitHeight,
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white),),
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),)),
                  ],
                ),
              ),
              SizedBox(
                height:80,
              )
            ],
          )
        ],
      ),
    );
  }
}
