import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'core/services/storage_service.dart';
import 'features/streak/domain/streak_controller.dart';
import 'features/timer/domain/timer_controller.dart';
import 'features/timer/domain/audio_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize persistence
  await StorageService.init();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => StreakController()..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => TimerController(),
        ),
        ChangeNotifierProvider(
          create: (_) => AudioController(),
        ),
      ],
      child: const FocusPulseApp(),
    ),
  );
}
