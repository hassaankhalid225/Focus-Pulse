import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';

class FireAnimation extends StatelessWidget {
  final double size;
  final bool animate;

  const FireAnimation({
    super.key,
    this.size = 24,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    var icon = Icon(
      Icons.local_fire_department,
      color: AppColors.fire,
      size: size,
    );

    if (!animate) return icon;

    return icon
        .animate(onPlay: (controller) => controller.repeat())
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.15, 1.15),
          duration: 800.ms,
          curve: Curves.easeInOut,
        )
        .then()
        .scale(
          begin: const Offset(1.15, 1.15),
          end: const Offset(1, 1),
          duration: 800.ms,
          curve: Curves.easeInOut,
        )
        .tint(
          color: const Color(0xFFFFD700),
          delay: 400.ms,
          duration: 400.ms,
        );
  }
}
