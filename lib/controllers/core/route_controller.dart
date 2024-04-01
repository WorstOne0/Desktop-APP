// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Services
import '/services/storage/secure_storage.dart';

enum NavBarRoutes { HOME, GAMES, ANIMES, GROUPS, PROFILE }

@immutable
class RouteState {
  const RouteState({
    required this.navigatorKey,
    required this.routeSelected,
    required this.routeStack,
  });

  // NavBar
  final GlobalKey<NavigatorState> navigatorKey;
  final NavBarRoutes routeSelected;

  // Window Frame
  final List<String> routeStack;

  RouteState copyWith({
    GlobalKey<NavigatorState>? navigatorKey,
    NavBarRoutes? routeSelected,
    List<String>? routeStack,
  }) {
    return RouteState(
      navigatorKey: navigatorKey ?? this.navigatorKey,
      routeSelected: routeSelected ?? this.routeSelected,
      routeStack: routeStack ?? this.routeStack,
    );
  }
}

class RouteController extends StateNotifier<RouteState> {
  RouteController({
    required this.ref,
    required this.secureStorage,
  }) : super(
          RouteState(
            navigatorKey: GlobalKey<NavigatorState>(),
            routeSelected: NavBarRoutes.HOME,
            routeStack: const [],
          ),
        );

  Ref ref;

  SecureStorage secureStorage;

  // NavBar Update Route Selected
  void changeNavBarRoute(NavBarRoutes? newRouteEnum) =>
      state = state.copyWith(routeSelected: newRouteEnum);

  // Add or Replace the Route Stack showed at WindowFrame
  void handleRouteStack(String action, String route) {
    List<String> routeStack = [...state.routeStack];

    switch (action) {
      case "push":
        state = state.copyWith(routeStack: routeStack..add(route));
        break;
      case "pop":
        state = state.copyWith(routeStack: routeStack..removeLast());
        break;
      case "replace all":
        state = state.copyWith(
          routeStack: routeStack
            ..clear()
            ..add(route),
        );
        break;
      case "replace last":
        state = state.copyWith(
          routeStack: routeStack
            ..removeLast()
            ..add(route),
        );
        break;
      default:
    }
  }
}

final routeProvider = StateNotifierProvider<RouteController, RouteState>((ref) {
  return RouteController(
    ref: ref,
    secureStorage: ref.watch(secureStorageProvider),
  );
});
