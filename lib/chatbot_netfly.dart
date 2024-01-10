import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:netflix/report_page.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  stt.SpeechToText? _speech;
  late User? _user;
  bool isDarkMode = false;
  Icon currentIcon = Icon(Icons.sunny);
  bool isBotTyping = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
      currentIcon = isDarkMode ? Icon(Icons.sunny) : Icon(Icons.nightlight);
    });
  }
  bool _isListening = false;
  ChatScreenState() {
    _speech = stt.SpeechToText();
  }
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    getUserEmail();
    fetchTime();
    fetchusername();
    _user = _auth.currentUser;
    if (_user == null) {
      // Implement user authentication logic here, e.g., sign in or sign up
      // You can use Firebase Authentication to identify users.
    }
    if (_user != null) {
      _loadChatHistory();
    }
  }
  void _listen() async {
    if (!_isListening) {
      if (await _speech!.initialize()) {
        _speech!.listen(
          onResult: (result) {
            setState(() {
              searchQuery = result.recognizedWords;
              _textController.text = searchQuery;
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
  String? userEmail;
  Future<void> getUserEmail() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        setState(() {
          userEmail = user.email;
        });
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print("Error getting user email: $e");
    }
  }

  Future<void> _loadChatHistory() async {
    FirebaseFirestore.instance
        .collection('chat_history')
        .doc(_user!.uid)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      _messages.clear();
      for (var messageDoc in querySnapshot.docs) {
        _messages.add(ChatMessage(
          text: messageDoc['text'],
          isUser: messageDoc['isUser'],
        ));
      }
      setState(() {});
    });
  }
  String user_name='';
  String usertime='';
  Future<void> fetchusername() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('Clients').doc(user.uid).get();

        if (snapshot.exists) {
          setState(() {
            user_name = snapshot.data()?['username'] ?? '';
          });
        } else {
          print('Document does not exist.');
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print('Error retrieving password: $e');
    }
  }
  Future<void> fetchTime() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (snapshot.exists) {
          setState(() {
            // Ensure the 'time_of_start' field is a valid timestamp in Firestore
            Timestamp timestamp = snapshot.data()?['time_of_start'] ?? Timestamp.now();
            usertime = timestamp.toDate().toString(); // Convert Firestore timestamp to DateTime
          });
        } else {
          print('Document does not exist.');
        }
      } else {
        print("No user is currently signed in.");
      }
    } catch (e) {
      print('Error retrieving timestamp: $e');
    }
  }
  IconButton? _clearIcon;
  void clearoption(){
    if(_textController.text.isNotEmpty){
      setState(() {
        _clearIcon=IconButton(onPressed: (){
          _textController.clear();
        },
            icon:Icon(Icons.clear));
      });
    }else{
      _clearIcon=null;
    }
  }
  void _handleSubmitted(String text) {
    if (text.isNotEmpty) {
      _textController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        isUser: true,
      );
      setState(() {
        _messages.insert(0, message);
        isBotTyping = true;
      });

      _saveMessageToFirestore(text, true);
      _handleBotResponse(text);
    }
  }

  Future<void> _handleBotResponse(String userMessage) async {
    String userMessageLower = userMessage.toLowerCase();
    String botResponse='';
    Future<void> _clearMessages() async {
      setState(() async {
        // Clear the local _messages list
        _messages.clear();

        // Access the Firestore collection
        CollectionReference messagesCollection = FirebaseFirestore.instance.collection('chat_history').doc(_user!.uid).collection('messages');

        // Get a reference to all documents in the collection
        QuerySnapshot querySnapshot = await messagesCollection.get();

        // Iterate through the documents and delete them
        for (QueryDocumentSnapshot doc in querySnapshot.docs) {
          await doc.reference.delete();
        }
      });
    }



    // Simulate bot "typing" for 1.5 seconds.
    await Future.delayed(Duration(milliseconds: 1500));

    if (userMessageLower.contains('hi') ||
        userMessageLower.contains('hello') ||
        userMessageLower.contains('hey')) {
      botResponse = "Hello! Welcome to NetFly.";
    } else if (userMessageLower.contains('help') ||
        userMessageLower.contains('help needed') ||
        userMessageLower.contains('i need help')) {
      botResponse = 'How can I assist you today?\nIm here to help with various topics, including:\n'
          '➡ Movie-related questions\n'
          '➡ Password Reset\n'
          '➡ Account Recovery\n'
          '➡ Billing and Payment\n'
          '➡ Technical Issues';
    } else if (userMessageLower.contains('movie') ||
        userMessageLower.contains('movies') ||
        userMessageLower.contains('Movie')) {
      botResponse = 'What specific movie-related assistance do you require?';
    } else if (userMessageLower.contains('password reset') ||
        userMessageLower.contains('forgot password')) {
      botResponse = 'To reset your password, follow these steps:\n'
          '1. Visit the login page\n'
          '2. Click on "Forgot Password"\n'
          '3. Follow the instructions sent to your email';
    } else if (userMessageLower.contains('account recovery') ||
        userMessageLower.contains('recover account')) {
      botResponse = 'For account recovery, please follow these steps:\n'
          '1. Contact our support team at support@netfly.com\n'
          '2. Provide the necessary information for identity verification';
    } else if (userMessageLower.contains('start over') ||
        userMessageLower.contains('start over ') ||
        userMessageLower.contains('delete conversations')) {
      _clearMessages();
      botResponse = '👋';
    } else if (userMessageLower.contains('recommend a movie') ||
        userMessageLower.contains('movie suggestions') ||
        userMessageLower.contains('what to watch')) {
      botResponse = 'Certainly, I can recommend a movie for you.\nCan you specify your preferred genre\n(e.g., action, comedy, drama)?';
    } else if (userMessageLower.contains('action')) {
      botResponse = 'Here are some top action movies:\n'
          '1. Peaky Blinders\n'
          '2. Narcos\n'
          '3. Breaking Bad\n'
          'More you can\nfind on homepage\nunder action tab';
    } else if (userMessageLower.contains('comedy')) {
      botResponse = 'Here are some top comedy movies:\n'
          '1. Old Dates\n'
          '2. No Hard Feelings\n'
          '3. Salt Burn\n'
          'More you can\nfind on homepage\nunder comedy tab';
    } else if (userMessageLower.contains('drama')) {
      botResponse = 'Here are some top drama movies:\n'
          '1. Breaking Bad\n'
          '2. Narcos\n'
          '3. Big Bang Theory\n'
          'More you can\nfind on homepage';
    }else if (userMessageLower.contains('romance')) {
      botResponse = 'Here are some top drama movies:\n'
          '1. Titanic\n'
          '2. HoliDate\n'
          '3. 2 Hearts\n'
          'More you can\nfind on homepage\nunder romance tab';
    }
    else if (userMessageLower.contains('contact customer care') ||
        userMessageLower.contains('customer support') ||
        userMessageLower.contains('phone number')) {
      botResponse = 'You can reach our customer care at 8335856470\nPhone Number for further assistance.\n'
          'Also, you can email us at biswayanmazumder27@gmail.com';
    } else if (userMessageLower.contains('billing') ||
        userMessageLower.contains('payment') ||
        userMessageLower.contains('subscription')) {
      botResponse = 'For billing and payment-related questions,\nplease visit our billing and payment page on our website.';
    } else if (userMessageLower.contains('technical issues') ||
        userMessageLower.contains('bugs') ||
        userMessageLower.contains('errors')) {
      botResponse = 'If youre facing technical issues with the app,\nplease contact our support team at\nsupport@netfly.com.\nTheyll assist you in resolving any problems.';
    }else if (userMessageLower.contains('report an issue') ||
        userMessageLower.contains('report a bug') ||
        userMessageLower.contains('report movie or app error')) {
      botResponse = 'Sure ${user_name}\nRe-directing you to report page';
      Future.delayed(Duration(seconds:5), () {
        // Delay for a short period before navigating
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Report()),
        );
      });
    }
    else if (userMessageLower.contains('change password') ||
        userMessageLower.contains('update password') ||
        userMessageLower.contains('reset password')) {
      botResponse = 'Please click on the link sent\nto your email to reset password';
      final user=_auth.currentUser;
      if(user!=null){
        try{
          await _auth.sendPasswordResetEmail(email: userEmail.toString());
          botResponse = 'Please click on the link sent\nto your email to reset password\nSuccessfully sent email\nto reset password to\n${userEmail}';
        }catch(e){
          botResponse='Error Sending email to\m${userEmail}';
        }
      }
    }
    else if (userMessageLower.contains('Send verification email') ||
        userMessageLower.contains('verify me')) {

      if(_user!.emailVerified){
        botResponse = 'Sorry your email\n${_user?.email}\nis already verified.';
      }else{
        botResponse = 'Right way sending you verification email.\nPlease check your email\n${_user?.email}';
        _user?.sendEmailVerification();
      }
    }
    else if (userMessageLower.contains('what is my registered email') ||
        userMessageLower.contains('about me') ||
        userMessageLower.contains('information about me')) {
      botResponse = 'Email you are currently logged in is:\n${userEmail}\n'
          'Your User-Name is:\n${user_name}\n'
          'Your Membership Started on:\n${usertime.toString().split(' ')[0]},\n'
          'Is your email verified?\n'
          '${_user?.emailVerified}\n';
    } else {
      botResponse = "I'm sorry, I didn't quite catch that.\nCan you please rephrase your question?";
    }

    // Add more responses here...

    // Simulate bot "typing" for 1.5 seconds.
    await Future.delayed(Duration(milliseconds: 1500));

    ChatMessage message = ChatMessage(
      text: botResponse,
      isUser: false,
    );
    setState(() {
      _messages.insert(0, message);
      isBotTyping = false;
    });

    _saveMessageToFirestore(botResponse, false);
  }

  void _saveMessageToFirestore(String message, bool isUser) {
    if (_user != null) {
      FirebaseFirestore.instance
          .collection('chat_history')
          .doc(_user!.uid)
          .collection('messages')
          .add({
        'text': message,
        'isUser': isUser,
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: currentIcon,
            onPressed: toggleTheme,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: Container(
        color: isDarkMode ? Colors.black : Colors.white,
        child: Column(
          children: <Widget>[
            //Image.network('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/653ca32534ea3112c5ab/view?project=64e0600003aac5802fbc&mode=admin',height: 10,width: 10,),
            Flexible(
              child: ListView.builder(
                padding: EdgeInsets.all(8.0),
                reverse: true,
                itemBuilder: (_, int index) {
                  // Check if it's the bot's turn to type and add a typing indicator.
                  if (isBotTyping && index == _messages.length) {
                    return TypingIndicator();
                  }
                  return _messages[index];
                },
                itemCount: _messages.length + (isBotTyping ? 1 : 0),
              ),
            ),
            Divider(height: 1.0),
            Container(
              decoration: BoxDecoration(
                color: isDarkMode ? Colors.black : Colors.white,
              ),
              child: _buildTextComposer(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Colors.blue
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: 'What help you needed',
                    hintStyle: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                  ),
                  style: TextStyle(color: isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
            IconButton(onPressed: (){
              _textController.clear();
            }, icon: Icon(Icons.clear_rounded,color: Colors.red,)),
            IconButton(onPressed: (){
              _listen();
            },
                icon:Icon(_isListening?Icons.mic:Icons.mic_off,color: Colors.red,)),
            IconButton(
              icon: Icon(Icons.send,color: Colors.red,),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: isUser ? Colors.yellowAccent : Colors.greenAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(seconds: 1),
              child: Text(
                text,
                style: TextStyle(color: isUser ? Colors.black : Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TypingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                  height: 10,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  "Typing...",
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
