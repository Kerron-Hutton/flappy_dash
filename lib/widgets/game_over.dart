import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../bloc/game/game_cubit.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Text(
                    'Game Over!',
                    style: GoogleFonts.chewy(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFCA00),
                      letterSpacing: 2,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    'Score ${state.currScore}',
                    style: GoogleFonts.chewy(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: context.read<GameCubit>().restartGame,
                    child: Text(
                      'Try Again!',
                      style: GoogleFonts.chewy(
                        letterSpacing: 2,
                        fontSize: 22,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
