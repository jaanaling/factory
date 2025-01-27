import 'package:balloon_puzzle_factory/src/feature/rituals/presentation/collection_screen.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/presentation/levels_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/presentation/home_screen.dart';
import 'package:balloon_puzzle_factory/src/feature/rituals/presentation/achievement_screen.dart';

import 'package:balloon_puzzle_factory/src/feature/rituals/presentation/game_screen.dart';

import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();
final _articlesNavigatorKey = GlobalKey<NavigatorState>();
final _achievementsNavigatorKey = GlobalKey<NavigatorState>();

final _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(
            navigationShell: navigationShell,
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.home.path,
              builder: (BuildContext context, GoRouterState state) {
                return HomeScreen();
              },
              routes: <RouteBase>[
                GoRoute(
                  path: RouteValue.select.path,
                  builder: (BuildContext context, GoRouterState state) {
                    final extra = state.extra! as Map<String, dynamic>;
                    return LevelsScreen();
                  },
                ),
                GoRoute(
                  path: RouteValue.game.path,
                  builder: (BuildContext context, GoRouterState state) {
                    return GameScreen();
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _articlesNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.articles.path,
              builder: (BuildContext context, GoRouterState state) {
                return CollectionScreen();
              },
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _achievementsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.achievements.path,
              builder: (BuildContext context, GoRouterState state) {
                return const AchievementScreen();
              },
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
