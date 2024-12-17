import 'package:flame/game.dart';
import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flappy_dash/flappy_dash_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/game_over.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlameGame _flappyDashGame;
  late GameCubit _gameCubit;

  PlayingState? _latestState;

  @override
  void initState() {
    _gameCubit = context.read<GameCubit>();
    _flappyDashGame = FlappyDashGame(gameCubit: _gameCubit);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currPlayingState == PlayingState.none &&
            _latestState == PlayingState.gameOver) {
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit: _gameCubit);
          });
        }

        _latestState = state.currPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(game: _flappyDashGame),
              if (state.currPlayingState == PlayingState.gameOver)
                const GameOver(),
              if (state.currPlayingState == PlayingState.none)
                Align(
                  alignment: Alignment(0, 0.2),
                  child: Text(
                    'Press to start'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
