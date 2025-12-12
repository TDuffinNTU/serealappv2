import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/presentation/theme/controllers/theme_controller.dart';
import 'package:serealappv2/services/theme/service/sereal_theme_service.dart';

class BrighnessToggleButton extends ConsumerWidget {
  const BrighnessToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      onPressed: () =>
          ref.read(themeControllerProvider.notifier).toggleBrightness(),
      icon: Icon(
        ref.watch(themeServiceProvider).mode == ThemeMode.light
            ? Icons.sunny
            : Icons.nightlight,
      ),
    );
  }
}
