// Flutter
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

// https://codelabs.developers.google.com/codelabs/flutter-boring-to-beautiful?hl=pt-br#4
// https://m3.material.io/theme-builder#/custom

TonalPalette toTonalPalette(int value) {
  final color = Hct.fromInt(value);
  return TonalPalette.of(color.hue, color.chroma);
}

TonalPalette primaryTonalP = toTonalPalette(const Color(0xFF385B3E).value);

// Color Scheme
// Generated Primary - 0xFF106D34
ColorScheme lightColorScheme = const ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF216497),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFCFE5FF),
  onPrimaryContainer: Color(0xFF001D33),
  secondary: Color(0xFF7004C8),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFEFDBFF),
  onSecondaryContainer: Color(0xFF2B0053),
  tertiary: Color(0xFF685779),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFEFDBFF),
  onTertiaryContainer: Color(0xFF231533),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFAFA),
  onBackground: Color(0xFF1A1C19),
  surface: Color(0xFFFCFCFF),
  onSurface: Color(0xFF1A1C1E),
  surfaceVariant: Color(0xFFDEE3EB),
  onSurfaceVariant: Color(0xFF42474E),
  outline: Color(0xFF72777F),
  onInverseSurface: Color(0xFFF1F0F4),
  inverseSurface: Color(0xFF2F3033),
  inversePrimary: Color(0xFF98CBFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00639C),
  outlineVariant: Color(0xFFC2C7CF),
  scrim: Color(0xFF000000),
);

// Generated Primary - 0xFF84D994
ColorScheme darkColorScheme = const ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF216497),
  onPrimary: Color(0xFF003354),
  primaryContainer: Color(0xFF004A77),
  onPrimaryContainer: Color(0xFFCFE5FF),
  secondary: Color(0xFF7004C8),
  onSecondary: Color(0xFF470083),
  secondaryContainer: Color(0xFF6600B7),
  onSecondaryContainer: Color(0xFFEFDBFF),
  tertiary: Color(0xFFD4BEE6),
  onTertiary: Color(0xFF392A49),
  tertiaryContainer: Color(0xFF504061),
  onTertiaryContainer: Color(0xFFEFDBFF),
  error: Color(0xFFFFB4AB),
  errorContainer: Color(0xFF93000A),
  onError: Color(0xFF690005),
  onErrorContainer: Color(0xFFFFDAD6),
  background: Color(0xFF1A1C19),
  onBackground: Color(0xFFE2E3DE),
  surface: Color(0xFF1A1C1E),
  onSurface: Color(0xFFE2E2E5),
  surfaceVariant: Color(0xFF42474E),
  onSurfaceVariant: Color(0xFFC2C7CF),
  outline: Color(0xFF8C9199),
  onInverseSurface: Color(0xFF1A1C1E),
  inverseSurface: Color(0xFFE2E2E5),
  inversePrimary: Color(0xFF00639C),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF98CBFF),
  outlineVariant: Color(0xFF42474E),
  scrim: Color(0xFF000000),
);

// Default Design
ShapeBorder get shapeMedium => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    );

// Themes
CardTheme cardTheme(bool isDark) {
  return CardTheme(
    elevation: 0,
    shape: shapeMedium,
    color: isDark ? null : Colors.white,
    surfaceTintColor: !isDark ? null : Colors.white,
  );
}

AppBarTheme appBarTheme(ColorScheme colors, bool isDark) {
  return AppBarTheme(
    elevation: 0,
    backgroundColor: isDark ? colors.background : colors.primary,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    ),

    // MD3
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
  );
}

TabBarTheme tabBarTheme(ColorScheme colors) {
  return TabBarTheme(
    labelColor: colors.secondary,
    unselectedLabelColor: colors.onSurfaceVariant,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: colors.secondary,
          width: 2,
        ),
      ),
    ),
  );
}

BottomAppBarTheme bottomAppBarTheme(ColorScheme colors) {
  return BottomAppBarTheme(
    color: colors.surface,
    elevation: 0,
  );
}

BottomNavigationBarThemeData bottomNavigationBarTheme(ColorScheme colors) {
  return BottomNavigationBarThemeData(
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    backgroundColor: colors.background,
    selectedItemColor: colors.primary,
  );
}

FloatingActionButtonThemeData floatingActionButtonTheme(ColorScheme colors) {
  return FloatingActionButtonThemeData(
    backgroundColor: colors.primary,
    foregroundColor: Colors.white,
  );
}

DialogTheme dialogTheme(ColorScheme colors) {
  return DialogTheme(
    backgroundColor: colors.background,
    surfaceTintColor: Colors.transparent,
  );
}

ButtonThemeData buttonThemeData() {
  return const ButtonThemeData(
    height: 48,
  );
}

BottomSheetThemeData bottomSheetThemeData(ColorScheme colors) {
  return BottomSheetThemeData(
    backgroundColor: colors.background,
    surfaceTintColor: Colors.transparent,
  );
}

// Light
ThemeData light() {
  return ThemeData.light().copyWith(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    typography: Typography.material2021(colorScheme: lightColorScheme),
    appBarTheme: appBarTheme(lightColorScheme, false),
    cardTheme: cardTheme(false),
    dialogTheme: dialogTheme(lightColorScheme),
    // bottomAppBarTheme: bottomAppBarTheme(lightColorScheme),
    bottomNavigationBarTheme: bottomNavigationBarTheme(lightColorScheme),
    // tabBarTheme: tabBarTheme(lightColorScheme),
    floatingActionButtonTheme: floatingActionButtonTheme(lightColorScheme),
    buttonTheme: buttonThemeData(),
    bottomSheetTheme: bottomSheetThemeData(lightColorScheme),
  );
}

// Dark
ThemeData dark() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    typography: Typography.material2021(colorScheme: darkColorScheme),
    appBarTheme: appBarTheme(darkColorScheme, true),
    cardTheme: cardTheme(true),
    dialogTheme: dialogTheme(darkColorScheme),
    // bottomAppBarTheme: bottomAppBarTheme(darkColorScheme),
    bottomNavigationBarTheme: bottomNavigationBarTheme(darkColorScheme),
    // tabBarTheme: tabBarTheme(darkColorScheme),
    scaffoldBackgroundColor: darkColorScheme.background,
    floatingActionButtonTheme: floatingActionButtonTheme(darkColorScheme),
    buttonTheme: buttonThemeData(),
    bottomSheetTheme: bottomSheetThemeData(darkColorScheme),
  );
}
