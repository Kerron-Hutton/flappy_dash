import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flappy_dash/components/dash.dart';
import 'package:flappy_dash/components/parallax_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  late Dash _player;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    _player = Dash();

    add(ParallaxBackground());
    add(_player);
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    onSpacebarTap();
  }

  void onSpacebarTap() {
    _player.jump();
  }
}
