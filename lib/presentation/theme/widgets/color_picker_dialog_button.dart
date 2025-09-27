import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/services/theme/sereal_theme_service.dart';

class ColorPickerDialogButton extends ConsumerStatefulWidget {
  const ColorPickerDialogButton({
    super.key,
  });

  @override
  ConsumerState<ColorPickerDialogButton> createState() => _ColorPickerDialogButtonState();
}

class _ColorPickerDialogButtonState extends ConsumerState<ColorPickerDialogButton> {
  late Color col;

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);
    return IconButton(
      icon: const Icon(Icons.color_lens),
      onPressed: () => showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ColorPicker(
                pickerAreaBorderRadius: const BorderRadius.all(Radius.elliptical(16, 16)),
                pickerColor: theme.color,
                onColorChanged: (c) => setState(
                  () {
                    col = c;
                  },
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                unawaited(
                  ref.read(themeServiceProvider.notifier).update(
                        (old) => old.copyWith(
                          color: col,
                        ),
                      ),
                );
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              onPressed: Navigator.of(context).pop,
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
