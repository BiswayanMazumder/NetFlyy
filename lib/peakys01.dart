import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/peakys1links.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Peaky1 extends StatefulWidget {
  const Peaky1({Key? key}) : super(key: key);

  @override
  State<Peaky1> createState() => _Peaky1State();
}

class _Peaky1State extends State<Peaky1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: 'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Peaky%20Blinders%20_%20Season%205%20Trailer%20_%20Netflix.gif?alt=media&token=c55bbe61-a6ac-4e44-860c-13fcb57a0581',
            width: 500,
            height: 900,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
            colorBlendMode: BlendMode.color,
            placeholder: (context, url) => CircularProgressIndicator(
              color: Colors.white,
            ),
            errorWidget: (context, url, error) => Text(
              'Image Not Found',
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Image(
                image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Netflix-Symbol%20(1).png?alt=media&token=91d2fa09-78ee-48e7-868e-5470bedfad8f'),
                width: 40,
              ),
              Text(
                'SERIES',
                style: TextStyle(
                    fontSize: 20,
                    wordSpacing: 3,
                    letterSpacing: 3,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Image(image: AssetImage('assets/images/p.png')),
          SizedBox(
            height: 40,
          ),
          Text(
            'Peaky Blinders Season 1',
            style: GoogleFonts.sacramento(
                fontWeight: FontWeight.bold, fontSize: 35, color: Colors.white),
          ),
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.rectangle, border: Border.all(width: 30)),
            child: ElevatedButton(
                onPressed: () {
                  // launchUrl(_url);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Blinder()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                      size: 30,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text(
                      'Watch Trailer',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              border: Border.all(
                  width: 20,
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid),
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Column(
              children: [
                Text(
                  'ABOUT',
                  style: GoogleFonts.amaranth(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    decorationColor: Colors.green,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Padding(padding: EdgeInsets.all(10)),
                Text(
                  '"Peaky Blinders" Season 1 is a British historical crime drama series set in post-World War'
                  'I Birmingham, England. The show follows the Shelby crime family, led by Thomas Shelby'
                  ' (Cillian Murphy), as they rise to power in the criminal underworld. The familys'
                  'operations involve illegal betting, smuggling, and clashes with other criminal factions '
                  'and law enforcement. As the Shelbys ambition grows, they become entangled in political and '
                  'social tensions. Thomas strategic genius and the familys ruthless tactics drive the '
                  'narrative, while Inspector Chester Campbell (Sam Neill) is determined to bring them down. '
                  'The season delves into themes of power, loyalty, and the impact of war on society. With its'
                  ' gritty atmosphere, compelling characters, and intricate plotting, "Peaky Blinders" Season 1 sets the '
                  'stage for a gripping saga of crime, ambition, and family dynamics.',
                  style: GoogleFonts.arizonia(
                      fontWeight: FontWeight.w400, fontSize: 30),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
