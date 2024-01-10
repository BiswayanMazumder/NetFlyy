import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:math';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
class MoviesToday extends StatefulWidget {
  const MoviesToday({Key? key}) : super(key: key);

  @override
  State<MoviesToday> createState() => _MoviesTodayState();
}

class _MoviesTodayState extends State<MoviesToday> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey =
  GlobalKey<LiquidPullToRefreshState>();
  static int refreshNum = 10; // number that changes when refreshed
  Stream<int> counterStream =
  Stream<int>.periodic(const Duration(seconds: 10), (x) => refreshNum);

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
  final String apiKey = '49e762a6736f0cd42de39bdb6bff1bf5';
  final String apiUrlday = 'https://api.themoviedb.org/3/trending/movie/day';
  final String apiUrlweek = 'https://api.themoviedb.org/3/trending/movie/week';
  final String apiUrlTVday='https://api.themoviedb.org/3/trending/tv/day';
  final String apiUrlTVweekly='https://api.themoviedb.org/3/trending/tv/week';
  String buildPosterUrl(String posterPath) {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                future: fetchTrendingMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.red,));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    List<Map<String, dynamic>> movies = snapshot.data as List<Map<String, dynamic>>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var movie in movies)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: buildPosterUrl(movie['poster_path']),
                                    filterQuality: FilterQuality.high,
                                    fadeInDuration: Duration(seconds: 2),
                                    fadeOutDuration: Duration(seconds: 2),
                                    fadeInCurve: Curves.decelerate,
                                    placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator(
                                        color: Colors.red,
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Text(
                                      'Image Not Found',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    movie['title'],
                                    style: GoogleFonts.amaranth(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                                  ),
                                ),
                                SizedBox(height: 25),
                                Center(
                                  child: Text(
                                    'Overview: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: movie['overview'], // Access the movie overview here
                                      style: GoogleFonts.amaranth(color: Colors.white),
                                      // Add more spans if needed for different styles
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Center(
                                  child: Text(
                                    'Release Date: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: movie['release_date'], // Access the movie overview here
                                      style: GoogleFonts.amaranth(color: Colors.white),
                                      // Add more spans if needed for different styles
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                Center(
                                  child: Text(
                                    'Popularity: ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Text.rich(
                                    TextSpan(
                                      text: '${movie['vote_average'].toString()}/10', // Access the movie overview here
                                      style: GoogleFonts.amaranth(color: Colors.white),
                                      // Add more spans if needed for different styles
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                Divider(color: Colors.white,
                                  indent: 50,
                                  endIndent: 50,),
                              ],
                            ),
                          ),

                      ],
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
