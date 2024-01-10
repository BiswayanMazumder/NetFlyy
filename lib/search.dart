import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:netflix/a_man_named_otto.dart';
import 'package:netflix/amsterdam.dart';
import 'package:netflix/brandnewcherryflavour.dart';
import 'package:netflix/breaking_bad.dart';
import 'package:netflix/brooklyn_main.dart';
import 'package:netflix/chainsaw.dart';
import 'package:netflix/delhi_crime.dart';
import 'package:netflix/demon_slayer.dart';
import 'package:netflix/extraction.dart';
import 'package:netflix/fairytail.dart';
import 'package:netflix/godfather.dart';
import 'package:netflix/godfather_og_hindi.dart';
import 'package:netflix/johny.dart';
import 'package:netflix/jujutsu.dart';
import 'package:netflix/linclnlawyer.dart';
import 'package:netflix/mission_majnu.dart';
import 'package:netflix/narcos.dart';
import 'package:netflix/naruto.dart';
import 'package:netflix/one_punch.dart';
import 'package:netflix/peakyblinders.dart';
import 'package:netflix/raees.dart';
import 'package:netflix/raw_beast.dart';
import 'package:netflix/rednotice.dart';
import 'package:netflix/seinfield.dart';
import 'package:netflix/sex_ed_main.dart';
import 'package:netflix/strangerthings.dart';
import 'package:netflix/the_railway_men.dart';
import 'package:netflix/toohottohandle.dart';
import 'package:netflix/twoandahalf.dart';
import 'package:netflix/uri.dart';
import 'package:netflix/user_account.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SearchScreen(),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchQuery = "";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  stt.SpeechToText? _speech;
  bool _isListening = false;
  CollectionReference? _searchHistoryCollection;
  _SearchScreenState() {
    _speech = stt.SpeechToText();
  }

  @override
  void initStatee() {
    super.initState();
    _searchHistoryCollection = _firestore.collection('users_search'); // Initialize _searchHistoryCollection
  }
  void _listen() async {
    if (!_isListening) {
      if (await _speech!.initialize()) {
        _speech!.listen(
          onResult: (result) {
            setState(() {
              searchQuery = result.recognizedWords;
              _searchController.text = searchQuery;
            });
          },
        );
        setState(() {
          _isListening = true;
        });
      }
    } else {
      _speech!.stop();
      setState(() {
        _isListening = false;
      });
    }
  }
  User? _user;
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    if (_user != null) {
      _loadRecentSearches();
    }
  }

  void _loadRecentSearches() async {
    final userId = _user!.uid;
    final searchHistorySnapshot = await _firestore
        .collection('users_search')
        .doc(userId)
        .collection('searchHistory')
        .orderBy('timestamp', descending: true)
        .get();

    final searches = searchHistorySnapshot.docs.map((doc) {
      return doc.data()['query'].toString();
    }).toList();

    setState(() {
      _recentSearches = searches;
    });
  }

  void _saveSearchQuery(String query) async {
    final userId = _user!.uid;
    if(!_recentSearches.contains(query)){
      _recentSearches.add(query);
      await _firestore.collection('users_search').doc(userId).collection(
          'searchHistory').add({
        'query': query,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }
  Future<void> _clearMessages(BuildContext context) async {
    setState(() async {
      // Access the Firestore collection
      CollectionReference messagesCollection = FirebaseFirestore.instance.collection('users_search').doc(_user!.uid).collection('searchHistory');
      try {
        // Get a reference to all documents in the collection
        QuerySnapshot querySnapshot = await messagesCollection.get();

        // Iterate through the documents and delete them
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }

        // Show a Snackbar after successful clearing
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Center(child: Text('Recent Searches cleared successfully')),
          ),
        );

      } catch (e) {
        // Handle errors, e.g., Firestore errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text("Sorry Couldn't delete Recent Searches")),
          ),
        );
      }
    });
  }

  Set<String> searchResults = {
    "Peaky Blinders-Season I",
    'Lincoln Lawyer',
    'Stranger Things',
    'GodFather(Hindi)',
    'Brand New Cherry Flavour',
    'Johnny English Reborn',
    'Demon Slayer',
    'Red Notice',
    'Uncharted',
    'Extraction-I',
    'Extraction-II',
    'San Andreas',
    'SeinField',
    'New Amsterdam',
    'Jujutsu Kaisen',
    'Naruto Shippuden',
    'Chainsaw Man',
    "Fairy Tail",
    "Two and a Half Men",
    "Brooklyn Nine Nine",
    'Too Hot to Handle',
    'One Punch Man',
    'Uri',
    'Breaking Bad',
    'Narcos',
    'Delhi Crime',
    'GodFather Season-1',
    'A Man Called OTTO',
    'Sex Education',
    'Mission Majnu',
    'Raees',
    'Raw(Beast)',
    'The Railway Men',
  };
  bool noResultsFound = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              color: Colors.grey.shade600,
              child: TextField(
                controller: _searchController,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    noResultsFound = false;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search,color: Colors.white,),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _listen();
                    },
                    icon: Icon(
                        _isListening?Icons.mic:Icons.mic_off, color: Colors.white),
                  ),
                  hintText: "Search for movies, shows, series....",
                  hintStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
                ),
              ),
            ),
          ),
          if (_recentSearches.isEmpty)
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Recent Searches:",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "No Recent Searches Till Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 50,
                  indent: 50,
                  thickness:0.4,
                ),
              ],
            ),

          if (_recentSearches.isNotEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      "  Recent Searches:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(onPressed: (){
                      _clearMessages(context);
                    },
                      child:Text(
                        "Clear Searches",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),)
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Wrap(
                  spacing: 10.0,
                  children: _recentSearches.map((search) {
                    return GestureDetector(

                      onTap: () {
                        // Navigate to the corresponding page based on the selected search
                        navigateToPage(context, search);
                      },
                      child: Chip(
                        label: Text(search, style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w400)),
                        backgroundColor: Colors.black,
                        autofocus: true,
                        surfaceTintColor: Colors.black,
                        side: BorderSide(color: Colors.grey),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 50,
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 50,
                  indent: 50,
                  thickness:0.4,
                ),
              ],
              
            ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final result = searchResults.elementAt(index);
                if (result.toLowerCase().contains(searchQuery.toLowerCase())) {
                  return ListTile(
                    title: Text(result, style: TextStyle(color: Colors.white)),
                    onTap: () {
                      // Navigate to the corresponding page based on the result
                      navigateToPage(context, result);
                    },
                  );
                }
                return Container(); // Return an empty container if not matching the query.
              },
            ),
          ),
          if (noResultsFound)
            Center(
              child: Text(
                "No Results Found",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void navigateToPage(BuildContext context, String result) {
    // Implement navigation logic based on the result
    // Replace the following lines with your actual navigation logic
    if (!searchResults.contains(result)) {
      searchResults.add(result); // Add the result to uniqueSearchResults
      _saveSearchQuery(result); // Save the search query
    }
    switch (result) {
      case "Peaky Blinders-Season I":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Peaky()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Raees":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Raees()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Raw(Beast)":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Raw_Beast()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "The Railway Men":
    Navigator.push(
    context, MaterialPageRoute(builder: (context) => The_railway_men()));
    _saveSearchQuery(result);
    _searchController.clear();
    break;
        case 'Uri':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Uri_movie()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case 'GodFather Season-1':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Godfather_s1()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Lincoln Lawyer":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Lincoln()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "Sex Education":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SexEducation()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "A Man Called OTTO":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => otto()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Mission Majnu":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Mission_majnu()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "Delhi Crime":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => delhi_crime()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "Two and a Half Men":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => twoandahalf()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case "Narcos":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Narcos()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "GodFather(Hindi)":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Godfather()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Brand New Cherry Flavour":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => cherry()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Fairy Tail":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Fairytail()));
        _saveSearchQuery(result);
        break;
      case "New Amsterdam":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Amsterdam()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case 'Naruto Shippuden':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Naruto()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Two and a half Men":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => twoandahalf()));
        _saveSearchQuery(result);
        break;
        case "Brooklyn Nine Nine":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => brooklyn_main()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case 'Too Hot to Handle':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => hot()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case 'One Punch Man':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Onepunch()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Extraction-I":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Extraction()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Extraction-II":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Extraction()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Johnny English Reborn":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Johny()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
        case 'Breaking Bad':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Breaking_bad()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case 'Jujutsu Kaisen':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Jujutsu()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case 'Chainsaw Man':
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Chainsaw()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "SeinField":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SeinField()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Too Hot To Handle":
        Navigator.push(context, MaterialPageRoute(builder: (context) => hot()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Brooklyn Nine-Nine":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => brooklyn_main()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Demon Slayer":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => demon()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Stranger Things":
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Stranger()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
      case "Red Notice":
        Navigator.push(context, MaterialPageRoute(builder: (context) => red()));
        _saveSearchQuery(result);
        _searchController.clear();
        break;
    }
  }
}