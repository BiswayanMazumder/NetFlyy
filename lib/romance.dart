import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
class Romance extends StatefulWidget {
  const Romance({Key? key}) : super(key: key);

  @override
  State<Romance> createState() => _RomanceState();
}

class _RomanceState extends State<Romance> {
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
                  child: CachedNetworkImage(imageUrl: 'https://firebas'
                      'estorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Holidate%20starrin'
                      'g%20Emma%20Roberts%20_%20Find%20Your%20Perfect%20Plus-One%20_%20Official%20Trailer%20_%2'
                      '0Netflix.gif?alt=media&token=2b4b60fe-abc0-4811-b81b-c4ba6c6c484',
                    placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                    errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                    ),
                  )
              ),
              Padding(padding: EdgeInsets.all(30)),
              LoadingAnimationWidget.dotsTriangle(color: Colors.yellow.shade200, size: 50),
              Padding(padding: EdgeInsets.all(20)),
              Align(
                alignment: Alignment.topLeft,
                child: Text(' Romantic',style: GoogleFonts.amaranth(color: Colors.white,
                    fontWeight: FontWeight.bold,fontSize: 50),),
              ),
              SizedBox(
                height: 40,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text('Romantic Movies',style: GoogleFonts.aboreto(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)),
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
                          child:CachedNetworkImage(imageUrl: 'https://encrypted-tb'
                              'n0.gstatic.com/images?q=tbn:ANd9GcThkHeHZ9nKDXfRPwIAnatTl8NzKBqx1lKPKA',
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                            errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                            ),
                          )
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    // ElevatedButton(onPressed: (){},
                    //     style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                    //     ),
                    //     child:Image(image: AssetImage('assets/images/operation.jpg'))),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://encrypted-tbn0.gstatic.c'
                            'om/images?q=tbn:ANd9GcSsqBHwd5q3nF6MCgNwhu7OJJiwgj4zpmMw0g',
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
                        child:Image(image: NetworkImage('https://images6.alphacoders.com/525/thumbbig-525723.webp'),width: 260,)),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:'
                            'ANd9GcTsJXiX-sZuJe7ruk676y9i5F07SRjwz331Nw',
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )),
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
                          child:CachedNetworkImage(imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT8fH9'
                              '5LmHNmHxjSUa5OxlN1bjFrkR7XgXhIA',
                            placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                            errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                            ),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(onPressed: (){},
                        style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.black),
                        ),
                        child:CachedNetworkImage(imageUrl: 'https://encrypted-tbn0.gstatic.com/im'
                            'ages?q=tbn:ANd9GcRj-6SDZpxXVB2_ulIfjxZstkgAsCZAxiVTrw',
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
                        child:CachedNetworkImage(imageUrl: 'https://picfiles.alphacoders.com/473/thumb-473846.jpg',
                          width: 200,
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
                        child:CachedNetworkImage(imageUrl: 'https://firebasestorage.google'
                            'apis.com/v0/b/netflix-5002f.appspot.com/o/murder.jpg?alt=media&token=a1fd66'
                            'dc-fbf7-4867-98aa-53450607454d',
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
                        child:CachedNetworkImage(imageUrl: 'https://images4.alphacoders.com/130/thumbbig-1307467.webp',
                          width: 300,
                          placeholder: (context, url) => CircularProgressIndicator(color: Colors.white,),
                          errorWidget: (context, url, error) => Text('Image Not Found',style: TextStyle(color: Colors.white)
                          ),
                        )),
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
