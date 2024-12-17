part of 'game_cubit.dart';

enum PlayingState { none, paused, playing, gameOver }

class GameState extends Equatable {
  const GameState({
    this.currPlayingState = PlayingState.none,
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
