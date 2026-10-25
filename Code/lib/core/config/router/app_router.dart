import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qufu_shaolin_app/core/common/widgets/app_shell.dart';
import 'package:qufu_shaolin_app/features/home/presentation/pages/home_page.dart';
import 'package:qufu_shaolin_app/features/new_student/presentation/pages/new_student_page.dart';
import 'package:qufu_shaolin_app/features/news/presentation/pages/news_page.dart';
import 'package:qufu_shaolin_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:qufu_shaolin_app/features/school_info/presentation/pages/school_info_page.dart';
import 'package:qufu_shaolin_app/features/settings/presentation/pages/settings_page.dart';
import 'package:qufu_shaolin_app/features/styles/presentation/pages/styles_page.dart';

class AppRoutes {
  static const home = '/home';
  static const schedule = '/schedule';
  static const news = '/news';
  static const styles = '/styles';
  static const info = '/info';
  static const settings = '/settings';
  static const onboarding = '/onboarding';
  static const newStudent = '/new-student';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      // Bottom tabs
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(navigationShell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.home,
              builder: (context, state) => const HomePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.schedule,
              builder: (context, state) => const SchedulePage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.news,
              builder: (context, state) => const NewsPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.styles,
              builder: (context, state) => const StylesPage(),
            ),
          ]),
          StatefulShellBranch(routes: [
            GoRoute(
              path: AppRoutes.info,
              builder: (context, state) => const SchoolInfoPage(),
            ),
          ]),
        ],
      ),
      // Full-screen routes (no bottom bar)
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.newStudent,
        builder: (context, state) => const NewStudentPage(),
      ),
    ],
  );
});
