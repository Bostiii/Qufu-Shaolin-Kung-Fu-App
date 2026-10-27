import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_router/go_router.dart';

import 'package:qufu_shaolin_app/core/common/widgets/app_shell.dart';
import 'package:qufu_shaolin_app/features/home/presentation/pages/home_page.dart';
import 'package:qufu_shaolin_app/features/new_student/presentation/pages/new_student_page.dart';
import 'package:qufu_shaolin_app/features/news/presentation/pages/news_page.dart';
import 'package:qufu_shaolin_app/features/notifications/presentation/pages/notifications_page.dart';
import 'package:qufu_shaolin_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:qufu_shaolin_app/features/onboarding/presentation/welcome_screen.dart';
import 'package:qufu_shaolin_app/features/schedule/presentation/pages/schedule_page.dart';
import 'package:qufu_shaolin_app/features/school_info/presentation/pages/school_info_page.dart';
import 'package:qufu_shaolin_app/features/settings/presentation/pages/settings_page.dart';
import 'package:qufu_shaolin_app/features/splash/presentation/splash_screen.dart';
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
  static const notifications = '/notifications';
}

const _tabPaths = [
  AppRoutes.home,
  AppRoutes.schedule,
  AppRoutes.news,
  AppRoutes.styles,
  AppRoutes.info,
];

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Splash: the only page without the bottom bar
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(
          // ready: ref.read(startupProvider.future),  // optional: wait for real start-up work
          onFinished: () => context.go('/welcome'),
        ),
      ),

      // Everything else lives inside the shell = bottom bar on every page
      ShellRoute(
        pageBuilder: (context, state, child) => CustomTransitionPage(
          key: state.pageKey,
          transitionDuration: const Duration(milliseconds: 450),
          child: AppShell(
            location: state.uri.path,
            tabPaths: _tabPaths,
            child: child,
          ),
          transitionsBuilder: (context, animation, secondary, child) =>
              FadeTransition(opacity: animation, child: child),
        ),
        routes: [
          // Bottom tabs (each keeps its own navigation state)
          StatefulShellRoute.indexedStack(
            builder: (context, state, shell) => shell,
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

          // Other pages (bar still visible, no tab highlighted)
          GoRoute(
            path: '/welcome',
            builder: (context, state) => WelcomeScreen(
              onGetStarted: () => context.go(AppRoutes.onboarding),
              onLogin: () => context.go(AppRoutes.onboarding), // TODO: real login route in Phase 2
            ),
          ),
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
          //Notifications page
          GoRoute(
            path: AppRoutes.notifications,
            builder: (context, state) => const NotificationsPage(),
          ),
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
      ),
    ],
  );
});
