import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_providers.g.dart';

/// Fetches the active theme brightness and allows users to toggle it.
@riverpod
class AppBrightness extends _$AppBrightness {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  /// Toggles the brightness between light and dark.
  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
