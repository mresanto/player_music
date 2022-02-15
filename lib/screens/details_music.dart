// ignore_for_file: sized_box_for_whitespace
import 'dart:ui';

import 'package:flutter/material.dart';

import '../src/models/models.dart';

class DetailsMusic extends StatefulWidget {
  final Song song;
  final Duration position, duration;
  final IconData btnPlayIcon;
  final Color btnLoopIconColor;
  final Function() onPressedPlay, onBackPressed, onLoopPressed;
  final Function(double) onChangedSlider;
  const DetailsMusic({
    Key? key,
    required this.song,
    required this.position,
    required this.duration,
    required this.onPressedPlay,
    required this.btnPlayIcon,
    required this.onChangedSlider,
    required this.onBackPressed,
    required this.onLoopPressed,
    required this.btnLoopIconColor,
  }) : super(key: key);

  @override
  _DetailsMusicState createState() => _DetailsMusicState();
}

double currentSlider = 0;

class _DetailsMusicState extends State<DetailsMusic> {
  @override
  Widget build(BuildContext _) {
    currentSlider = widget.position.inSeconds.toDouble();
    return Stack(
      children: [
        Hero(
          tag: 'image',
          child: Container(
            height: MediaQuery.of(_).size.height,
            width: MediaQuery.of(_).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage(widget.song.coverUrl),
              fit: BoxFit.cover,
            )),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: widget.onBackPressed,
            ),
            actions: [
              Column(
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
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 50, left: 20, right: 20),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 14,
                  spreadRadius: 16,
                  color: Colors.black.withOpacity(0.2),
                )
              ]),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: Container(
                    height: 280,
                    width: MediaQuery.of(_).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1.5,
                        color: Colors.white.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.song.title,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 40,
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            widget.song.singer,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(_).size.width,
                          child: SliderTheme(
                            data: SliderTheme.of(_).copyWith(
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 2),
                                trackShape: const RectangularSliderTrackShape(),
                                trackHeight: 6),
                            child: Slider(
                              value: currentSlider,
                              max: widget.duration.inSeconds.toDouble(),
                              label: currentSlider.round().toString(),
                              min: 0,
                              inactiveColor: Colors.white70,
                              activeColor: Colors.red,
                              onChanged: widget.onChangedSlider,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                Duration(seconds: currentSlider.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                Duration(
                                        seconds:
                                            widget.duration.inSeconds.toInt())
                                    .toString()
                                    .split('.')[0]
                                    .substring(2),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Icon(Icons.skip_previous_outlined,
                                color: Colors.white, size: 40),
                            IconButton(
                              icon: Icon(widget.btnPlayIcon),
                              color: Colors.white,
                              iconSize: 40,
                              onPressed: widget.onPressedPlay,
                            ),
                            const Icon(Icons.skip_next_outlined,
                                color: Colors.white, size: 40)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.loop_outlined),
                                  onPressed: widget.onLoopPressed,
                                  color: widget.btnLoopIconColor,
                                  iconSize: 40),
                              const Icon(Icons.shuffle,
                                  color: Colors.white, size: 40),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
