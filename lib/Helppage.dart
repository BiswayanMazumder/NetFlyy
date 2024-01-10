import 'dart:io';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isDark = false;
  bool _isreplies = false;
  String? selectedCommentId;
  String? selectedCommentIds;
  bool issaved=false;
  User? user = FirebaseAuth.instance.currentUser;
  String? username;
  stt.SpeechToText? _speech;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _questions = TextEditingController();
  TextEditingController _answerController = TextEditingController();
  File? _selectedImage;
  bool isLoading = true;
  TextEditingController _editedquestion=TextEditingController();
  bool _isListening = false;
  ChatScreenState() {
    _speech = stt.SpeechToText();
  }
  _HelpPageState() {
    _speech = stt.SpeechToText();
  }
  @override
  void initState() {
    super.initState();
    fetchusername();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Set loading indicator to false once initialization is done
      });
    });
  }
  String getDisplayTimestamp(Map<String, dynamic> commentData) {
    if (commentData.containsKey('editedTimestamp')) {
      // Display edited timestamp
      return 'Edited ✎';
    } else if (commentData['timestamp'] != null) {
      // Display original timestamp
      return 'Asked on ${commentData['timestamp'].toDate().toString().split(' ')[0]}';
    }
    return ''; // Return an empty string or some default value if timestamp is not available
  }

  Future<void> fetchusername() async {
    final user = _auth.currentUser;
    final docsnap =
    await _firestore.collection('Clients').doc(user!.uid).get();
    if (docsnap.exists) {
      setState(() {
        username = docsnap.data()?['username'];
      });
    }
  }

  final CollectionReference commentsCollection =
  FirebaseFirestore.instance.collection('doubts');


  String searchQuery = "";
  final FlutterTts _flutterTts = FlutterTts();
  void _listen() async {
    if (!_isListening) {
      if (await _speech!.initialize()) {
        _speech!.listen(
          onResult: (result) {
            if (result.recognizedWords.isNotEmpty) {
              setState(() {
                _questions.text = result.recognizedWords;
              });

              // Save speech result to Firestore
              saveSpeechToFirestore(result.recognizedWords);
            }
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


  void saveSpeechToFirestore(String speechText) async {
    try {
      await _firestore.collection('help forum speeches').add({
        'text': speechText,
        'uid':user!.uid,
        'user name':username,
        'email':user!.email,
        'timestamp': FieldValue.serverTimestamp(),
      });

      // If you want to use Text-to-Speech to confirm that the speech was saved,
      // you can uncomment the following line
      // _flutterTts.speak('Speech saved successfully');
    } catch (e) {
      print('Error saving speech to Firestore: $e');
      // Handle error
    }
  }
  void reportComment(String commentId, String reportReason) async {
    try {
      // Increment the report count for the commentId or create a new document if it doesn't exist
      await _firestore.collection('CommentReports').doc(commentId).set({
        'Number Of people reported': FieldValue.increment(1),
        // 'time of reporting': FieldValue.arrayUnion([FieldValue.serverTimestamp()]),
        'Comment ID':commentId,
        'user id of reported comments': FieldValue.arrayUnion([user!.uid]),
        'email id of reported comments':FieldValue.arrayUnion([user!.email]),
        'reportReasons': FieldValue.arrayUnion([reportReason]), // Add reportReason to the array
      }, SetOptions(merge: true));

      // Retrieve the updated report data
      DocumentSnapshot reportDoc =
      await _firestore.collection('CommentReports').doc(commentId).get();

      // Cast data to Map<String, dynamic> to avoid '[]' operator error
      Map<String, dynamic>? data = reportDoc.data() as Map<String, dynamic>?;

      // Access the 'reportCount' field and 'reportReasons' array safely
      int reportCount = data?['reportCount'] ?? 0;
      List<String>? reportReasons = List.from(data?['reportReasons'] ?? []);

      // Show a SnackBar with the report count and reasons
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Report submitted successfully.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print('Error reporting comment: $e');
      // Handle error
    }
  }


// Add an AlertDialog for selecting report reason
  void _showReportDialog(String commentId) {
    List<String> selectedReasons = []; // Store the selected reasons

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Please select the appropriate Report Reasons'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Example reasons, you can customize this list based on your needs
                  CheckboxListTile(
                    title: Text('Inappropriate Content'),
                    value: selectedReasons.contains('Inappropriate Content'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Inappropriate Content', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Spam'),
                    value: selectedReasons.contains('Spam'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Spam', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Nudity'),
                    value: selectedReasons.contains('Nudity'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Nudity', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Sexual Content'),
                    value: selectedReasons.contains('Sexual Content'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Sexual Content', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Hate or Abusive Content'),
                    value: selectedReasons.contains('Hate or Abusive Content'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Hate or Abusive Content', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('harmful or dangerous acts'),
                    value: selectedReasons.contains('Harmful or dangerous acts'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Harmful or dangerous acts', value, selectedReasons);
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text('Violent or repulsive'),
                    value: selectedReasons.contains('Violent or repulsive'),
                    onChanged: (bool? value) {
                      setState(() {
                        _updateSelectedReasons('Violent or repulsive', value, selectedReasons);
                      });
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (selectedReasons.isNotEmpty) {
                      // Call the reportComment function with the selected reasons
                      reportComment(commentId, selectedReasons.join(', '));
                      Navigator.pop(context); // Close the dialog after reporting
                    } else {
                      // Handle case where no reason is selected
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select at least one report reason'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: Text('Report'),
                ),
              ],
            );
          },
        );
      },
    );
  }

// Function to update selected reasons list
  void _updateSelectedReasons(String reason, bool? value, List<String> selectedReasons) {
    if (value!) {
      selectedReasons.add(reason); // Select the reason
    } else {
      selectedReasons.remove(reason); // Unselect the reason
    }
  }

// ... (existing code)

  bool isCurrentUserOwner(Map<String, dynamic> commentData) {
    // Add your logic to determine if the current user is the owner
    return commentData['userId'] == FirebaseAuth.instance.currentUser?.uid;
  }

  void submitComment() async {
    String commentText = _questions.text;
    if (commentText.isNotEmpty) {
      String imageUrl = await uploadImage();

      Map<String, dynamic> commentData = {
        'commentText': commentText,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'username': username,
        'email': user!.email,
      };

      if (imageUrl.isNotEmpty) {
        commentData['imageUrl'] = imageUrl;
      }

      if (selectedCommentIds == null) {
        // Add new comment
        commentsCollection.add(commentData);
      } else {
        // Edit existing comment only if the current user is the owner
        if (isCurrentUserOwner(commentData)) {
          commentData['editedTimestamp'] = FieldValue.serverTimestamp();
          commentsCollection.doc(selectedCommentIds!).update(commentData);
          setState(() {
            selectedCommentIds = null;
          });
        } else {
          // Handle the case where the user is not the owner
          // You may want to show a message or handle it in a way suitable for your app
        }
      }

      _questions.clear();
      _clearImage(); // Clear selected image after uploading
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please type your doubt, $username'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
  void deleteComment(DocumentReference commentReference) {
    commentReference.delete().then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Succesfully deleted discussion'),
          backgroundColor: Colors.green,
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error deleting discussion'),
          backgroundColor: Colors.red,
        ),
      );
    });
  }
  String result = '';

  Future<void> checkGrammar() async {
    final url = 'https://grammarbot-neural.p.rapidapi.com/v1/check';
    final headers = {
      'content-type': 'application/json',
      'X-RapidAPI-Key': '6992fa44c5msh33494370d8be396p1025d7jsnf75644f6e3ff',
      'X-RapidAPI-Host': 'grammarbot-neural.p.rapidapi.com',
    };

    final data = {
      'text':'This are some wel-written text.', // Use the text from the TextField
      'lang': 'en',
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          result = jsonResponse.toString();
        });
      } else {
        setState(() {
          result = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (error) {
      setState(() {
        result = 'Erro: $error';
      });
    }
  }
  void submitAnswer(String commentId, Map<String, dynamic> commentData) {
    String answerText = _answerController.text;
    if (answerText.isNotEmpty) {
      List<String> existingAnswers =
      List<String>.from(commentData['answers'] ?? []);

      existingAnswers.add(answerText);

      commentsCollection.doc(commentId).update({
        'answers': existingAnswers,
      });
      _answerController.clear();
    }
  }

  Future<String> uploadImage() async {
    if (_selectedImage == null) {
      return ''; // No image selected
    }

    try {
      final Reference storageReference = _storage
          .ref()
          .child('helpforumimages/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(_selectedImage!);
      await uploadTask.whenComplete(() => null);
      return await storageReference.getDownloadURL();
    } catch (error) {
      print('Error uploading image: $error');
      return '';
    }
  }

  void _pickImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _clearImage() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDark = !isDark;
              });
            },
            icon: Icon(
              isDark ? Icons.sunny : Icons.nights_stay_rounded,
              color: Colors.white,
            ),
          )
        ],
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
                height: 30,
              ),
              Center(
                child: Text(
                  'Need more help.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Or having new ideas?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Text(
                  'Welcome To Help Forum.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.black : Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Welcome ${username}',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        color: isDark ? Colors.black : Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  if (user!.emailVerified)
                    Image(
                      image: NetworkImage(
                        'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/656e14a775bd67ca290d/view?project=64e0600003aac5802fbc&mode=admin',
                      ),
                      height: 30,
                      width: 30,
                    ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: isDark ? Colors.black : Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(80),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: _questions,
                      maxLength: 100,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        counterText: '',
                        prefixIcon: IconButton(
                          onPressed: () {
                            _listen();
                          },
                          icon: Icon(
                            _isListening ? Icons.mic : Icons.mic_off,
                            color: Colors.black,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: _pickImage,
                          icon: Icon(Icons.image, color: Colors.black),
                        ),
                        hintText:
                        'Type a question, topic, or issue and post it',
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    // ElevatedButton(
                    //   onPressed: _generateApiResponse,
                    //   child: Text('Generate API Response'),
                    // ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              AvatarGlow(
                glowColor: Colors.red.shade600,
                animate: true,
                endRadius: 75.0,
                showTwoGlows: true,
                shape: BoxShape.rectangle,
                repeat: true,
                curve: Curves.bounceInOut,
                child: Material(
                  color: isDark ? Colors.white : Colors.black,
                  child: ElevatedButton(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor:
                            isDark ? Colors.white : Colors.black,
                            title: Text(
                              selectedCommentIds != null
                                  ? 'Edit Comment'
                                  : 'Start discussion',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: isDark ? Colors.black : Colors.white),
                            ),
                          );
                        },
                      );
                    },
                    onPressed: submitComment,
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    child: Text(selectedCommentIds != null
                        ? 'Edit Comment'
                        : 'Start discussion'),
                  ),
                ),
              ),
              if (_selectedImage != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(
                      _selectedImage!,
                      height: 100,
                      width: 100,
                    ),
                    IconButton(
                      onPressed: _clearImage,
                      icon: Icon(
                        Icons.close,
                        color: isDark ? Colors.black : Colors.white,
                        size: 19,
                      ),
                    ),
                  ],
                ),
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
                        bool isOwner =
                        isCurrentUserOwner(commentData);
                        bool canAnswer = true;

                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 150.0,
                                    child: Text(
                                      commentData['commentText'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  if (canAnswer)
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title:
                                              Text('Answer the Question'),
                                              content: IntrinsicWidth(
                                                child: TextField(
                                                  controller:
                                                  _answerController,
                                                  decoration: InputDecoration(
                                                    hintText:
                                                    'Type your answer here',
                                                  ),
                                                  maxLines: 5,
                                                ),
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    submitAnswer(
                                                        comment.id,
                                                        commentData);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Submit'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon: Icon(
                                        Icons.question_answer_outlined,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                        size: 19,
                                      ),
                                    ),
                                  if (!isOwner)
                                    IconButton(
                                        onPressed: () {
                                          _showReportDialog(
                                              comment.id);
                                        },
                                        icon: Icon(
                                          Icons.report_problem_outlined,
                                          color: isDark
                                              ? Colors.black
                                              : Colors.white,
                                          size: 19,
                                        )),
                                  if (isOwner)
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (selectedCommentIds ==
                                              null) {
                                            // Start editing
                                            _editedquestion.text =
                                            commentData[
                                            'commentText'];
                                            selectedCommentIds =
                                                comment.id;
                                          } else {
                                            // Cancel editing
                                            _editedquestion.text =
                                            '';
                                            selectedCommentIds =
                                            null;
                                          }
                                        });
                                      },
                                      icon: Icon(
                                        selectedCommentIds != null
                                            ? Icons.cancel
                                            : Icons.edit,
                                        size: 19,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  if (isOwner)
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: 19,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                      onPressed: () => deleteComment(
                                          comment.reference),
                                    ),
                                ],
                              ),
                              subtitle: Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      getDisplayTimestamp(
                                          commentData),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            if (commentData['imageUrl'] != null)
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(
                                    height: 350,
                                    width: 350,
                                    child: InstaImageViewer(
                                      child: Image.network(
                                        commentData['imageUrl'],
                                        height: 500,
                                        width: 500,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            if (commentData['imageUrl'] == null)
                              Container(),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isreplies = !_isreplies;
                                    selectedCommentId = _isreplies
                                        ? comment.id
                                        : null;
                                  });
                                },
                                child: Text(
                                  _isreplies
                                      ? 'hide replies'
                                      : 'show replies',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: isDark
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            if (_isreplies &&
                                selectedCommentId ==
                                    comment.id)
                              if (commentData['answers'] == null ||
                                  commentData['answers'].isEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Text(
                                      'Be the first one to reply',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: isDark
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                            if (_isreplies &&
                                selectedCommentId ==
                                    comment.id)
                              if (commentData
                                  .containsKey('answers'))
                                ...List.generate(
                                  commentData['answers'].length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Align(
                                        alignment:
                                        Alignment.centerLeft,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'NetFly User ${index + 1}',
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color: isDark
                                                            ? Colors.black
                                                            : Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Image(
                                                      image: NetworkImage(
                                                          'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/656e14a775bd67ca290d/view?project=64e0600003aac5802fbc&mode=admin'),
                                                      height: 20,
                                                      width: 20,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 15),
                                            Column(
                                              children: [
                                                if (commentData['answers'][index]
                                                    .contains('http'))
                                                  Image.network(
                                                    commentData['answers'][index],
                                                    height: 100,
                                                    width: 100,
                                                  )
                                                else
                                                  Text(
                                                    '${commentData['answers'][index]}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                      FontWeight.w300,
                                                      color: isDark
                                                          ? Colors.black
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                          ],
                        );
                      }).toList(),
                    );
                  }
                  return Text('No comments yet.');
                },
              ),
              SizedBox(
                width: 50,
              ),
            ],
          ),
        ),
      ),
    );

  }
}

void main() {
  runApp(
    MaterialApp(
      home: HelpPage(),
    ),
  );
}
