import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flame_bloc/flame_bloc.dart';

import '../bloc/game/game_cubit.dart';
import '../flappy_dash_game.dart';

class ParallaxBackground extends ParallaxComponent<FlappyDashGame>
    with FlameBlocReader<GameCubit, GameState> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    anchor = Anchor.center;
    parallax = await game.loadParallax(
      [
        ParallaxImageData('background/layer1-sky.png'),
        ParallaxImageData('background/layer2-clouds.png'),
        ParallaxImageData('background/layer3-clouds.png'),
        ParallaxImageData('background/layer4-clouds.png'),
        ParallaxImageData('background/layer5-huge-clouds.png'),
        ParallaxImageData('background/layer6-bushes.png'),
        ParallaxImageData('background/layer7-bushes.png'),
      ],
      velocityMultiplierDelta: Vector2(1.7, 0),
      baseVelocity: Vector2(1, 0),
    );
  }

  @override
  void update(double dt) {
    final showParallaxStates = [PlayingState.playing, PlayingState.idle];

    if (showParallaxStates.contains(bloc.state.currPlayingState)) {
      super.update(dt);
    }
  }
}
