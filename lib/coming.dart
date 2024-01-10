import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/TV_daily.dart';
import 'package:netflix/TV_series.dart';
import 'package:netflix/TV_weekly.dart';
import 'package:netflix/movies_today_trending.dart';
import 'package:netflix/movies_weekly.dart';
import 'package:netflix/scam_2003.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:math';
void main() {
  runApp(MyApp());
}

class Coming_Soon extends StatefulWidget {
  final int initialTimerValue;

  Coming_Soon({required this.initialTimerValue});
  @override
  _Coming_SoonState createState() => _Coming_SoonState();
}

class _Coming_SoonState extends State<Coming_Soon>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
  Stream<int>.periodic(const Duration(seconds: 3), (x) => refreshNum);

  ScrollController? _scrollController;

  Future<void> _handleRefresh() {
    final Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    setState(() {
      refreshNum = Random().nextInt(100);
    });
    return completer.future.then<void>((_) {
      ScaffoldMessenger.of(_scaffoldKey.currentState!.context).showSnackBar(
        SnackBar(
          content: const Text('Refresh complete'),
          action: SnackBarAction(
            label: 'RETRY',
            onPressed: () {
              _refreshIndicatorKey.currentState!.show();
            },
          ),
        ),
      );
    });
  }
  late Timer _timer;
  int _startTime = 300;
  bool _pictureRevealed = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User? _user;
  bool _showdaily=false;
  bool _showweekly=false;
  bool _showperson=false;
  bool _showtvweekly=false;
  @override
  bool get wantKeepAlive => true; // Set this to true to keep the state alive
  final String apiKey = '49e762a6736f0cd42de39bdb6bff1bf5';
  final String apiUrlday = 'https://api.themoviedb.org/3/trending/movie/day';
  final String apiUrlweek = 'https://api.themoviedb.org/3/trending/movie/week';
  final String apiUrlTVday='https://api.themoviedb.org/3/trending/tv/day';
  final String apiUrlTVweekly='https://api.themoviedb.org/3/trending/tv/week';
  Future<List<Map<String, dynamic>>> fetchTrendingMovies() async {
    final response = await http.get(Uri.parse('$apiUrlday?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((movie) {
        return {
          'title': movie['title'],
          'poster_path': movie['poster_path'],
          'overview': movie['overview'],
          'release_date': movie['release_date'],
          'id': movie['id'],
          'release date':movie['release_date'],
          'vote_average':movie['vote_average']
        };
      }));
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
  Future<List<Map<String, dynamic>>> fetchTrendingMoviesmonth() async {
    final response = await http.get(Uri.parse('$apiUrlweek?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((movies) {
        return {
          'title': movies['title'],
          'poster_path': movies['poster_path'],
          'overview': movies['overview'],
          'release_date': movies['release_date'],
          'id': movies['id'],
          'release date':movies['release_date'],
          'vote_average':movies['vote_average']
        };
      }));
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
  Future<List<Map<String, dynamic>>> fetchTrendingTVday() async {
    final response = await http.get(Uri.parse('$apiUrlTVday?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((movies) {
        return {
          'title': movies['name'],
          'poster_path': movies['poster_path'],
          'overview': movies['overview'],
          'release_date': movies['release_date'],
          'id': movies['id'],
          'release date':movies['release_date'],
          'vote_average':movies['vote_average']
        };
      }));
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
  Future<List<Map<String, dynamic>>> fetchTrendingTVweekly() async {
    final response = await http.get(Uri.parse('$apiUrlTVweekly?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return List<Map<String, dynamic>>.from(data['results'].map((movies) {
        return {
          'title': movies['name'],
          'poster_path': movies['poster_path'],
          'overview': movies['overview'],
          'release_date': movies['release_date'],
          'id': movies['id'],
          'release date':movies['release_date'],
          'vote_average':movies['vote_average']
        };
      }));
    } else {
      throw Exception('Failed to load trending movies');
    }
  }
  String buildPosterUrl(String posterPath) {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
  final List<String> pages = ['Movies\nToday', 'Movies\nWeekly', 'TV\nToday', 'TV\nWeekly','TV\nSeries'];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: pages.length,
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/657748367e5e83b0068b/view?project=64e0600003aac5802fbc&mode=admin',),
                height: 50,
                width: 50,),
                SizedBox(
                  width: 5,
                ),
                Text('Trending',style: TextStyle(color: Colors.white),),
              ],
            ),
            backgroundColor: Colors.black,
            automaticallyImplyLeading: false,
            bottom: TabBar(tabs: pages.map((page) => Tab(text: page)).toList(),
              indicatorColor: Colors.red,
              enableFeedback: true,
              automaticIndicatorColorAdjustment: true,
              labelColor: Colors.yellowAccent,
              unselectedLabelColor: Colors.white,
              padding: EdgeInsets.only(),
            ),
          ),
          body: LiquidPullToRefresh(
            onRefresh: _handleRefresh,
            showChildOpacityTransition: false,
            child: TabBarView(
              children: [
                MoviesToday(),
                MoviesWeekly(),
                TV_daily(),
                TV_weekly(),
                TV_series()
              ],
            ),
          ),
        )
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timer App',
      home: Coming_Soon(initialTimerValue: 300,),
    );
  }
}