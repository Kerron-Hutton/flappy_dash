import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../app_styles.dart';
import 'box_overlay.dart';

class ProfileOverlay extends StatelessWidget {
  const ProfileOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return BoxOverlay(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/ic_profile.svg',
            height: 24,
          ),
          const SizedBox(width: 8),
          const Text(
            'My Profile',
            style: TextStyle(
              color: AppColors.mainColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
