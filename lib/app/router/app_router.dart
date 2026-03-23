import 'package:go_router/go_router.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/settings_page.dart';
import '../../features/timer/presentation/pages/timer_page.dart';
import '../../features/completion/presentation/pages/completion_page.dart';
import '../../features/timer/domain/models/sprint_mode.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/timer',
      name: 'timer',
      builder: (context, state) {
        final mode = state.extra as SprintMode;
        return TimerPage(mode: mode);
      },
    ),
    GoRoute(
      path: '/done',
      name: 'completion',
      builder: (context, state) => const CompletionPage(),
    ),
  ],
);
