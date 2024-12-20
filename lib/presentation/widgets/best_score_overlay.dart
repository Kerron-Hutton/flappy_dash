import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_styles.dart';
import 'box_overlay.dart';

class BestScoreOverlay extends StatelessWidget {
  const BestScoreOverlay({
    super.key,
    required this.onTap,
  });

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        onTap: onTap,
        child: BoxOverlay(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 24,
                height: 24,
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/ic_trophy.svg',
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        AppColors.leaderboardGoldenColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const Align(
                      alignment: Alignment(0.0, -0.8),
                      child: Text(
                        '2',
                        style: TextStyle(
                          color: AppColors.leaderboardGoldenColorText,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your best',
                    style: TextStyle(
                      color: AppColors.whiteTextColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '122',
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
