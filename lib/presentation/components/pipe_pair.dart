import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/components/hidden_coin.dart';
import 'package:flappy_dash/presentation/components/pipe.dart';

class PipePair extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  PipePair({required super.position, double gap = 200.0, double speed = 200})
      : _speed = speed,
        _gap = gap;

  final double _gap, _speed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    addAll([
      Pipe(isFlipped: true, position: Vector2(0, -_gap / 2)),
      HiddenCoin(position: Vector2(50, 0)),
      Pipe(isFlipped: false, position: Vector2(0, _gap / 2)),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (bloc.state.currPlayingState.isPlaying) {
      position.x -= _speed * dt;
    }
  }
}
