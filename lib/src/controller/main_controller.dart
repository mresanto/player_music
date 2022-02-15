import 'package:flutter/material.dart';
import 'package:player_music/src/models/models.dart';
import 'package:player_music/src/services/songs_content_service.dart';

class MainController {
  List<Song> song = [];

  final _repository = SongsService();
  final state = ValueNotifier<HomeState>(HomeState.start);

  Future start() async {
    state.value = HomeState.loading;
    try {
      song = await _repository.fetchTodos();
      state.value = HomeState.success;
    } catch (e) {
      state.value = HomeState.error;
    }
  }

  changedScreen(int i) {
    switch (i) {
      case 1:
        return state.value = HomeState.details;
      case 2:
        return state.value = HomeState.success;
    }
    return start();
  }
}

enum HomeState { start, loading, success, error, details }
