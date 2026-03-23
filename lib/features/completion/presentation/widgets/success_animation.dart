import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../app/theme/app_colors.dart';

class SuccessAnimation extends StatelessWidget {
  const SuccessAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Glow
          Container(
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.success.withOpacity(0.1),
              boxShadow: [
                BoxShadow(
                  color: AppColors.success.withOpacity(0.3),
                  blurRadius: 30,
                  spreadRadius: 10,
                ),
              ],
            ),
          )
              .animate(onPlay: (controller) => controller.repeat())
              .scale(
                begin: const Offset(1, 1),
                end: const Offset(1.2, 1.2),
                duration: 1.seconds,
                curve: Curves.easeInOut,
              )
              .fadeOut(duration: 1.seconds),

          // Central Checkmark
          const Icon(
            Icons.check_circle_outline,
            size: 120,
            color: AppColors.success,
          )
              .animate()
              .scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),

          // Burst Particles
          ...List.generate(8, (index) {
            final angle = index * (pi / 4);
            return Positioned(
              child: _BurstCircle(angle: angle),
            );
          }),
        ],
      ),
    );
  }
}

class _BurstCircle extends StatelessWidget {
  final double angle;

  const _BurstCircle({required this.angle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.success,
      ),
    )
        .animate()
        .move(
          begin: const Offset(0, 0),
          end: Offset(cos(angle) * 80, sin(angle) * 80),
          duration: 600.ms,
          curve: Curves.easeOutCubic,
          delay: 200.ms,
        )
        .fadeOut(duration: 600.ms, delay: 200.ms);
  }
}
