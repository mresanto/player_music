import 'package:flutter/material.dart';

import '../src/models/models.dart';

Widget tileContainer({required Song song, onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.all(10),
      width: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colur(song.color),
            blurRadius: 1,
            spreadRadius: 0.3,
          ),
        ],
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(song.coverUrl),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              song.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              song.singer,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    ),
  );
}
//class TileContainer extends StatelessWidget {
//  final Song song;
//  final Function() notifyParent;
//  const TileContainer(
//      {Key? key, required this.song, required this.notifyParent})
//      : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return GestureDetector(
//      onTap: notifyParent,
//      child: Container(
//        margin: const EdgeInsets.all(10),
//        width: 200,
//        decoration: BoxDecoration(
//          borderRadius: BorderRadius.circular(20),
//          boxShadow: [
//            BoxShadow(
//              color: colur(song.color),
//              blurRadius: 1,
//              spreadRadius: 0.3,
//            ),
//          ],
//          image: DecorationImage(
//            fit: BoxFit.cover,
//            image: NetworkImage(song.coverUrl),
//          ),
//        ),
//        child: Padding(
//          padding: EdgeInsets.all(8),
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.end,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Text(
//                song.title,
//                style: const TextStyle(
//                  color: Colors.white,
//                  fontSize: 20,
//                  fontWeight: FontWeight.bold,
//                ),
//              ),
//              Text(
//                song.singer,
//                style: const TextStyle(
//                  color: Colors.white54,
//                  fontSize: 12,
//                ),
//              ),
//              const SizedBox(height: 20)
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}

colur(String color) {
  if (color == "red") {
    return Colors.red;
  } else if (color == "blue") {
    return Colors.blue;
  } else if (color == "green") {
    return Colors.green;
  } else if (color == "yellow") {
    return Colors.yellow;
  } else if (color == "black") {
    return Colors.black;
  } else if (color == "purple") {
    return Colors.purple;
  } else if (color == "pink") {
    return Colors.pink;
  } else if (color == "orange") {
    return Colors.orange;
  } else if (color == "grey") {
    return Colors.grey;
  }

  return Colors.white;
}
