import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:flappy_dash/audio_helper.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/flappy_root_root_component.dart';

const distanceFromPipes = 400.0;
const numOfPipesInLoop = 5;
const pipeGap = 600.0;

class FlappyDashGame extends FlameGame<FlappyDashWorld>
    with KeyboardEvents, HasCollisionDetection {
  FlappyDashGame({required GameCubit this.gameCubit})
      : super(world: FlappyDashWorld());

  final GameCubit gameCubit;

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);

    if (isSpace && isKeyDown) {
      world.triggerJumpAction();
    }

    return KeyEventResult.ignored;
  }
}

class FlappyDashWorld extends World
    with HasGameRef<FlappyDashGame>, TapCallbacks {
  late FlappyDashRootComponent _rootComponent;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    await getIt.get<AudioHelper>().initialize();

    add(FlameBlocProvider<GameCubit, GameState>(
      create: () => game.gameCubit,
      children: [
        _rootComponent = FlappyDashRootComponent(),
      ],
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    triggerJumpAction();
  }

  void triggerJumpAction() => _rootComponent.triggerJumpAction();
}
