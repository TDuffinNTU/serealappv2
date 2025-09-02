import 'package:flutter/material.dart';
import 'package:serealappv2/presentation/theme/widgets/color_picker_dialog_button.dart';

class NotesTab extends StatelessWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Notes coming soon!'),
          ColorPickerDialogButton(),
        ],
      ),
    );
  }
}
