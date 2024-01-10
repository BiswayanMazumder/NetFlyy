import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:netflix/Helppage.dart';
import 'package:velocity_x/velocity_x.dart';
class Ban extends StatefulWidget {
  const Ban({Key? key}) : super(key: key);

  @override
  State<Ban> createState() => _BanState();
}

class _BanState extends State<Ban> {
  bool isDark=false;
  String reporttype='';
  late String unbantime='';
  late String formattedDateTime='';
  late String formattedDateTimes='';
  late String formattedDatetimes='';
  String imageurl='';
  String commentid='';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String reporting='';
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchreporttype();
    fetchTimestamp();
    fetchcommentid();
    fetchreport();
    fetchTimestamps();
    fetchAndUploadDateTime();
    fetchAndUploadUnbanTime();
    fetchimageurl();
    fetchUnbanningTime();
    fetchunbantime();
  }
  Future<void> fetchcommentid() async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Help Forum T&C').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        commentid=docsnap.data()?['reported comment ID'];
      });
    }
    print(commentid);
  }
  Future<void> fetchimageurl() async{
    await fetchcommentid();
    final docsnaps=await _firestore.collection('doubts').doc(commentid).get();
    if(docsnaps.exists){
      setState(() {
        imageurl=docsnaps.data()?['imageUrl'];
      });
    }
    print(imageurl);
  }
  Future<void> fetchreport() async{
    await fetchcommentid();
    final user=_auth.currentUser;
    final docsnaps=await _firestore.collection('doubts').doc(commentid).get();
    if(docsnaps.exists){
      setState(() {
        reporting=docsnaps.data()?['commentText'];
      });
    }
    print(reporting);
  }
  Future<void> fetchunbantime() async {
    final user = _auth.currentUser;
    if (user != null) {
      final docRef = _firestore.collection('Help Forum T&C').doc(user.uid);
      final docsnap = await docRef.get();
      if (docsnap.exists) {
        Timestamp timestamps = docsnap.data()?['Time Of Unban'];
        DateTime originaldatetimes = timestamps.toDate();
        unbantime = DateFormat('yyyy-MM-dd h:mm:s a').format(originaldatetimes);
        print('unban time: $unbantime');

        // Check if unban time is the same as the current time or if current time has passed unban time
        DateTime unbannedDateTime = originaldatetimes;
        DateTime currentDateTime = DateTime.now();

        if (currentDateTime.isAtSameMomentAs(unbannedDateTime) || currentDateTime.isAfter(unbannedDateTime)) {
          // Update Firestore
          await docRef.update({
            'haveaccess': true,
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>HelpPage()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You have been successfully unbanned'),
              backgroundColor: Colors.green,
            ),
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: isDark ? Colors.black : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                  children: [
                    TextSpan(
                      text: 'Sorry! You will be able to use forum again after\n',
                    ),
                    TextSpan(
                      text: unbanningTime != null
                          ? DateFormat('d MMMM y h:mm:s a').format(unbanningTime!)
                          : 'Loading...',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
  Future<void> fetchAndUploadDateTime() async {
    final user = _auth.currentUser;
    await fetchcommentid();

    if (user != null) {
      try {
        final docSnap = await _firestore.collection('doubts').doc(commentid).get();

        if (docSnap.exists) {
          setState(() {
            // Check if 'timestamp' field is present and not null in the document
            if (docSnap.data()?['timestamp'] != null) {
              Timestamp timestamps = docSnap.data()?['timestamp'];

              // Convert timestamp to DateTime
              DateTime originalDateTime = timestamps.toDate();

              // Format the original timestamp in 'yyyy-MM-dd h:mm:s a' format
              formattedDatetimes = DateFormat('h:mm:s a').format(originalDateTime);

              // Calculate new date and time one week later

            }
          });
        } else {
          print('Document does not exist in Firestore for commentid: $commentid');
        }
      } catch (e) {
        print('Error fetching and uploading timestamp: $e');
        // Handle errors as needed
      }
    }
  }
  late String unbantimes='';
  DateTime? unbanningTime;
  Future<void> fetchUnbanningTime() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnap = await _firestore.collection('Help Forum T&C').doc(user.uid).get();
        if (docSnap.exists) {
          setState(() {
            // Fetch the unbanning time
            unbanningTime = docSnap.data()?['Time Of Unban'].toDate();
          });
        }
      } catch (e) {
        print('Error fetching unbanning time: $e');
        // Handle errors as needed
      }
    }
  }
  Future<void> fetchAndUploadUnbanTime() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final docSnap = await _firestore.collection('Help Forum T&C').doc(user.uid).get();
        if (docSnap.exists) {
          setState(() {
            // Fetch the current unbanning time
            DateTime unbanTime = docSnap.data()?['Time of suspending'].toDate();

            // Add 7 days to the current unbanning time
            DateTime newUnbanTime = unbanTime.add(Duration(days: 7));

            // Format the new unbanning time in 'yyyy-MM-dd h:mm:s a' format
            String formattedNewUnbanTime = DateFormat('yyyy-MM-dd h:mm:s a').format(newUnbanTime);

            // Update the new unbanning time to Firestore
            _firestore.collection('Help Forum T&C').doc(user.uid).update({
              'Time Of Unban': newUnbanTime,
            });

            // Print original and new unbanning times to debug console
            print('Original Unban Time: $unbanTime');
            print('New Unban Time (7 days later): $formattedNewUnbanTime');
          });
        }
      } catch (e) {
        print('Error fetching/unbanning time: $e');
        // Handle errors as needed
      }
    }
  }


  Future<void> fetchTimestamps() async {
    final user = _auth.currentUser;
    await fetchcommentid();

    if (user != null) {
      try {
        final docSnap = await _firestore.collection('doubts').doc(commentid).get();

        if (docSnap.exists) {
          setState(() {
            Timestamp timestamps = docSnap.data()?['timestamp'];

            // Convert timestamp to DateTime
            DateTime dateTime = timestamps.toDate();
            formattedDateTimes = DateFormat('MMMM d, y').format(dateTime);

            // Print timestamp to debug console
            print('Timestamp from Firestore: $formattedDateTimes');

          });
        }
      } catch (e) {
        print('Error fetching timestamp: $e');
        // Handle errors as needed
      }
    }
  }
  Future<void> fetchTimestamp() async {
    final user = _auth.currentUser;

    if (user != null) {
      try {
        final docSnap = await _firestore.collection('Help Forum T&C').doc(user.uid).get();

        if (docSnap.exists) {
          setState(() {
            Timestamp timestamp = docSnap.data()?['Time of suspending'];

            // Convert timestamp to DateTime
            DateTime dateTime = timestamp.toDate();
            formattedDateTime = DateFormat('MMMM d, y').format(dateTime);

            // Print timestamp to debug console
            print('Timestamp from Firestore: $formattedDateTime');
          });
        }
      } catch (e) {
        print('Error fetching timestamp: $e');
        // Handle errors as needed
      }
    }
  }
  bool _showguidelines=false;
  Future<void> fetchreporttype() async{
    final user=_auth.currentUser;
    final docsnap=await _firestore.collection('Help Forum T&C').doc(user!.uid).get();
    if(docsnap.exists){
      setState(() {
        reporttype=docsnap.data()?['ban reason'];
      });
    }
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
              // Toggle between light and dark mode
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
                height: 50,
              ),
              Image(image: NetworkImage('https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/6571db041e98c191330c/view?project=64e0600003aac5802fbc&mode=admin')),
              SizedBox(
                height: 20,
              ),
              Text("We suspended your account",style: TextStyle(color: isDark?Colors.black:Colors.white,fontSize: 25,fontWeight: FontWeight.w400),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("to access NetFly forum on",style: TextStyle(color: isDark?Colors.black:Colors.white,fontSize: 25,fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${formattedDateTime}",style: TextStyle(color: isDark?Colors.black:Colors.white,fontSize: 25,fontWeight: FontWeight.w400),),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Text('Your question asked in help forum went against our community guidelines on ${reporttype}.'
                  'If you learn and follow our guidelines you can still report us, in case you feel it is our mistake.'
                  'But the final decision always depend on us.',style: TextStyle(
                color: isDark?Colors.black:Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20
              ),),
              SizedBox(
                height: 50,
              ),
              Divider(
                color:isDark?Colors.black:Colors.white,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 30,
              ),
              Text('What does that mean?',style: TextStyle(
                  color: isDark?Colors.black:Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              ),),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.report_problem_outlined,color: isDark?Colors.black:Colors.white,),
                  SizedBox(width: 15,),
                  Text('Your account has been found violating\nour guidelines',style: TextStyle(
                      color: isDark?Colors.black:Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15
                  ),),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.lock_outline,color: isDark?Colors.black:Colors.white,),
                  SizedBox(width: 15,),
                  Text('Your account is visible to everyone\nalso you can use NetFly\n also your topics are visible\nbut you cannot use our forum.',style: TextStyle(
                      color: isDark?Colors.black:Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 15
                  ),),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.info_outline,color: isDark?Colors.black:Colors.white,),
                  SizedBox(width: 15,),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: isDark ? Colors.black : Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                      children: [
                        TextSpan(
                          text: 'You will be able to use\n your account again after\n',
                        ),
                        TextSpan(
                          text: unbanningTime != null
                              ? DateFormat('d-MMMM-y h:mm:s a').format(unbanningTime!)
                              : 'Loading...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(
                height: 30,
              ),

              Divider(
                color: isDark?Colors.black:Colors.white,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Reported Forum chat',style: TextStyle(fontWeight: FontWeight.bold, color: isDark?Colors.black:Colors.white,fontSize: 20),),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  decoration: BoxDecoration(
                    color:isDark?Colors.black:Colors.white,
                    border: Border.all(color: Colors.red)
                  ),
                  child: Text('  ${reporting}  ',style: TextStyle(color: isDark?Colors.white:Colors.black,fontSize:15,fontWeight: FontWeight.bold),)),
              SizedBox(
                height: 10,
              ),
              Text('Posted on ${formattedDateTimes} at ${formattedDatetimes}',style: TextStyle(color:isDark?Colors.black:Colors.white,fontWeight: FontWeight.w200),),
              SizedBox(
                height: 10,
              ),
              Text('Attached Image',style: TextStyle(color:isDark?Colors.black:Colors.white,fontWeight: FontWeight.w200),),
              SizedBox(
                height: 10,
              ),
              CachedNetworkImage(
                imageUrl:
                imageurl,
                height: 220,
                width: 250,
                filterQuality: FilterQuality.high,
                fadeInDuration: Duration(seconds: 2),
                fadeOutDuration: Duration(seconds: 2),
                fadeInCurve: Curves.decelerate,
                placeholder: (context, url) =>
                    Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                errorWidget: (context, url, error) => Text(
                  'Image Not Found',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: isDark?Colors.black:Colors.white,
                indent: 50,
                endIndent: 50,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('What can I do and reason?',style: TextStyle(
                      color: isDark?Colors.black:Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),),
                ],
              ),
              SizedBox(height: 20,),

              if(reporttype=='Violent or repulsive')
                Column(
                  children: [
                  SizedBox(
                    height: 20,
                  ) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Community Guidelines for ${reporttype}',style: TextStyle(color: isDark?Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showguidelines = !_showguidelines;
                              print(_showguidelines);
                            });
                          },
                          icon: Icon(
                            _showguidelines ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                    height: 20,
                  ) ,
                  if(_showguidelines)
                    Text('''Clear Content Policies:

Clearly define what constitutes violent or repulsive content on your website.
Include specific examples to guide users on acceptable and unacceptable content.
User Registration and Verification:

Require users to register with valid and verified email addresses.
Implement additional identity verification measures if necessary.
Content Moderation:

Employ a robust content moderation system to review user-generated content before it is published.
Set guidelines for moderators to identify and remove content that is violent or repulsive.
Reporting Mechanism:

Provide an easily accessible and anonymous way for users to report violent or repulsive content.
Establish a system to respond promptly to reports and take appropriate actions.
Prohibition of Harmful Behavior:

Explicitly state that any content promoting violence, harm, or illegal activities is strictly prohibited.
Include information about legal consequences for violating these guidelines.
Age Restrictions:

Implement age restrictions for certain types of content to ensure it is suitable for the intended audience.
Clearly communicate age restrictions on your website.
Blacklisting and Whitelisting:

Maintain a blacklist of keywords, images, or phrases associated with violent or repulsive content.
Consider whitelisting approved content creators or contributors.
Educational Resources:

Provide educational resources or guidelines to help users understand what content is considered violent or repulsive.
Regularly communicate with users about the importance of maintaining a safe community.
User Reporting Rewards:

Consider implementing a rewards system for users who actively report and help identify violent or repulsive content.
Recognize and appreciate the community's efforts to maintain a safe space.
Legal Compliance:

Ensure that your website complies with relevant laws and regulations regarding violent or repulsive content.
Cooperate with law enforcement if required and report any illegal activities.
Terms of Service and User Agreement:

Clearly outline your website's terms of service, including rules related to violent or repulsive content.
Make it mandatory for users to agree to these terms before accessing or contributing to the platform.
Regular Audits and Reviews:

Conduct regular audits of user-generated content to identify and remove any potentially harmful material.
Keep guidelines updated based on emerging trends and potential threats.
Community Guidelines Enforcement:

Enforce the guidelines consistently across all users to maintain a fair and just community.
Clearly state the consequences for violating content policies.
User Education and Awareness Campaigns:

Conduct awareness campaigns to educate users about the impact of violent or repulsive content on the community.
Promote a culture of respect and responsible content creation.''',style: TextStyle(color: isDark?Colors.black:Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 15),)
                  ],
                ),
              if(reporttype=='Harmful or dangerous acts')
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Community Guidelines for ${reporttype}',style: TextStyle(color: isDark?Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showguidelines = !_showguidelines;
                              print(_showguidelines);
                            });
                          },
                          icon: Icon(
                            _showguidelines ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ) ,
                    if(_showguidelines)
                      Text('''Clear Content Policies:

Clearly articulate your website's stance against hate speech, discrimination, and abusive content in your terms of service and community guidelines.
Define Hate Speech and Abusive Content:

Provide specific definitions of hate speech and abusive content to guide users on what is unacceptable.
Report Mechanism:

Establish a user-friendly reporting system for users to flag content that they find offensive or abusive.
Ensure that reports are reviewed promptly, and appropriate actions are taken.
Moderation Team:

Assemble a dedicated moderation team to monitor and review user-generated content.
Provide training to moderators on identifying hate speech and abusive content.
User Education:

Educate users about the type of content that is considered inappropriate.
Communicate the consequences for violating content policies.
Automatic Filters:

Implement automated filters to detect and block specific words or phrases associated with hate speech or abuse.
Regularly update filters to adapt to evolving language.
Content Review Guidelines:

Establish clear criteria for content reviewers to assess whether a piece of content violates hate speech or abuse policies.
Ensure consistency in applying guidelines across all moderators.
User Blocking and Muting:

Provide users with the ability to block or mute other users to limit exposure to potentially harmful content.
Community Guidelines Enforcement:

Enforce community guidelines consistently, regardless of user status or popularity.
Clearly communicate the consequences for violating guidelines, including warnings, temporary suspensions, or permanent bans.
Cultural Sensitivity:

Recognize and be sensitive to cultural nuances when evaluating content to avoid unintentional bias.
Regular Audits:

Conduct regular audits of user-generated content to identify and remove any hate speech or abusive material.
Keep abreast of emerging trends and adapt moderation practices accordingly.
Anonymous Posting Policies:

Consider implementing restrictions on anonymous posting to encourage accountability.
Legal Compliance:

Ensure that your website complies with relevant laws and regulations related to hate speech and abusive content.
Cooperate with law enforcement authorities when necessary.
User Empowerment:

Empower users by providing tools to customize their experience, such as content filters and privacy settings.
Encourage positive interactions and community-building activities.
Community Engagement:

Foster a sense of community by actively engaging with users through forums, newsletters, and social media to encourage positive interactions.''',style: TextStyle(color: isDark?Colors.black:Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),)
                  ],
                ),
              if(reporttype=='Sexual Content')
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Community Guidelines for ${reporttype}',style: TextStyle(color: isDark?Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showguidelines = !_showguidelines;
                              print(_showguidelines);
                            });
                          },
                          icon: Icon(
                            _showguidelines ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ) ,
                    if(_showguidelines)
                      Text('''Define Acceptable Content:

Clearly outline what constitutes acceptable nudity on your website. Define the boundaries and specify the context in which nudity is allowed.
Age Restrictions:

Implement age restrictions to ensure that only users who are of legal age to view explicit content can access it.
Consent and Respect:

Emphasize the importance of consent and respect for the privacy of individuals depicted in any explicit content.
Moderation and Approval Process:

Enforce a content moderation system to review and approve any explicit content before it is published on the website.
User Reporting Mechanism:

Establish a user-friendly reporting mechanism for users to report inappropriate or offensive content related to nudity.
Explicit Warning Labels:

Clearly label any content containing nudity with explicit warnings. This helps users make informed decisions before engaging with such content.
Artistic or Educational Context:

Specify if nudity is allowed in artistic or educational contexts. Define what qualifies as art or educational content to avoid misunderstandings.
No Child Exploitation:

Explicitly prohibit any content that involves child exploitation or depicts minors in a sexualized manner. Ensure strict enforcement of this rule.
Consistent Enforcement:

Enforce nudity guidelines consistently across all user-generated content, profiles, and any other areas of your website.
Private vs. Public Content:

Differentiate guidelines for private and public content. Some content may be acceptable in private messages but not on public forums.
User Profile Images:

Specify guidelines for user profile images, ensuring that they adhere to the overall nudity policy of the website.
Educate Users:

Educate your users about the nudity guidelines and the reasons behind them. Provide clear examples to help users understand the expectations.
Community Standards:

Establish community standards that encourage users to create a respectful and inclusive environment. Discourage any form of harassment or intimidation.
Legal Compliance:

Ensure that your website complies with relevant laws and regulations regarding explicit content. Stay informed about changes in legislation that may impact your guidelines.
User Agreement and Terms of Service:

Include explicit guidelines regarding nudity in your user agreement and terms of service. Clearly communicate the consequences for violating these guidelines.
Regular Review and Updates:

Regularly review and update your nudity guidelines to adapt to evolving community standards and legal requirements.
User Feedback:

Encourage users to provide feedback on the guidelines. Periodically review user feedback to make improvements or adjustments as needed.''',style: TextStyle(color: isDark?Colors.black:Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),)
                  ],
                ),
              if(reporttype=='Nudity')
                Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Community Guidelines for ${reporttype}',style: TextStyle(color: isDark?Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showguidelines = !_showguidelines;
                              print(_showguidelines);
                            });
                          },
                          icon: Icon(
                            _showguidelines ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ) ,
                    if(_showguidelines)
                      Text('''Define Acceptable Content:

Clearly outline what constitutes acceptable nudity on your website. Define the boundaries and specify the context in which nudity is allowed.
Age Restrictions:

Implement age restrictions to ensure that only users who are of legal age to view explicit content can access it.
Consent and Respect:

Emphasize the importance of consent and respect for the privacy of individuals depicted in any explicit content.
Moderation and Approval Process:

Enforce a content moderation system to review and approve any explicit content before it is published on the website.
User Reporting Mechanism:

Establish a user-friendly reporting mechanism for users to report inappropriate or offensive content related to nudity.
Explicit Warning Labels:

Clearly label any content containing nudity with explicit warnings. This helps users make informed decisions before engaging with such content.
Artistic or Educational Context:

Specify if nudity is allowed in artistic or educational contexts. Define what qualifies as art or educational content to avoid misunderstandings.
No Child Exploitation:

Explicitly prohibit any content that involves child exploitation or depicts minors in a sexualized manner. Ensure strict enforcement of this rule.
Consistent Enforcement:

Enforce nudity guidelines consistently across all user-generated content, profiles, and any other areas of your website.
Private vs. Public Content:

Differentiate guidelines for private and public content. Some content may be acceptable in private messages but not on public forums.
User Profile Images:

Specify guidelines for user profile images, ensuring that they adhere to the overall nudity policy of the website.
Educate Users:

Educate your users about the nudity guidelines and the reasons behind them. Provide clear examples to help users understand the expectations.
Community Standards:

Establish community standards that encourage users to create a respectful and inclusive environment. Discourage any form of harassment or intimidation.
Legal Compliance:

Ensure that your website complies with relevant laws and regulations regarding explicit content. Stay informed about changes in legislation that may impact your guidelines.
User Agreement and Terms of Service:

Include explicit guidelines regarding nudity in your user agreement and terms of service. Clearly communicate the consequences for violating these guidelines.
Regular Review and Updates:

Regularly review and update your nudity guidelines to adapt to evolving community standards and legal requirements.
User Feedback:

Encourage users to provide feedback on the guidelines. Periodically review user feedback to make improvements or adjustments as needed.''',style: TextStyle(
                          color: isDark?Colors.black:Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15
                      ),)
                  ],
                ),
              if(reporttype=='Spam')
                Column(
                  children: [
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Community Guidelines for ${reporttype}',style: TextStyle(color: isDark?Colors.black:Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _showguidelines = !_showguidelines;
                              print(_showguidelines);
                            });
                          },
                          icon: Icon(
                            _showguidelines ? Icons.arrow_drop_down_rounded : Icons.arrow_drop_up_rounded,
                            color: isDark ? Colors.black : Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ) ,
                    if(_showguidelines)
                      Text('''User Registration and Verification:

Require users to register with a valid email address.
Implement email verification to ensure the authenticity of the provided email addresses.
CAPTCHA and Anti-Bot Measures:

Use CAPTCHA or reCAPTCHA on forms to prevent automated bot submissions.
Consider implementing additional anti-bot measures such as honeypots or time delays.
Content Moderation:

Moderate user-generated content before it gets published on your site.
Use automated filters to detect and block common spam keywords.
User Permissions and Roles:

Assign different user roles with varying levels of permissions.
Limit certain actions, like posting links or images, to users with higher trust levels.
Reporting Mechanism:

Provide a clear and easily accessible way for users to report spam or inappropriate content.
Act promptly on reported issues to maintain a clean environment.
Blacklisting and Whitelisting:

Maintain a blacklist of known spammers, IP addresses, or email domains.
Consider whitelisting trusted users or content contributors.
Rate Limiting:

Implement rate limiting on user actions (e.g., posting comments, creating accounts) to prevent mass submissions.
Use Advanced Filtering Techniques:

Explore advanced filtering techniques, such as Bayesian filtering, to identify and block spam patterns.
Educate Users:

Provide information to users about what constitutes spam and the consequences for engaging in spammy behavior.
Regularly communicate with your user base about your anti-spam efforts.
Monitoring and Analytics:

Utilize website analytics to monitor user behavior and detect unusual patterns that may indicate spam.
Set up alerts for sudden spikes in activity or suspicious user behavior.
Update and Patch Systems:

Keep your website software, plugins, and any third-party tools up to date to address potential vulnerabilities that spammers might exploit.
Legal Compliance:

Ensure that your website complies with anti-spam laws and regulations in your jurisdiction.
Clearly outline your website's terms of use, including rules related to spam, in your terms of service.
Secure Your Contact Forms:

Use secure and well-coded contact forms to prevent spammers from exploiting vulnerabilities.
Consider adding a challenge question or answer to your contact forms.
Regular Audits and Reviews:

Conduct regular audits of user accounts and content to identify and remove any potential spam.
Review and update your spam prevention measures based on emerging threats.''',style: TextStyle(color: isDark?Colors.black:Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 15),),
                  ],
                ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    fetchunbantime();
                  });
                },
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.red)),
                child: Text('Check Ban Status'),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
