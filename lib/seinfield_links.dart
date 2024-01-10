import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
        brightness: Brightness.dark,
      ),
      title: 'SeinField',
      home: seinfield_links(),
    );
  }
}

class seinfield_links extends StatefulWidget {
  const seinfield_links({Key? key}) : super(key: key);

  @override
  State<seinfield_links> createState() => _seinfield_linksState();
}

class _seinfield_linksState extends State<seinfield_links> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;
  late CustomVideoPlayerWebController _customVideoPlayerWebController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
  const CustomVideoPlayerSettings();

  final CustomVideoPlayerWebSettings _customVideoPlayerWebSettings =
  CustomVideoPlayerWebSettings(
    src: longVideo,
  );

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      longVideo,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(video240);
    _videoPlayerController3 = VideoPlayerController.network(video480);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "240p": _videoPlayerController2,
        "480p": _videoPlayerController3,
        "720p": _videoPlayerController,
      },
    );

    _customVideoPlayerWebController = CustomVideoPlayerWebController(
      webVideoPlayerSettings: _customVideoPlayerWebSettings,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.black,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: CupertinoColors.black,
        middle: Text("SeinField Trailer",style:TextStyle(
            color: CupertinoColors.white
        ),),
      ),
      child: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 200,
            ),
            kIsWeb
                ? Expanded(
              child: CustomVideoPlayerWeb(
                customVideoPlayerWebController:
                _customVideoPlayerWebController,
              ),
            )
                : CustomVideoPlayer(
              customVideoPlayerController: _customVideoPlayerController,
            ),

            CupertinoButton(
              child: const Text("Play Fullscreen"),
              onPressed: () {
                if (kIsWeb) {
                  _customVideoPlayerWebController.setFullscreen(true);

                  _customVideoPlayerWebController.play();
                } else {
                  _customVideoPlayerController.setFullscreen(true);
                  _customVideoPlayerSettings.alwaysShowThumbnailOnVideoPaused;
                  // _customVideoPlayerSettings.customVideoPlayerProgressBarSettings()
                  _customVideoPlayerController.videoPlayerController.play();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

String videoUrlLandscape =
    "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin";
String videoUrlPortrait =
    'https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin';
String longVideo =
    "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin";

String video720 =
    "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin";

String video480 =
    "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin";

String video240 =
    "https://cloud.appwrite.io/v1/storage/buckets/64e06014b029b4116daf/files/652b7eea25626d7570b2/view?project=64e0600003aac5802fbc&mode=admin";