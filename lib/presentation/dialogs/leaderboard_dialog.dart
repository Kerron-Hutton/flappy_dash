import 'package:flappy_dash/presentation/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_styles.dart';

class LeaderBoardDialog extends StatelessWidget {
  const LeaderBoardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const closeIconSize = 38.0;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      content: Container(
        width: 400,
        decoration: BoxDecoration(
          color: AppColors.dialogBgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(16),
          ),
          border: Border.all(
            color: Colors.black,
            width: 6,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 0.1,
              blurRadius: 0,
              offset: Offset(0, 6),
            )
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: closeIconSize),
                const Text(
                  'Leaderboard',
                  style: TextStyle(
                    color: AppColors.whiteTextColor,
                    fontSize: 20,
                    fontFamily: 'Roboto',
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: SvgPicture.asset(
                    'assets/icons/ic_close.svg',
                    width: closeIconSize,
                    height: closeIconSize,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 400,
              child: ListView.separated(
                padding: const EdgeInsets.only(top: 18, bottom: 12),
                itemBuilder: (context, index) {
                  return LeaderboardRow(
                    rank: index + 1,
                    name: 'Player ${index + 1}',
                    score: index * 12,
                    isMine: index == 2,
                    onMyProfileTap: () => AppDialogs.nicknameDialog(context),
                  );
                },
                separatorBuilder: (context, index) => Container(
                  height: 1,
                  color: Colors.white10,
                ),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardRow extends StatelessWidget {
  const LeaderboardRow({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    required this.isMine,
    required this.onMyProfileTap,
  });

  final int rank;
  final String name;
  final int score;
  final bool isMine;
  final VoidCallback? onMyProfileTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isMine ? onMyProfileTap : null,
        child: Container(
          color: isMine ? Colors.white10 : Colors.transparent,
          height: 64,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            children: [
              rank <= 3
                  ? ScoreTrophy(
                      size: 38,
                      rank: rank,
                    )
                  : NormalScore(
                      size: 38,
                      rank: rank,
                    ),
              const SizedBox(width: 16),
              Text(
                name,
                style: TextStyle(
                  color: isMine ? Colors.white : AppColors.whiteTextColor2,
                  fontSize: 28,
                ),
              ),
              if (isMine) ...[
                const SizedBox(width: 4),
                const Align(
                  alignment: Alignment(0, 0.3),
                  child: Text(
                    '(edit)',
                    style: TextStyle(
                      color: AppColors.blueColor,
                    ),
                  ),
                ),
              ],
              Expanded(child: Container()),
              Text(
                score.toString(),
                style: const TextStyle(
                  color: AppColors.blueColor,
                  fontSize: 36,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ScoreTrophy extends StatelessWidget {
  const ScoreTrophy({
    super.key,
    required this.size,
    required this.rank,
  });

  final double size;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          SvgPicture.asset(
            'assets/icons/ic_trophy.svg',
            height: size,
            colorFilter: ColorFilter.mode(
              switch (rank) {
                1 => AppColors.leaderboardGoldenColor,
                2 => AppColors.leaderboardSilverColor,
                3 => AppColors.leaderboardBronzeColor,
                _ => throw StateError('Invalid rank: $rank'),
              },
              BlendMode.srcIn,
            ),
          ),
          Align(
            alignment: const Alignment(0.0, -0.8),
            child: Text(
              rank.toString(),
              style: TextStyle(
                color: switch (rank) {
                  1 => AppColors.leaderboardGoldenColorText,
                  2 => AppColors.leaderboardSilverColorText,
                  3 => AppColors.leaderboardBronzeColorText,
                  _ => throw StateError('Invalid rank: $rank'),
                },
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NormalScore extends StatelessWidget {
  const NormalScore({
    super.key,
    required this.size,
    required this.rank,
  });

  final double size;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.mainColor,
        ),
      ),
      child: Center(
        child: Text(
          rank.toString(),
          style: const TextStyle(
            color: AppColors.mainColor,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
