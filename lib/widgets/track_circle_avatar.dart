import 'package:flutter/material.dart';

import '../src/models/models.dart';

class TrackCircleAvatar extends StatelessWidget {
  final Song song;
  final Function() onTap;
  const TrackCircleAvatar({Key? key, required this.song, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(song.coverUrl),
              radius: 40,
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              song.title,
              style: const TextStyle(color: Colors.white),
            ),
            Text(
              song.singer,
              style: const TextStyle(color: Colors.white54),
            )
          ],
        ),
      ),
    );
  }
}
