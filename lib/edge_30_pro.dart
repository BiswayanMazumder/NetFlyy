import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popup_banner/popup_banner.dart';
import 'package:neopop/neopop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
class Edge30pro extends StatefulWidget {
  const Edge30pro({Key? key}) : super(key: key);

  @override
  State<Edge30pro> createState() => _Edge30proState();
}

class _Edge30proState extends State<Edge30pro> {
  // Function to check if the current user is the owner of the comment
  TextEditingController commentController = TextEditingController();
  final CollectionReference commentsCollection =
  FirebaseFirestore.instance.collection('comments_motorola_edge_30_pro');

  bool isCurrentUserOwner(Map<String, dynamic> commentData) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null && commentData['userId'] == currentUser.uid;
  }

  void deleteComment(DocumentReference commentReference) {
    commentReference.delete().then((value) {
      print('Comment deleted successfully');
    }).catchError((error) {
      print('Error deleting comment: $error');
    });
  }

  void submitComment() {
    String commentText = commentController.text;
    if (commentText.isNotEmpty) {
      commentsCollection.add({
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
      });
      commentController.clear();
    }
  }

  var _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Handle payment success
    print("Payment successful");
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //       builder: (context) => motorola_confirmed()),
    // );
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Handle payment failure
    print("Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet
    print("External wallet selected");
  }
  int currentImageIndex = 0;
  final List<String> imageUrls = [
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652c26b16a467a742ddb/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb00276392e4da35b/view?project=64e0600003aac5802fbc&mode=admin',
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652c2a2dec04c89e9085/view?project=64e0600003aac5802fbc&mode=admin',
    // 'https://image-url-4.jpg',
  ];

  // Function to change the current image
  void changeImage(int index) {
    setState(() {
      currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motorola Edge 30 Pro'),
        centerTitle: true,
        elevation: 50,
        shadowColor: Colors.black,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Center(
                      child: Image.network(
                        imageUrls[currentImageIndex],
                        height: 200,
                      ),
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < imageUrls.length; i++)
                    ElevatedButton(
                      onPressed: () => changeImage(i),
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      child: Image.network(
                        imageUrls[i],
                        height: 40,
                      ),
                    ),
                  TextButton(onPressed: (){
                    PopupBanner(
                      context: context,

                      images: [
                        "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652cbf9d0ff3b2fd921e/view?project=64e0600003aac5802fbc&mode=admin",
                        "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652cbfd592db851d0a5c/view?project=64e0600003aac5802fbc&mode=admin",
                        "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652cc00487c6631c1a5d/view?project=64e0600003aac5802fbc&mode=admin",
                        'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652c26b16a467a742ddb/view?project=64e0600003aac5802fbc&mode=admin',
                        'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652bb00276392e4da35b/view?project=64e0600003aac5802fbc&mode=admin',
                        'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652c2a2dec04c89e9085/view?project=64e0600003aac5802fbc&mode=admin'
                      ],
                      fit: BoxFit.fitWidth,
                      autoSlide: false,
                      useDots: false,
                      fromNetwork: true,
                      slideChangeDuration: Duration(seconds: 10),
                      onClick: (index) {
                        debugPrint("CLICKED $index");
                      },
                    ).show();
                  },
                      child:Text('View More',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),))
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                'MOTOROLA Edge 30 Pro (Cosmos Blue, 128 GB)\n(8 GB RAM)',
                style: GoogleFonts.aboreto(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    Text(
                      ' Extra ₹21000 off',
                      style:TextStyle(color: Colors.green,
                      fontWeight: FontWeight.bold,
                        fontSize:19
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(' ₹34,999',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(width: 20,),
                  Text('₹5̶5̶9̶9̶9̶',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300,color: Colors.grey
                  ),),
                  SizedBox(width: 20,),
                  Text('37% off',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.green
                  ),)
                ],
              ),
              Column(
                children: [
                  // TextButton(onPressed: (){Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => motorola_confirmed()),
                  // );}, child: Text('Test',style: TextStyle(color: Colors.black),)),
                  SizedBox(
                    height: 15,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(' + ₹69 Secured Packaging Fee'),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 45,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(' COMING SOON',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  )
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.center,

                    child: NeoPopButton(
                      color: Colors.yellow,
                      enabled: true,
                      border: Border.all(color: Colors.black),
                      animationDuration: Duration(seconds: 1),
                      shadowColor:Colors.black,
                      forwardDuration: Duration(seconds: 1),
                      reverseDuration: Duration(seconds: 1),
                      onLongPress: (){
                        var options = {
                          'key': 'rzp_test_WoKAUdpbPOQlXA',
                          'amount': 1, //in the smallest currency sub-unit.
                          'name': 'NetFly',

                           // Generate order_id using Orders API
                          'description': 'Fine T-Shirt',
                          'timeout': 300,
                          "notify": {
                            "sms": true,
                            "email": true
                          },
                          "options": {
                            "checkout": {
                              "name": "NetFly"
                            }
                          }// in seconds
                        };
                        _razorpay.open(options);
                      },
                      depth: 25,
                      onTapUp:(){
                        var options = {
                          'key': 'rzp_test_WoKAUdpbPOQlXA',
                          'amount': 50000, //in the smallest currency sub-unit.
                          'name': 'NetFly',
                          // Generate order_id using Orders API
                          'description': 'Motorola Edge 30 Pro',
                          'timeout': 300,
                          "notify": {
                            "sms": true,
                            "email": true
                          },
                          "options": {
                            "checkout": {
                              "name": "NetFly"
                            }
                          }
// in seconds
                        };
                        _razorpay.open(options);
                      },
                      // onTapDown: (){
                      //   var options = {
                      //     'key': 'rzp_test_WoKAUdpbPOQlXA',
                      //     'amount': 50000, //in the smallest currency sub-unit.
                      //     'name': 'NetFly',
                      //     // Generate order_id using Orders API
                      //     'description': 'Motorola Edge 30 Pro',
                      //     'timeout': 300, // in seconds
                      //   };
                      //   _razorpay.open(options);
                      // },

                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Wanna Prebook",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Center(
                              child: Text('Avaliable Offers',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                            ),
                            Text('\n ⚫ Bank Offer5% Cashback on Flipkart Axis Bank Card\n'

                            '\n ⚫ Special PriceGet extra ₹21000 off (price inclusive of cashback/coupon)\n'

                            '\n ⚫ Partner OfferSign-up for Flipkart Pay Later & get free Times Prime Benefits worth ₹20,000\n'

                            '\n ⚫ Partner OfferPurchase now & get 1 surprise cashback coupon in FutureKnow More\n'

                              '\n  ⚫ EMI starting from ₹1,231/monthView Plans',style: TextStyle(
                              fontWeight: FontWeight.w300,

                            ),),
                            SizedBox(
                              height: 30,
                            ),
                            Align(
                              child: Center(
                                child: Text('Highlights',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,),
                                ),
                              )
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text('⁍ 8 GB RAM | 128 GB ROM',style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 8,
                            ),
                            Text('⁍ 16.3 cm (6.417 inch)Full HD+ AMOLED Display',style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 8,
                            ),
                            Text('⁍ 50MP + 50MP + 2MP | 60MP Front Camera',style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 8,
                            ),
                            Text('⁍ 4800 mAh Lithium Polymer Battery',style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 8,
                            ),
                            Text('⁍ Qualcomm Snapdragon 8 Gen 1 Processor',style: TextStyle(fontWeight: FontWeight.w400)),
                            SizedBox(
                              height: 40,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Description',style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Text('With a powerful 4 nm architecture',style: TextStyle(fontWeight: FontWeight.w400),)
                                ],
                              ),
                            ),
                            Text('and in-built Snapdragon 8 Gen 1, Motorola Edge 30 Pro is all set to mesmerise you with its impeccable\n'
                                'capabilities. Equipped with a 60 MP Quad Pixel front camera, you can capture impeccable selfies. With\n'
                                'Wi-Fi 6E you don’t have to wait for anything while operating this phone, which means no buffering while\n'
                                'browsing and no cluttering while streaming. This phone comes with a 17.01 cm (6.7) Max Vision AMOLED\n'
                                'display that makes everything on the screen look true-to-life. Furthermore, Motorola Edge 30 Pro boasts\n'
                                'a 4800 mAh battery that lasts long and has a rapid charging interface with 68 W TurboPower charging,\n'
                                'which helps in charging your phone up to 50% in around 15 minutes.',style: TextStyle(fontWeight: FontWeight.w400),),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text('Product Description',style: TextStyle(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize:18),),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652d7aa02ab79a2fe446/view?project=64e0600003aac5802fbc&mode=admin',),width: 120,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('𝐅𝐚𝐬𝐭 𝐒𝐧𝐚𝐩𝐝𝐫𝐚𝐠𝐨𝐧 𝐏𝐫𝐨𝐜𝐞𝐬𝐬𝐨𝐫\n\nWith Snapdragon 8 Gen 1\n'
                                    'equipped in this Motorola\nEdge 30 Pro'
                                    'you can enjoy the\n'
                                    'unrivalled speed and power of\n'
                                    'Qualcomms 4 nm processor\n'
                                    'Furthermore, you can enjoy\n'
                                    'performance reinforcements like\npowerful AI,'
                                    'a lightning-fast\nrefresh rate, rapid 5G connectivity\npremium gameplay '
                                    'experience\nSnapdragon Elite Gaming, and\nimmersive sound effects with\nSnapdragon Sound.',style: TextStyle(fontWeight: FontWeight.w400),),

                              ],
                            ),

                            SizedBox(
                              height: 20,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                //Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652d7aa02ab79a2fe446/view?project=64e0600003aac5802fbc&mode=admin',),width: 150,),
                                Text('𝟔𝟎 𝐌𝐏 𝐇𝐢𝐠𝐡-𝐫𝐞𝐬𝐨𝐥𝐮𝐭𝐢𝐨𝐧 𝐒𝐞𝐥𝐟𝐢𝐞 𝐂𝐚𝐦𝐞𝐫𝐚\n\nWith the top-notch\n'
                                    '60 MP Quad Pixel Selfie Camera,\nyou can take selfies\n'
                                    'delight. In this camera setup,\n'
                                    'every four pixels are combined into\n'
                                    'one for improved low-light\n'
                                    'susceptibility, resulting in \n'
                                    'beautiful selfies with every image.',style: TextStyle(fontWeight: FontWeight.w400),),
                                Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652d833686919f7a9357/view?project=64e0600003aac5802fbc&mode=admin',),width: 120,),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Image(image: NetworkImage('https://rukminim2.flixcart.com/image/200/200/cms-rpd-images/dc2a4b47b7c44d69a2db7bb954d5a3fb_17f0b40f907_image.jpeg?q=90',),width: 120,),
                                SizedBox(
                                  width: 10,
                                ),
                                Text('𝐁𝐥𝐚𝐳𝐢𝐧𝐠-𝐟𝐚𝐬𝐭 𝟓𝐆\n\nYou can seamlessly \n'
                                    'connect to 5G networks for\nlightning-fast connections when\n'
                                    ' you are streaming your favourite\n'
                                    'shows. You can race ahead of your\n'
                                    'peers via a speedy 6 GHz\n'
                                    'Wi-Fi spectrum with Wi-Fi 6E.\n'
                                    ,style: TextStyle(fontWeight: FontWeight.w400),),

                              ],

                            ),


                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextField(
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Review...',
                        contentPadding: EdgeInsets.all(10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: submitComment,
                    child: Text('Submit Review'),
                  ),
                  SizedBox(height: 20),
                  StreamBuilder<QuerySnapshot>(
                    stream: commentsCollection.orderBy('timestamp').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }
                      if (snapshot.hasData) {
                        final comments = snapshot.data!.docs;
                        return Column(
                          children: comments.map((comment) {
                            final commentData =
                            comment.data() as Map<String, dynamic>;
                            bool isOwner = isCurrentUserOwner(commentData);

                            return ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    commentData['commentText'],
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  if (isOwner)
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () => deleteComment(comment.reference),
                                    ),
                                ],
                              ),
                              subtitle: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (commentData['timestamp'] != null)
                                    Text(
                                      'Commented on ${commentData['timestamp'].toDate().toString().split(' ')[0]}',
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                ],
                              ),
                            );

                          }).toList(),
                        );
                      }
                      return Text('No comments yet.');
                    },
                  ),

                  SizedBox(
                    height: 150,
                  ),
                ],
              ),
          ]
        ),
      ),
    ) );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }
}
