import 'package:flutter/material.dart';
import 'package:serealappv2/utils/constants/sizing_constants.dart' as sizing;

class LogSectionHeader extends StatelessWidget {
  const LogSectionHeader({
    required this.title,
    required this.onAdd,
    super.key,
  });

  final VoidCallback? onAdd;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // Account for fact buttons are slightly taller than title text.
      constraints: const BoxConstraints(minHeight: sizing.logHeaderMinHeight),
      child: IntrinsicHeight(
        child: Stack(
          children: [
            Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (onAdd != null)
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonalIcon(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add),
                  label: const Text('Add'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
