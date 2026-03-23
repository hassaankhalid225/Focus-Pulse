import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:focuspulse/features/timer/domain/timer_controller.dart';
import 'package:focuspulse/features/timer/domain/audio_controller.dart';
import 'package:focuspulse/features/timer/domain/models/timer_state.dart';
import 'package:focuspulse/app/theme/app_colors.dart';
import 'package:focuspulse/app/theme/app_text_styles.dart';

class TimerControls extends StatelessWidget {
  const TimerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TimerController>(
      builder: (context, controller, child) {
        final isRunning = controller.state == TimerState.running;
        final isPaused = controller.state == TimerState.paused;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isRunning)
                  _ControlButton(
                    label: "Pause",
                    icon: Icons.pause,
                    onTap: () {
                      controller.pause();
                      // Also pause background music
                      context.read<AudioController>().pause();
                    },
                  ),
                if (isPaused)
                  _ControlButton(
                    label: "Resume",
                    icon: Icons.play_arrow,
                    onTap: () {
                      controller.resume();
                      // Also resume background music
                      context.read<AudioController>().play();
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                controller.reset();
                context.read<AudioController>().stop();
                context.goNamed('home');
              },
              child: Text(
                "Cancel",
                style: AppTextStyles.bodySecondary.copyWith(
                  color: AppColors.textSecondary.withOpacity(0.6),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ControlButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _ControlButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(30),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: AppColors.accentGlow.withOpacity(0.5),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.accentGlow, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppTextStyles.bodyPrimary.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
