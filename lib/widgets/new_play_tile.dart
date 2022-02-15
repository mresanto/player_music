import 'package:flutter/material.dart';

import '../src/models/models.dart';

class NewPlayTile extends StatefulWidget {
  final Function() onPressed;
  final Function(double) onChanged;
  final Song song;
  final Function() onTap;
  final Duration duration, position;
  final IconData btnIcon;
  const NewPlayTile({
    Key? key,
    required this.song,
    required this.position,
    required this.duration,
    required this.btnIcon,
    required this.onPressed,
    required this.onTap,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<NewPlayTile> createState() => _NewPlayTileState();
}

class _NewPlayTileState extends State<NewPlayTile> {
  @override
  Widget build(BuildContext context) {
    double currentSlider = widget.position.inSeconds.toDouble();
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(widget.song.coverUrl),
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.song.title,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.song.singer,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(widget.btnIcon),
                      color: Colors.white,
                      iconSize: 30,
                      onPressed: widget.onPressed,
                      //Icons.pause,
                      //color: Colors.white,
                      //size: 30,
                    ),
                    const SizedBox(height: 10),
                    const Icon(
                      Icons.skip_next_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(height: 10),
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Duration(seconds: currentSlider.toInt())
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: const TextStyle(color: Colors.white),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 120,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 4),
                        trackShape: const RectangularSliderTrackShape(),
                        trackHeight: 4),
                    child: Slider(
                      value: currentSlider,
                      max: widget.duration.inSeconds.toDouble(),
                      label: currentSlider.round().toString(),
                      min: 0,
                      inactiveColor: Colors.grey[500],
                      activeColor: Colors.white,
                      onChanged: widget.onChanged,
                    ),
                  ),
                ),
                Text(
                  Duration(seconds: widget.duration.inSeconds.toInt())
                      .toString()
                      .split('.')[0]
                      .substring(2),
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
