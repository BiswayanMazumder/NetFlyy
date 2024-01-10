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
      title: 'Peaky Blinders Season 6',
      home: Lincoln1(),
    );
  }
}

class Lincoln1 extends StatefulWidget {
  const Lincoln1({Key? key}) : super(key: key);

  @override
  State<Lincoln1> createState() => _Lincoln1();
}

class _Lincoln1 extends State<Lincoln1> {
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
        middle: Text(
          "Lincoln Lawyer",
          style: TextStyle(color: CupertinoColors.white),
        ),
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
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af";
String videoUrlPortrait =
    'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af';
String longVideo =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af";

String video720 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af";

String video480 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af";

String video240 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/The%20Lincoln%20Lawyer%20(2011)%20-%20Official%20Trailer%20%231.mp4?alt=media&token=0db5df08-efc6-4aa5-8856-0ef269a7b3af";
