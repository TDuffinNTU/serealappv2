import 'package:flutter/material.dart';
import 'package:serealappv2/utils/sizing.dart';

class EditNoteDialog extends StatelessWidget {
  const EditNoteDialog({super.key, required this.heroTag, required this.text});

  final String heroTag;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizing.screenPadding),
          child: Center(
            child: Hero(
              tag: heroTag,
              child: Card(
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
                child: TextFormField(
                  controller: TextEditingController(text: text),
                  maxLines: null,
                  minLines: 10,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).cardColor.withValues(alpha: 0.7),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
