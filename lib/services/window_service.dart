// Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

class WindowService {
  WindowService({required this.ref});

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

      const initialSize = Size(900, 530);
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

final windowService = Provider<WindowService>((ref) => WindowService(ref: ref));
