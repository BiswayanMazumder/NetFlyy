import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon/neon.dart';
import 'package:netflix/main.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          centerTitle: true,
          elevation: 80,
          toolbarHeight: 80,
          bottomOpacity: 80,
          titleSpacing: 20,
          automaticallyImplyLeading: true,
          //shape: Radius.circular(BorderSide.strokeAlignInside),
          shadowColor: Colors.red,
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.logout))],
          backgroundColor: Colors.black,
          title: Neon(
            text: 'NETFLY',
            color: Colors.green,
            font: NeonFont.Cyberpunk,
            flickeringText: true,
            fontSize: 35,
          )),
      body: ListView(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(10)),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '  Account',
                      style: GoogleFonts.arya(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 40),
                    )),
                Padding(padding: EdgeInsets.all(10)),
                Divider(
                  color: Colors.black,
                  indent: 80,
                  endIndent: 80,
                  thickness: 2,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        '  Membership And Billing',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'f{email}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    // Align(
                    //   alignment: Alignment.topLeft,
                    //   child: Text(
                    //     '  Phone:8335856470',
                    //     style: TextStyle(
                    //         color: Colors.grey,
                    //         fontSize: 20,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Padding(padding: EdgeInsets.all(10)),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () async {
                                ImagePicker imagepicker = ImagePicker();
                                imagepicker.pickImage(
                                    source: ImageSource.gallery);
                              },
                              icon: Icon(Icons.camera_alt))
                        ],
                      ),
                    ),
                    Padding(padding: EdgeInsets.all(20)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()),
                          );
                        },
                        child: Neon(
                          text: 'Sign Out',
                          color: Colors.red,
                          font: NeonFont.NightClub70s,
                          textStyle: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 50),
                          flickeringText: true,
                          glowing: true,
                          fontSize: 50,
                        ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
