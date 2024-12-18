import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

  void startPlaying() {
    emit(state.copyWith(
      currPlayingState: PlayingState.playing,
      currScore: 0,
    ));
  }

  void increaseScore() {
    emit(state.copyWith(
      currScore: state.currScore + 1,
    ));
  }

  void gameOver() {
    emit(state.copyWith(
      currPlayingState: PlayingState.gameOver,
    ));
  }

  void restartGame() {
    emit(state.copyWith(
      currPlayingState: PlayingState.idle,
      currScore: 0,
    ));
  }
}
