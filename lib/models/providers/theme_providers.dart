import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_providers.g.dart';

@riverpod
class AppBrightness extends _$AppBrightness {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  void toggle() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
