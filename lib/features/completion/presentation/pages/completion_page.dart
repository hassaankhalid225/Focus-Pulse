import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../core/services/haptic_service.dart';
import '../../../streak/domain/streak_controller.dart';
import '../widgets/restart_button.dart';
import '../widgets/success_animation.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class CompletionPage extends StatefulWidget {
  const CompletionPage({super.key});

  @override
  State<CompletionPage> createState() => _CompletionPageState();
}

class _CompletionPageState extends State<CompletionPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StreakController>().completeSprint();
      HapticService.success();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.mainGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SuccessAnimation(),
            const SizedBox(height: 40),
            
            Text(
              "Focus Session Complete",
              style: AppTextStyles.bodyPrimary.copyWith(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms)
                .move(begin: const Offset(0, 20), end: const Offset(0, 0), duration: 600.ms),

            const SizedBox(height: 12),

            Text(
              "Great work on your streak!",
              style: AppTextStyles.bodySecondary.copyWith(fontSize: 16),
            )
                .animate()
                .fadeIn(delay: 700.ms)
                .move(begin: const Offset(0, 10), end: const Offset(0, 0), duration: 600.ms),

            const SizedBox(height: 80),

            // Restart Button (Go Again)
            RestartButton(
              onTap: () {
                context.goNamed('home'); // For now goes back to home to pick mode
              },
            )
                .animate()
                .fadeIn(delay: 900.ms)
                .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), curve: Curves.elasticOut, duration: 800.ms),

            const SizedBox(height: 32),

            // Back to Home Button
            TextButton.icon(
              onPressed: () => context.goNamed('home'),
              icon: const Icon(Icons.home_outlined, color: AppColors.textSecondary),
              label: const Text(
                "Back to Main Menu",
                style: AppTextStyles.bodySecondary,
              ),
            )
                .animate()
                .fadeIn(delay: 1100.ms),
          ],
        ),
      ),
    );
  }
}
