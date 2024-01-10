import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/user_account.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:app_settings/app_settings.dart';
class Error404 extends StatefulWidget {
  const Error404({Key? key}) : super(key: key);

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  String _connectionStatus = 'Unknown';
  late Timer _connectivityTimer;
  bool _isConnected=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _connectionStatus = _getStatusString(result);
        _handleNavigation(result);
      });
    });

    // Check the initial connection state
    _checkConnection();

    // Start a timer to check connectivity periodically
    _connectivityTimer = Timer.periodic(Duration(seconds: 15), (timer) {
      _checkConnection();
    });
  }
  void _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _connectionStatus = _getStatusString(connectivityResult);
      _handleNavigation(connectivityResult);
    });
  }
  late String _lastPage;
  void _handleNavigation(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // Navigate to another page when not connected
      if (_isConnected) {
        _isConnected = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('No Internet Connection'),
            ),
            backgroundColor: Colors.red,

          ),
        );
      }
    } else {
      // If connected, navigate back to the original page
      if (!_isConnected) {
        _isConnected = true;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(
              child: Text('Internet Connection Restored'),
            ),
            backgroundColor: Colors.green,

          ),
        );
        Future.delayed(Duration(seconds:2), () {
          // Delay for a short period before navigating
          if (Navigator.of(context).canPop()) {
            // Pop the current route and return to the previous route
            Navigator.of(context).pop();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserAccount(initialTimerValue: 300)),
            );
            print("Unable to pop route. Page might be disposed or not in the tree.");
          }
        });
      }
    }
  }


  String _getStatusString(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return 'Not connected to the internet';
      case ConnectivityResult.wifi:
        return 'Connected to WiFi';
      case ConnectivityResult.mobile:
        return 'Connected to mobile network';
      default:
        return 'Unknown';
    }
  }
  void _refresh() {
    _checkConnection();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image(image:AssetImage('assets/images/nowifi.png')),
              SizedBox(
                height: 20,
              ),
              Text('Whoops',style: GoogleFonts.amaranth(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 50),),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Text('No Internet connection found',
                    style: GoogleFonts.arya(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 25)),
              ),
              Center(
                child: Text('Check your connection',
                    style: GoogleFonts.arya(color: Colors.black,fontWeight: FontWeight.w100,fontSize: 25)),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(onPressed:_refresh,
                  style: ButtonStyle(elevation: MaterialStatePropertyAll(30),
                  shadowColor: MaterialStatePropertyAll(Colors.black),
                  side: MaterialStatePropertyAll(BorderSide(color: Colors.black,style: BorderStyle.solid)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: Text('Try Again',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed:(){
                AppSettings.openAppSettings(type: AppSettingsType.wifi);
              },
                  style: ButtonStyle(elevation: MaterialStatePropertyAll(30),
                      shadowColor: MaterialStatePropertyAll(Colors.black),
                      side: MaterialStatePropertyAll(BorderSide(color: Colors.black,style: BorderStyle.solid)),
                      backgroundColor: MaterialStatePropertyAll(Colors.blue)),
                  child: Text('Open Settings',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
            ],
          ),
        )
      ),
    );
  }
}
