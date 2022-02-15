import 'package:flutter/material.dart';
import '../src/models/models.dart';

Widget listCircleAvatar({
  required List<Song> song,
  required String title,
  required String subtitle,
  onTap,
}) {
  return SizedBox(
    height: 210,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      SizedBox(
        height: 120,
        child: ListView.builder(
          itemCount: song.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: onTap,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(song[index].coverUrl),
                      radius: 40,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      song[index].title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      song[index].singer,
                      style: const TextStyle(color: Colors.white54),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      )
    ]),
  );
}
