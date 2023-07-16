// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
// Services
import '/services/dio_provider.dart';
import '/services/secure_storage.dart';
import '/services/hive_storage.dart';

// My Controller are a mix between the Controller and Repository from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).
// It handles the management of the widget state. (Riverpod Controller's job)
// It handles the data parsing and serialilzation from api's. (Riverpod Repository's job).

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
    required this.dioProvider,
    required this.secureStorage,
    required this.hiveStorage,
  }) : super(
          RouteState(
            navigatorKey: GlobalKey<NavigatorState>(),
            routeSelected: NavBarRoutes.HOME,
            routeStack: const [],
          ),
        );

  Ref ref;
  // Dio
  DioProvider dioProvider;
  // Persist Data
  SecureStorage secureStorage;
  HiveStorage hiveStorage;

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
    dioProvider: ref.watch(dioProvider),
    secureStorage: ref.watch(secureStorageProvider),
    hiveStorage: ref.watch(hiveStorageProvider),
  );
});
