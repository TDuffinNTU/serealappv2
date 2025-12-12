import 'package:flutter/material.dart';
import 'package:serealappv2/utils/extensions/string_extensions.dart';

class CheckableLogTile extends StatelessWidget {
  const CheckableLogTile({
    required this.isLight,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChecked,
    required this.image,
    super.key,
  });

  final bool isLight;
  final String title;
  final String? subtitle;
  final bool isChecked;
  final String? image;
  final void Function({bool? checked})? onChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color:
          isLight ? Theme.of(context).cardColor.withValues(alpha: 0.7) : null,
      child: Row(
        children: [
          const SizedBox(width: 8),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2),
            ),
            side: WidgetStateBorderSide.resolveWith(
              (states) => BorderSide(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            value: isChecked,
            onChanged: (checked) => onChecked?.call(checked: checked),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              if (!subtitle.isNullOrEmpty)
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withValues(alpha: 0.4),
                  ),
                ),
            ],
          ),
          const Spacer(),
          if (image != null)
            Align(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 110),
                child: Image(
                  width: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => Container(
                    color: Colors.purpleAccent,
                    width: 200,
                    height: 200,
                  ),
                  image: const NetworkImage(
                    'https://picsum.photos/id/${500}/200/200',
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
