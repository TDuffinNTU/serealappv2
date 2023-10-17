import 'package:flutter/material.dart';
import 'package:serealappv2/utils/sizing.dart';

class LogSectionHeader extends StatelessWidget {
  const LogSectionHeader({
    required this.title,
    required this.onAdd,
  });

  final VoidCallback? onAdd;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      // Account for fact buttons are slightly taller than title text.
      constraints: BoxConstraints(minHeight: Sizing.logHeaderMinHeight),
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
                  icon: Icon(Icons.add),
                  label: Text('Add'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
