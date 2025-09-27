import 'package:flutter/material.dart';
import 'package:serealappv2/presentation/theme/utils/sizing.dart' as sizing;

class LogNoteContainer extends StatelessWidget {
  const LogNoteContainer({required this.text, required this.onNoteTapped, super.key});

  /// Content of the note.
  final String? text;

  /// Called when note is tapped
  final VoidCallback onNoteTapped;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 4,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: GestureDetector(
        onTap: onNoteTapped,
        child: Container(
          color: Theme.of(context).cardColor.withValues(alpha: 0.7),
          padding: const EdgeInsets.all(sizing.m),
          constraints: const BoxConstraints(minHeight: 200),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(text ?? ''),
            ],
          ),
        ),
      ),
    );
  }
}
