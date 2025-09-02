import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/services/theme/theme_service.dart';

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
    return ref.watch(themeServiceProvider).when(
          error: (Object _, StackTrace __) => IconButton(
            onPressed: null,
            icon: Icon(Icons.color_lens),
          ),
          loading: () => IconButton(
            onPressed: null,
            icon: Icon(Icons.color_lens),
          ),
          data: (data) => IconButton(
            icon: Icon(Icons.color_lens),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorPicker(
                      pickerAreaBorderRadius: BorderRadius.all(Radius.elliptical(16, 16)),
                      pickerColor: data.seedColor,
                      onColorChanged: (c) => col = c,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    child: Text('Save'),
                    onPressed: () {
                      ref.read(themeServiceProvider.notifier).setSeedColor(col);
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    onPressed: Navigator.of(context).pop,
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
