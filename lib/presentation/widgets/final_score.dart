import 'package:flappy_dash/presentation/bloc/game/game_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalScore extends StatelessWidget {
  const FinalScore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 56),
            child: Text(
              '${state.currScore}',
              style: GoogleFonts.chewy(
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                fontSize: 38,
              ),
            ),
          ),
        );
      },
    );
  }
}
