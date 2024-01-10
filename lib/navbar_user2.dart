import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:netflix/coming.dart';
import 'package:netflix/firstpage.dart';
import 'package:netflix/search.dart';
class NavBar_user2 extends StatefulWidget {
  const NavBar_user2({Key? key}) : super(key: key);

  @override
  State<NavBar_user2> createState() => _NavBar_user2State();
}

class _NavBar_user2State extends State<NavBar_user2> {

  int _index=0;
  final screens=[
    FirstPage(),
    SearchScreen(),
    Coming_Soon(initialTimerValue: 300,),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      backgroundColor: Colors.black,

      bottomNavigationBar: GNav(
          haptic: true,
          curve: Curves.bounceInOut,
          rippleColor: Colors.yellow,
          tabActiveBorder: Border.all(color: Colors.green,
              style: BorderStyle.solid),
          hoverColor: Colors.white,
          activeColor: Colors.black,
          color: Colors.deepPurpleAccent,
          // rippleColor: Colors.green,
          tabBackgroundColor: Colors.green,
          selectedIndex: _index,
          // tabBorder: Border.all(color: Colors.red),
          gap: 1,
          onTabChange: (value){
            setState(() {
              _index=value;
            });
          },
          tabs: const[
            GButton(icon: Icons.home,
              text: 'HomePage',
              rippleColor: Colors.green,
              backgroundColor: Colors.cyan,
            ),
            GButton(icon: Icons.search,text: 'Searches',
              backgroundColor: Colors.lightGreenAccent,
            ),
            GButton(icon: Icons.movie_filter,text: 'New Launches',
              backgroundColor: Colors.deepOrangeAccent,
              haptic: true,
              debug: true,
            ),
          ]
      ),
    );
  }
}
