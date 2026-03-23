import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:focuspulse/features/timer/domain/audio_controller.dart';
import 'package:focuspulse/features/streak/domain/streak_controller.dart';
import 'package:focuspulse/app/theme/app_colors.dart';
import 'package:focuspulse/app/theme/app_text_styles.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.mainGradient),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  children: [
                    _buildSectionTitle("Audio Settings"),
                    const SizedBox(height: 16),
                    _buildAudioSettings(context),
                    const SizedBox(height: 32),
                    _buildSectionTitle("Data Management"),
                    const SizedBox(height: 16),
                    _buildDataSettings(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textSecondary, size: 20),
            onPressed: () => Navigator.of(context).pop(),
          ),
          const SizedBox(width: 8),
          Text("Settings", style: AppTextStyles.bodyPrimary.copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title.toUpperCase(),
      style: AppTextStyles.bodySecondary.copyWith(
        letterSpacing: 2,
        fontWeight: FontWeight.bold,
        color: AppColors.accentSoft,
      ),
    );
  }

  Widget _buildAudioSettings(BuildContext context) {
    return Consumer<AudioController>(
      builder: (context, controller, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.bgCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentGlow.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Ambient Sound", style: AppTextStyles.bodyPrimary),
                  Switch(
                    value: !controller.isMuted,
                    activeColor: AppColors.accentGlow,
                    onChanged: (value) => controller.toggleMute(),
                  ),
                ],
              ),
              const Divider(color: Colors.white10, height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Timer Tick Sound", style: AppTextStyles.bodyPrimary),
                  Switch(
                    value: controller.isTicksEnabled,
                    activeColor: AppColors.accentGlow,
                    onChanged: (value) => controller.toggleTicks(),
                  ),
                ],
              ),
              const Divider(color: Colors.white10, height: 32),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: AmbientSound.values.map((sound) {
                  final isSelected = controller.selectedSound == sound;
                  return ChoiceChip(
                    label: Text(sound.label),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) controller.setSound(sound);
                    },
                    selectedColor: AppColors.accentGlow,
                    backgroundColor: AppColors.bgDeep,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.textSecondary,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDataSettings(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.bgCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.redAccent.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Clear App Data",
            style: AppTextStyles.bodyPrimary,
          ),
          const SizedBox(height: 8),
          const Text(
            "This will permanently delete your streaks and all sprint progress.",
            style: AppTextStyles.bodySecondary,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showResetConfirmation(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.withOpacity(0.1),
                foregroundColor: Colors.redAccent,
                elevation: 0,
                side: const BorderSide(color: Colors.redAccent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text("Reset Progress", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.bgCard,
        title: const Text("Reset Progress?"),
        content: const Text("Are you sure you want to clear all data? This cannot be undone."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel", style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              await context.read<StreakController>().resetProgress();
              if (context.mounted) {
                context.read<AudioController>().reload();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("All data has been reset.")),
                );
              }
            },
            child: const Text("Reset", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
