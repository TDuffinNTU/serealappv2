import 'package:flutter/material.dart';

/// The custom theme for Sereal App.
///
/// Currently only supports light mode.
///
/// TODO split this out and implement `flex_color_scheme`.
/// TODO make this a provider ?
class SerealTheme {
  SerealTheme();

  late ColorScheme _colorScheme;

  ThemeData getTheme({int colorSeed = 0xFF5D6CBD}) {
    _colorScheme = ColorScheme.fromSeed(
      seedColor: Color(colorSeed),
      primary: Color(colorSeed),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: _colorScheme,
      navigationBarTheme: _navigationBarTheme,
      appBarTheme: _appBarTheme,
    );
  }

  /// The theme for [SerealNavigationBar].
  NavigationBarThemeData get _navigationBarTheme => NavigationBarThemeData(
        backgroundColor: _colorScheme.primary,
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(color: _colorScheme.onPrimary, fontSize: 12),
        ),
        iconTheme: MaterialStateProperty.resolveWith(
          (states) {
            if (states.any((s) => s == MaterialState.selected)) {
              return IconThemeData(color: _colorScheme.onPrimaryContainer);
            }
            return IconThemeData(color: _colorScheme.onPrimary);
          },
        ),
      );

  /// The theme for [SerealScaffold]'s app bar.
  AppBarTheme get _appBarTheme => AppBarTheme(
        backgroundColor: _colorScheme.primary,
        titleTextStyle: TextStyle(fontSize: 22),
        iconTheme: IconThemeData(color: _colorScheme.onPrimary),
      );
}
