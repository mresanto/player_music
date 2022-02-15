// ignore_for_file: avoid_print

import 'package:flutter_test/flutter_test.dart';
import 'package:player_music/src/models/models.dart';
import 'package:player_music/src/services/songs_content_service.dart';

void main() {
  final repository = SongsService();
  test('deve lista de sintelContent', () async {
    //when(dio.get(any))
    //.thenAnswer((_) async => Response(data: jsonDecode(jsonData)));
    List<Song> song;

    song = await repository.fetchTodos();
    for (int i = 0; i < song.length; i++) {
      print(song[i].title);
    }
    //expect(list[0].name, "Sintel");
  });
}
