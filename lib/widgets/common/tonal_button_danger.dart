import 'package:flutter/material.dart';

class TonalButtonDanger extends StatelessWidget {
  const TonalButtonDanger({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton.filledTonal(
      onPressed: onPressed,
      icon: DefaultTextStyle(
        style: TextStyle(
          color: ColorScheme.of(context).onError,
        ),
        child: icon,
      ),
      style: IconButton.styleFrom(
        backgroundColor: ColorScheme.of(context).error,
        foregroundColor: ColorScheme.of(context).onError,
      ),
    );
  }
}
