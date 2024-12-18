part of 'game_cubit.dart';

enum PlayingState {
  idle,
  paused,
  playing,
  gameOver;

  bool get isPlaying => this == PlayingState.playing;

  bool get isNotPlaying => !isPlaying;

  bool get isGameOver => this == PlayingState.gameOver;

  bool get isNotGameOver => !isGameOver;

  bool get isIdle => this == PlayingState.idle;

  bool get isPaused => this == PlayingState.paused;
}

class GameState extends Equatable {
  const GameState({
    this.currPlayingState = PlayingState.idle,
    this.currScore = 0,
  });

  final PlayingState currPlayingState;
  final int currScore;

  @override
  List<Object> get props => [currPlayingState, currScore];

  GameState copyWith({PlayingState? currPlayingState, int? currScore}) {
    return GameState(
      currPlayingState: currPlayingState ?? this.currPlayingState,
      currScore: currScore ?? this.currScore,
    );
  }
}
