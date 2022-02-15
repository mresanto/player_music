import 'package:dio/dio.dart';
import 'package:player_music/src/models/models.dart';

class SongsService {
  final Dio dio;

  final url = 'http://10.0.2.2:3031/Songs';
  //final url = 'http://localhost:3031/Songs';

  SongsService([Dio? cliente]) : dio = cliente ?? Dio();

  fetchTodos() async {
    final response = await dio.get(url);
    final list = response.data as List;
    //return list;
    return list.map((json) => Song.fromJson(json)).toList();

    /*
    for (var json in list) {
      final todo = TodoModel.fromJson(json);
      todos.add(todo);
    }

    return todos;
    */
  }
}
