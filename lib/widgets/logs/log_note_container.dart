import 'package:flutter/material.dart';
import 'package:serealappv2/utils/sizing.dart';

class LogNoteContainer extends StatelessWidget {
  const LogNoteContainer({super.key, required this.text});

  /// Content of the note.
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 4,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Container(
        color: Theme.of(context).cardColor.withValues(alpha: 0.7),
        padding: EdgeInsets.all(Sizing.m),
        constraints: BoxConstraints(minHeight: 200),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text ?? ''),
          ],
        ),
      ),
    );
  }
}
