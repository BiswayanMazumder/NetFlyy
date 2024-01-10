import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class _FAQState extends State<FAQ> {
  bool isChecked1=false;
  bool isChecked2=false;
  bool isChecked3=false;
  bool isChecked4=false;
  bool isChecked5=false;
  bool isChecked6=false;
  final Uri _call = Uri.parse('tel:6290714012');
  Future<void> _launchcall() async {
    if (!await launchUrl(_call)) {
      throw "Cannot Launch $_call";
    }
  }
  final Uri _insta = Uri.parse('mailto:biswayanmazumder77@gmail.com');
  Future<void> _launchinsta() async {
    if (!await launchUrl(_insta)) {
      throw "Cannot Launch $_insta";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
       centerTitle: true,
        shadowColor: Colors.white38,
        elevation: 20,
        title: Text(
          'NetFly',
          style: GoogleFonts.amaranth(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Center(child: Text('Frequently Asked Questions',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
              SizedBox(
                height: 20,
              ),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked1=!isChecked1;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked1 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   What is NetFly?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked1)
                SizedBox(
                  height: 240.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''NetFly is a streaming service that offers a wide variety of award-winning TV shows, movies, anime, documentaries and more – on thousands of internet-connected devices.

You can watch as much as you want, whenever you want, without a single ad – all for one low yearly price. There's always something new to discover, and new TV shows and movies are added every week!''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked2=!isChecked2;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked2 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   How much does NetFly cost?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked2)
                SizedBox(
                  height: 130.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''Watch NetFly on your smartphone, tablet, Smart TV, laptop, or streaming device, all for one fixed monthly fee. Plans cost ₹1199 a year with two screens. No extra costs, no contracts.''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked3=!isChecked3;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked3 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   Where can I watch?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked3)
                SizedBox(
                  height: 300.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''Watch anywhere, anytime. Sign in with your NetFly account to watch instantly on the web at netfly.com from your personal computer or on any internet-connected device that offers the NetFly app, including smart TVs, smartphones, tablets, streaming media players and game consoles.

You can also download your favourite shows with the iOS, Android, or Windows 10 app. Use downloads to watch while you're on the go and without an internet connection. Take NetFly with you anywhere.''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked4=!isChecked4;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked4 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   How do I cancel?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked4)
                SizedBox(
                  height: 130.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''NetFly is flexible. There are no annoying contracts and no commitments. You can easily cancel your account online in two clicks. There are no cancellation fees – start or stop your account anytime..''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked5=!isChecked5;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked5 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   What can I watch on NetFly?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked5)
                SizedBox(
                  height: 130.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''NetFly has an extensive library of feature films, documentaries, TV shows, anime, award-winning NetFly originals, and more. Watch as much as you want, anytime you want.''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 5,),
              Container(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isChecked6=!isChecked6;
                        });
                        print(isChecked1);

                      },
                      icon: Icon(
                        isChecked6 ? Icons.remove : Icons.add, // Show different icons based on isChecked1
                        color: Colors.white,
                      ),
                    ),
                    hintText: '   Is NetFly good for Kids?',
                    fillColor: Colors.grey.shade600,
                    filled: true,
                    hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    contentPadding: EdgeInsets.symmetric(vertical: 15.0), // Adjust the padding as needed
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              if (isChecked6)
                SizedBox(
                  height: 110.0, // Adjust the height as needed
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      color: Colors.grey.shade600,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        '''The NetFly Kids experience is included in your membership to give parents control while kids enjoy family-friendly TV shows and films in their own space.

Kids profiles come with PIN-protected parental controls that let you restrict the maturity rating of content kids can watch and block specific titles you don’t want kids to see.''',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 30,),
              Text('If you still have queries mail us at:',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              TextButton(onPressed: (){
                _launchinsta();
              }, child:Text('support@netfly.org')),
              SizedBox(
                height: 20,
              ),
              Text('If you still have queries call us at:',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              TextButton(onPressed: (){
                _launchcall();
              }, child:Text('1800696969')),
            ],
          ),
        ),
      ),
    );
  }
}
