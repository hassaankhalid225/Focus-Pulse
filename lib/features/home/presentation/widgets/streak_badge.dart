import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../streak/domain/streak_controller.dart';
import '../../../streak/presentation/widgets/fire_animation.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class StreakBadge extends StatelessWidget {
  const StreakBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<StreakController>(
      builder: (context, controller, child) {
        final streak = controller.data.currentStreak;
        final isZero = streak == 0;

        return Opacity(
          opacity: isZero ? 0.4 : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.bgCard,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.fire.withOpacity(isZero ? 0.3 : 1.0),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FireAnimation(
                  size: 18,
                  animate: streak >= 3,
                ),
                const SizedBox(width: 4),
                Text(
                  '$streak',
                  style: AppTextStyles.bodySecondary.copyWith(
                    color: AppColors.fire,
                    fontWeight: FontWeight.bold,
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
