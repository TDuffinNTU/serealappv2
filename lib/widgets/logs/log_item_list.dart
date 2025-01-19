import 'package:flutter/material.dart';
import 'package:serealappv2/utils/string_extensions.dart';

class LogWidgetItemList extends StatelessWidget {
  const LogWidgetItemList({
    required this.items,
  });

  /// List of records representing common data to display in list tiles.
  ///
  /// Saves use having to manage each element as its own list.
  final List<
      ({
        String title,
        String? subtitle,
        bool isChecked,
        Function(bool?) onChecked,
      })> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      elevation: 0,
      color: Theme.of(context).colorScheme.primaryContainer,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          width: 4,
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
      child: Column(
        children: List.generate(
          items.length,
          (index) => _LogListTile(
            onChecked: items[index].onChecked,
            isLight: index % 2 == 0,
            isChecked: items[index].isChecked,
            subtitle: items[index].subtitle,
            title: items[index].title,
            image: null,
          ),
        ),
      ),
    );
  }
}

class _LogListTile extends StatelessWidget {
  const _LogListTile({
    required this.isLight,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChecked,
    required this.image,
  });

  final bool isLight;
  final String title;
  final String? subtitle;
  final bool isChecked;
  final String? image;
  final Function(bool?)? onChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: isLight ? Theme.of(context).cardColor.withValues(alpha: 0.7) : null,
      child: Row(
        children: [
          SizedBox(width: 8),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            side: WidgetStateBorderSide.resolveWith(
              (states) => BorderSide(
                width: 2.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
            value: isChecked,
            onChanged: onChecked,
          ),
          SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              if (!subtitle.isNullOrEmpty)
                Text(
                  subtitle!,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withValues(alpha: 0.4),
                  ),
                ),
            ],
          ),
          Spacer(),
          if (image != null)
            Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 110),
                child: Image(
                  width: 110,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => Container(
                    color: Colors.purpleAccent,
                    width: 200,
                    height: 200,
                  ),
                  image: NetworkImage('https://picsum.photos/id/${500}/200/200'),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
