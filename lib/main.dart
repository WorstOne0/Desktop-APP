// Flutter packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// Controllers
import 'controllers/core/socket_io_controller.dart';
// Pages
import '/pages/splash_screen.dart';
// Services
import '/services/storage/secure_storage.dart';
import '/services/navigator_provider.dart';
// Styles
import '/styles/style_config.dart';

// Flutter Platform Channels - To make my own plugins
// https://medium.com/flutter/flutter-platform-channels-ce7f540a104e
// https://www.kodeco.com/30342553-platform-specific-code-with-flutter-method-channel-getting-started

void main() async {
  // Flutter initialization
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();
  await Hive.openLazyBox("dollars_box");

  // *** RIVERPOD ***
  // State management with Riverpod (https://codewithandrea.com/articles/flutter-state-management-riverpod/)

  // Startup (https://codewithandrea.com/articles/riverpod-initialize-listener-app-startup/)
  // 1. Create a ProviderContainer
  final container = ProviderContainer(observers: []);
  // 2. Use it to read the provider

  // This starts the Socket IO listener
  container.read(socketIOProvider.notifier).connectAndListen();

  // Dark Mode
  String? stringDarkMode = await container.read(secureStorageProvider).readString("dark_mode");
  bool isDark = stringDarkMode == "true" || stringDarkMode == null;

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(
        isDark: isDark,
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({required this.isDark, super.key});

  final bool isDark;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Theme Provider - Package for the animate the switching between themes
    return ThemeProvider(
      initTheme: isDark ? dark() : light(),
      duration: const Duration(milliseconds: 500),
      // GetX package - adds useful funcionalities
      builder: (_, theme) => GetMaterialApp(
        title: 'Dollars',
        onGenerateTitle: (context) => "Dollars",
        debugShowCheckedModeBanner: false,
        theme: theme,
        // Always start at Splash Screen
        home: const SplashScreen(),
        // Support PT-BR in dates
        localizationsDelegates: const [
          ...GlobalMaterialLocalizations.delegates,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: const [Locale('pt', 'BR')],
        // (https://github.com/rrousselGit/riverpod/issues/268)
        navigatorKey: ref.watch(navigatorKeyProvider),
      ),
    );
  }
}
