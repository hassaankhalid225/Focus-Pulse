import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class BigStartButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const BigStartButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  State<BigStartButton> createState() => _BigStartButtonState();
}

class _BigStartButtonState extends State<BigStartButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.93 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.accentGlow.withOpacity(0.8),
                AppColors.accentGlow.withOpacity(0.2),
                Colors.transparent,
              ],
              stops: const [0.0, 0.6, 1.0],
            ),
            border: Border.all(
              color: AppColors.accentSoft.withOpacity(0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.accentGlow.withOpacity(0.4),
                blurRadius: 40,
                spreadRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: AppTextStyles.buttonBold,
            ),
          ),
        ),
      ),
    );
  }
}
