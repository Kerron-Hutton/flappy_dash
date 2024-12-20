import 'package:flame/game.dart';
import 'package:flappy_dash/presentation/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flappy_dash/presentation/flappy_dash_game.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/app_dialogs.dart';
import '../widgets/best_score_overlay.dart';
import '../widgets/final_score.dart';
import '../widgets/game_over.dart';
import '../widgets/profile_overlay.dart';
import '../widgets/tap_to_play.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
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
        final shouldResetGame = state.currPlayingState.isIdle &&
            _latestState == PlayingState.gameOver;

        if (shouldResetGame) {
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit: _gameCubit);
          });
        }

        _latestState = state.currPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                GameWidget(
                  game: _flappyDashGame,
                  backgroundBuilder: (context) {
                    return Container(
                      color: AppColors.backgroundColor,
                    );
                  },
                ),
                if (state.currPlayingState.isGameOver) const GameOver(),
                if (state.currPlayingState.isIdle) const TapToPlay(),
                if (state.currPlayingState.isNotGameOver) const FinalScore(),
                Positioned(
                  top: 58,
                  right: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const ProfileOverlay(),
                      const SizedBox(height: 8),
                      BestScoreOverlay(
                        onTap: () => AppDialogs.showLeaderboard(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
