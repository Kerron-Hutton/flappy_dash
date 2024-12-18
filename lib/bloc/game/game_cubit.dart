import 'package:equatable/equatable.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this._audioHelper) : super(GameState());

  final AudioHelper _audioHelper;

  void startPlaying() {
    _audioHelper.playBackgroundAudio();

    emit(state.copyWith(
      currPlayingState: PlayingState.playing,
      currScore: 0,
    ));
  }

  void increaseScore() {
    _audioHelper.playSourceAudio();

    emit(state.copyWith(
      currScore: state.currScore + 1,
    ));
  }

  void gameOver() {
    _audioHelper.stopBackgroundAudio();
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
