import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../bloc/game/game_cubit.dart';
import '../flappy_dash_game.dart';
import 'dash.dart';
import 'parallax_background.dart';
import 'pipe_pair.dart';

class FlappyDashRootComponent extends Component
    with FlameBlocReader<GameCubit, GameState>, HasGameRef<FlappyDashGame> {
  late PipePair _lastPipePair;
  late Dash _player;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _player = Dash();

    add(ParallaxBackground());
    _generatePipes();
    add(_player);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_player.x >= _lastPipePair.x) {
      _generatePipes(fromX: distanceFromPipes);
      _removeFirstXPipes(numOfPipesInLoop);
    }
  }

  void _generatePipes({double fromX = 350}) {
    for (var i = 0; i < numOfPipesInLoop; i++) {
      final y = Random().nextDouble() * pipeGap - (pipeGap / 2);

      final pair = PipePair(
        position: Vector2((distanceFromPipes * i) + fromX, y),
      );

      add(_lastPipePair = pair);
    }
  }

  void _removeFirstXPipes(int xPipesToRemove) {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - xPipesToRemove, 0);

    pipes.take(shouldBeRemoved).forEach((pipe) => pipe.removeFromParent());
  }

  void triggerJumpAction() {
    if (bloc.state.currPlayingState.isIdle) {
      bloc.startPlaying();
    }
    _player.jump();
  }
}
