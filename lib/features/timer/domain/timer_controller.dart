import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:focuspulse/core/services/haptic_service.dart';
import 'package:focuspulse/core/services/sound_service.dart';
import 'package:focuspulse/features/timer/domain/models/timer_state.dart';
import 'package:focuspulse/features/timer/domain/models/sprint_mode.dart';

class TimerController extends ChangeNotifier {
  TimerState _state = TimerState.idle;
  Duration _remaining = Duration.zero;
  Timer? _ticker;
  SprintMode? _currentMode;
  
  // Settings
  bool tickSoundEnabled = false;

  TimerState get state => _state;
  Duration get remaining => _remaining;
  double get progress {
    if (_currentMode == null || _currentMode!.duration.inSeconds == 0) return 0;
    return _remaining.inSeconds / _currentMode!.duration.inSeconds;
  }

  void start(SprintMode mode) {
    _currentMode = mode;
    _remaining = mode.duration;
    _state = TimerState.running;
    _startTicker();
    notifyListeners();
  }

  void pause() {
    _state = TimerState.paused;
    _ticker?.cancel();
    notifyListeners();
  }

  void resume() {
    _state = TimerState.running;
    _startTicker();
    notifyListeners();
  }

  void reset() {
    _state = TimerState.idle;
    _ticker?.cancel();
    _remaining = Duration.zero;
    notifyListeners();
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
      _onTick();
    });
  }

  void _onTick() {
    if (_remaining.inSeconds > 0) {
      _remaining -= const Duration(seconds: 1);
      
      // Haptics & Sound
      if (_remaining.inSeconds <= 5 && _remaining.inSeconds > 0) {
        HapticService.mediumImpact();
        // Mandatory tick for last 5 seconds to alert user
        SoundService.playTick();
      } else {
        HapticService.lightTick();
        if (tickSoundEnabled) {
          SoundService.playTick();
        }
      }
      
      notifyListeners();
    } else {
      _ticker?.cancel();
      _state = TimerState.done;
      HapticService.success();
      SoundService.playComplete();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }
}
