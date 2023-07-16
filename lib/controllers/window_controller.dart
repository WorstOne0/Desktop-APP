// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

// My Controller are a mix between the Controller and Repository from the
// Riverpod Architecture (https://codewithandrea.com/articles/flutter-app-architecture-riverpod-introduction/).
// It handles the management of the widget state. (Riverpod Controller's job)
// It handles the data parsing and serialilzation from api's. (Riverpod Repository's job).

@immutable
class WindowState {
  const WindowState({
    required this.appWindow,
  });

  final dynamic appWindow;

  WindowState copyWith({dynamic? appWindow}) {
    return WindowState(
      appWindow: appWindow ?? this.appWindow,
    );
  }
}

class WindowController extends StateNotifier<WindowState> {
  WindowController({
    required this.ref,
  }) : super(const WindowState(appWindow: null));

  Ref ref;

  void splashScreenCallback() {
    doWhenWindowReady(() {
      // Get the window
      final win = appWindow;

      const initialSize = Size(600, 450);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Inicializando...";
      win.show();
    });
  }

  void loginCallback() {
    doWhenWindowReady(() {
      // Get the window
      final win = appWindow;

      const initialSize = Size(800, 530);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Dollars";
      win.show();
    });
  }

  void homeCallback() {
    doWhenWindowReady(() {
      // Get the window
      final win = appWindow;

      const initialSize = Size(700, 650);
      win.minSize = initialSize;
      win.size = initialSize;
      win.alignment = Alignment.center;
      win.title = "Dollars";
      win.show();
      win.maximize();
    });
  }
}

final windowProvider = StateNotifierProvider<WindowController, WindowState>((ref) {
  return WindowController(
    ref: ref,
  );
});
