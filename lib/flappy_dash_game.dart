import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/parallax_background.dart';
import 'package:flappy_dash/components/pipe_pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const distanceFromPipes = 400.0;
const numOfPipesInLoop = 5;
const pipeGap = 600.0;

class FlappyDashGame extends FlameGame<FlappyDashWorld> with KeyboardEvents {
  FlappyDashGame()
      : super(
          world: FlappyDashWorld(),
          camera: CameraComponent.withFixedResolution(
            width: 600,
            height: 1000,
          ),
        );

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      world.onSpacebarTap();
    }

    return KeyEventResult.ignored;
  }
}

class FlappyDashWorld extends World with TapCallbacks {
  late PipePair _lastPipePair;
  late Dash _player;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _player = Dash();

    add(ParallaxBackground());
    _generatePipes();
    add(_player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onSpacebarTap();
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_player.x >= _lastPipePair.x) {
      _generatePipes(fromX: distanceFromPipes);
      _removeFirstXPipes(numOfPipesInLoop);
    }
  }

  void onSpacebarTap() {
    _player.jump();
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
}
