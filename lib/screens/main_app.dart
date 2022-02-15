import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:player_music/screens/screen.dart';
import 'package:player_music/src/controller/main_controller.dart';
import 'package:player_music/src/models/models.dart';
import 'package:player_music/widgets/widgets.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  //Api controller
  final controller = MainController();

  //btnIcon
  IconData btnPlayIcon = Icons.play_arrow;
  Color btnLoopIconColor = Colors.white;

  //Duration

  Duration duration = const Duration();
  Duration position = const Duration();
  //Current Song
  Song song = Song(
      id: 0,
      singer: 'singer',
      title: 'title',
      url: 'url',
      coverUrl: 'coverUrl',
      color: 'color');

  //Audio Command
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool isPlaying = false;
  bool isLooping = false;
  String currentSong = "";
  void playMusic(String url) async {
    if (isPlaying && currentSong != url) {
      audioPlayer.pause();
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          currentSong = url;
        });
      }
    } else if (!isPlaying) {
      int result = await audioPlayer.play(url);
      if (result == 1) {
        setState(() {
          isPlaying = true;
        });
      }
    }
  }

  //Management State api
  stateManagement(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _sucess();
      case HomeState.details:
        return _details();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  _details() {
    return DetailsMusic(
      song: song,
      position: position,
      duration: duration,
      onLoopPressed: () {
        _isLooping();
      },
      onBackPressed: () {
        controller.changedScreen(2);
      },
      onChangedSlider: (val) {
        setState(() {
          position = Duration(seconds: val.toInt());
          audioPlayer.seek(position);
        });
      },
      onPressedPlay: () {
        _isPlaying();
      },
      btnPlayIcon: btnPlayIcon,
      btnLoopIconColor: btnLoopIconColor,
    );
  }

  _start() {
    return Container();
  }

  _loading() {
    return const Center(
      child: CircularProgressIndicator(
        value: null,
        strokeWidth: 4.0,
        color: Colors.white,
      ),
    );
  }

  _sucess() {
    double positioned = position.inSeconds.toDouble();
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.grey[900],
        elevation: 0,
        leading: const Icon(Icons.search),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                "Hello, Pathway",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                "Brasil",
                style: TextStyle(fontSize: 10),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(right: 8, left: 15),
            child: Icon(
              Icons.notifications_active_outlined,
              size: 30,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const _BigTitle(
                    title1: 'most',
                    title2: 'popular',
                    subtitle: '960 playlist'),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.song.length,
                    itemBuilder: (context, index) {
                      return tileContainer(
                          song: controller.song[index],
                          onTap: () {
                            setState(() {
                              _setMusic(index);
                            });
                          });
                    },
                  ),
                ),
                SizedBox(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Titles(
                            title: 'new releases', subtitle: '3456 songs'),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: controller.song.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TrackCircleAvatar(
                                onTap: () {
                                  setState(() {
                                    _setMusic(index);
                                  });
                                },
                                song: controller.song[index],
                              );
                            },
                          ),
                        ),
                        const _Titles(
                            title: 'your playlist', subtitle: '346 songs'),
                        SizedBox(
                          height: 120,
                          child: ListView.builder(
                            itemCount: controller.song.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return TrackCircleAvatar(
                                onTap: () {
                                  setState(() {
                                    _setMusic(index);
                                  });
                                },
                                song: controller.song[index],
                              );
                            },
                          ),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 130,
                ),
              ],
            ),
          ),
          if (song.title == 'title')
            Container()
          else
            Align(
              alignment: Alignment.bottomCenter,
              child: NewPlayTile(
                song: song,
                position: position,
                duration: duration,
                btnIcon: btnPlayIcon,
                onChanged: (val) {
                  setState(() {
                    position = Duration(seconds: val.toInt());
                    audioPlayer.seek(position);
                  });
                },
                onTap: () {
                  controller.changedScreen(1);
                  //Navigator.push(
                  //    context,
                  //    PageRouteBuilder(
                  //        pageBuilder:
                  //            ((context, animation, secondaryAnimation) =>
                  //                DetailsMusic(
                  //                  song: song,
                  //                  position: position,
                  //                  duration: duration,
                  //                  btnIcon: btnIcon,
                  //                  onPressed: () {
                  //                    _isPlaying();
                  //                  },
                  //                ))));
                },
                onPressed: () {
                  _isPlaying();
                },
              ),
            ),
        ],
      ),
    );
  }

  void _setMusic(int index) {
    playMusic(controller.song[index].url);
    song = controller.song[index];
  }

  void _isLooping() {
    if (isLooping) {
      audioPlayer.setReleaseMode(ReleaseMode.LOOP);
      setState(() {
        btnLoopIconColor = Colors.greenAccent;
        isLooping = false;
      });
    } else {
      audioPlayer.setReleaseMode(ReleaseMode.RELEASE);
      setState(() {
        btnLoopIconColor = Colors.white;
        isLooping = true;
      });
    }
  }

  void _isPlaying() {
    if (isPlaying) {
      audioPlayer.pause();
      setState(() {
        btnPlayIcon = Icons.play_arrow;
        isPlaying = false;
      });
    } else {
      audioPlayer.resume();
      setState(() {
        btnPlayIcon = Icons.pause;
        isPlaying = true;
      });
    }

    audioPlayer.onDurationChanged.listen((event) {
      setState(() {
        duration = event;
      });
    });

    audioPlayer.onAudioPositionChanged.listen((event) {
      setState(() {
        position = event;
      });
    });
  }

  _error() {
    return Center(
      child: ElevatedButton(
          onPressed: () {
            controller.start();
          },
          child: const Text('Try Again'),
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[600],
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              textStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)))),
    );
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return stateManagement(controller.state.value);
        },
      ),
    );
  }
}

class _Titles extends StatelessWidget {
  final String title, subtitle;
  const _Titles({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 20),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

class _BigTitle extends StatelessWidget {
  final String title1, title2, subtitle;
  const _BigTitle(
      {Key? key,
      required this.title1,
      required this.title2,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title1,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title2,
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 20),
          child: Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}
