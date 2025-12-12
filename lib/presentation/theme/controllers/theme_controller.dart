import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:serealappv2/services/theme/models/sereal_theme.dart';
import 'package:serealappv2/services/theme/service/sereal_theme_service.dart';

part 'theme_controller.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  @override
  FutureOr<SerealTheme> build() async {
    return ref.watch(themeServiceProvider);
  }

  void toggleBrightness() {
    unawaited(
      ref.read(themeServiceProvider.notifier).update(
            (old) => old.copyWith(
              mode: switch (old.mode) {
                ThemeMode.dark => ThemeMode.light,
                _ => ThemeMode.dark,
              },
            ),
          ),
    );
  }

  bool get isDark => state.value?.mode == ThemeMode.dark;
}
