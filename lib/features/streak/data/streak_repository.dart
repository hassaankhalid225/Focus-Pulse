import 'dart:convert';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/storage_service.dart';
import '../domain/models/streak_data.dart';

class StreakRepository {
  Future<StreakData> load() async {
    final rawData = StorageService.getString(AppConstants.streakDataKey);
    if (rawData == null) return StreakData.initial();
    try {
      return StreakData.fromJson(json.decode(rawData));
    } catch (_) {
      return StreakData.initial();
    }
  }

  Future<void> save(StreakData data) async {
    await StorageService.setString(
      AppConstants.streakDataKey,
      json.encode(data.toJson()),
    );
  }
}
