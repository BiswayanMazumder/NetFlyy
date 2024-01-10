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
      title: 'Peaky Blinders Season 2',
      home: Demon1(),
    );
  }
}

class Demon1 extends StatefulWidget {
  const Demon1({Key? key}) : super(key: key);

  @override
  State<Demon1> createState() => _Demon1State();
}

class _Demon1State extends State<Demon1> {
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
          "Demon Slayer",
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
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421";
String videoUrlPortrait =
    'https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421';
String longVideo =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421";

String video720 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421";

String video480 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421";

String video240 =
    "https://firebasestorage.googleapis.com/v0/b/netflix-5002f.appspot.com/o/Demon%20Slayer_%20Kimetsu%20no%20Yaiba%20Swordsmith%20Village%20Arc%20_%20OFFICIAL%20TRAILER.mp4?alt=media&token=60064a04-7198-4975-8e7e-3a321eb09421";
