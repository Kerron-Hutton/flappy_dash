import 'package:equatable/equatable.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nakama/nakama.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit(this._audioHelper) : super(GameState()) {
    _initializeNakama();
  }

  final AudioHelper _audioHelper;

  void _initializeNakama() async {
    final client = getNakamaClient(
      serverKey: '1a2b3c4d-5e6f-7g8h-9i0j-kllmmnnooppq',
      host: '127.0.0.1',
      grpcPort: 7349, // optional
      httpPort: 7350, // optional
      ssl: false,
    );

    final session = await client.authenticateDevice(
      deviceId: 'test-device',
      username: 'test-user-123',
    );

    print('Session: ${session.token}');
  }

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
