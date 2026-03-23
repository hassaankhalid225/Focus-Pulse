import 'package:flutter/services.dart';

class HapticService {
  static void lightTick() {
    HapticFeedback.selectionClick();
  }

  static void mediumImpact() {
    HapticFeedback.mediumImpact();
  }

  static void success() {
    HapticFeedback.heavyImpact();
    Future.delayed(const Duration(milliseconds: 120), HapticFeedback.mediumImpact);
    Future.delayed(const Duration(milliseconds: 240), HapticFeedback.vibrate);
  }
}
