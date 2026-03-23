import 'package:flutter/material.dart';

class AppColors {
  // Background
  static const Color bgDeep = Color(0xFF080B14);   // near-black navy
  static const Color bgMid = Color(0xFF0F1623);
  static const Color bgCard = Color(0xFF161D2E);

  // Accent
  static const Color accentGlow = Color(0xFF6C63FF);   // electric violet
  static const Color accentSoft = Color(0xFF9D97FF);

  // Text
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8892A4);

  // State
  static const Color success = Color(0xFF4EFFA0);      // mint green
  static const Color fire = Color(0xFFFF6B35);         // streak orange
  
  // Gradients
  static const LinearGradient mainGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [bgDeep, bgMid],
  );
}
