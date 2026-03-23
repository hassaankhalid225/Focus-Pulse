import 'package:flutter/foundation.dart';
import 'package:focuspulse/core/services/storage_service.dart';
import 'package:focuspulse/features/streak/data/streak_repository.dart';
import 'package:focuspulse/features/streak/domain/models/streak_data.dart';

class StreakController extends ChangeNotifier {
  final StreakRepository _repository = StreakRepository();
  StreakData _data = StreakData.initial();

  StreakData get data => _data;

  Future<void> load() async {
    _data = await _repository.load();
    notifyListeners();
  }

  Future<void> completeSprint() async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    int newStreak = _data.currentStreak;
    DateTime? lastDate = _data.lastSprintDate;

    if (lastDate == null) {
      newStreak = 1;
    } else {
      final lastSprintDay = DateTime(lastDate.year, lastDate.month, lastDate.day);
      final difference = today.difference(lastSprintDay).inDays;

      if (difference == 1) {
        newStreak += 1;
      } else if (difference > 1) {
        newStreak = 1;
      }
      // If same day, streak remains current
    }

    _data = _data.copyWith(
      currentStreak: newStreak,
      totalSprintsAllTime: _data.totalSprintsAllTime + 1,
      lastSprintDate: now,
    );

    await _repository.save(_data);
    notifyListeners();
  }

  Future<void> resetProgress() async {
    await StorageService.clear();
    _data = StreakData.initial();
    notifyListeners();
  }
}
