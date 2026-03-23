import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:focuspulse/features/streak/domain/streak_controller.dart';
import 'package:focuspulse/features/timer/domain/models/sprint_mode.dart';
import 'package:focuspulse/features/timer/presentation/widgets/particle_overlay.dart';
import 'package:focuspulse/features/home/presentation/widgets/big_start_button.dart';
import 'package:focuspulse/features/home/presentation/widgets/mode_selector.dart';
import 'package:focuspulse/features/home/presentation/widgets/streak_badge.dart';
import 'package:focuspulse/app/theme/app_colors.dart';
import 'package:focuspulse/app/theme/app_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SprintMode _selectedMode = SprintMode.short;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ParticleOverlay(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.mainGradient,
          ),
          child: SafeArea(
            child: Stack(
              children: [
                // Settings Top Left
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.settings_outlined, color: AppColors.textSecondary),
                    onPressed: () => context.push('/settings'),
                  ),
                ),

                // Streak Badge Top Right
                const Positioned(
                  top: 20,
                  right: 24,
                  child: StreakBadge(),
                ),

                // Main Content
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 60),
                    // App Title
                    const Text(
                      "FOCUSPULSE",
                      style: AppTextStyles.title,
                    ),
                    const SizedBox(height: 80),

                    // Mode Selector
                    ModeSelector(
                      selectedMode: _selectedMode,
                      onModeChanged: (mode) {
                        setState(() => _selectedMode = mode);
                      },
                    ),
                    const SizedBox(height: 100),

                    // Big Start Button
                    BigStartButton(
                      label: "Start ${_selectedMode.label}\nFocus",
                      onTap: () {
                        context.push('/timer', extra: _selectedMode);
                      },
                    ),

                    const Spacer(),

                    // Total Sprints Label
                    Consumer<StreakController>(
                      builder: (context, controller, child) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text(
                            "Total sprints: ${controller.data.totalSprintsAllTime}",
                            style: AppTextStyles.bodySecondary,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
