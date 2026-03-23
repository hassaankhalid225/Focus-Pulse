import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:focuspulse/core/utils/time_formatter.dart';
import 'package:focuspulse/features/timer/domain/models/sprint_mode.dart';
import 'package:focuspulse/features/timer/domain/models/timer_state.dart' as ts;
import 'package:focuspulse/features/timer/domain/timer_controller.dart';
import 'package:focuspulse/features/timer/domain/audio_controller.dart';
import 'package:focuspulse/features/timer/presentation/widgets/countdown_ring.dart';
import 'package:focuspulse/features/timer/presentation/widgets/particle_overlay.dart';
import 'package:focuspulse/features/timer/presentation/widgets/timer_controls.dart';
import 'package:focuspulse/app/theme/app_colors.dart';
import 'package:focuspulse/app/theme/app_text_styles.dart';

class TimerPage extends StatefulWidget {
  final SprintMode mode;

  const TimerPage({super.key, required this.mode});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final audioController = context.read<AudioController>();
      final timerController = context.read<TimerController>();
      
      // Update timer settings from audio settings
      timerController.tickSoundEnabled = audioController.isTicksEnabled;
      timerController.start(widget.mode);
      audioController.play();
    });
  }

  void _stopAndGoHome() {
    context.read<TimerController>().reset();
    context.read<AudioController>().stop();
    context.goNamed('home');
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _stopAndGoHome();
        }
      },
      child: Scaffold(
        body: ParticleOverlay(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.mainGradient,
            ),
            child: SafeArea(
              child: Consumer<TimerController>(
                builder: (context, controller, child) {
                  if (controller.state == ts.TimerState.done) {
                    // Stop music on completion
                    context.read<AudioController>().stop();
                    
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) context.pushReplacement('/done');
                    });
                  }

                  return Column(
                    children: [
                      // App Bar Area
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios, color: AppColors.textSecondary, size: 20),
                              onPressed: _stopAndGoHome,
                            ),
                            Text(
                              "${widget.mode.label} Sprint",
                              style: AppTextStyles.bodySecondary.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(width: 48), // Spacer for centering title
                          ],
                        ),
                      ),

                      const Spacer(),

                      // Countdown Ring
                      CountdownRing(
                        progress: controller.progress,
                        time: TimeFormatter.formatDuration(controller.remaining),
                      ),

                      const Spacer(),

                      // Timer Controls
                      const Padding(
                        padding: EdgeInsets.only(bottom: 60),
                        child: TimerControls(),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
