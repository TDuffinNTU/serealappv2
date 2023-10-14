import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/utils/sizing.dart';
import 'package:serealappv2/utils/string_extensions.dart';

class LogWidget extends ConsumerWidget {
  const LogWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getLogProvider(date)).when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          // TODO fade-in when loaded :)
          data: (log) => _LogWidgetContent(
            log: log,
          ),
          error: (_, __) => Card(
            child: Center(
              child: Text('Error'),
            ),
          ),
          loading: () => Card(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}

class _LogWidgetContent extends ConsumerWidget {
  const _LogWidgetContent({required this.log});

  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: Sizing.screenPadding,
        right: Sizing.xs,
        left: Sizing.xs,
      ),
      child: Column(
        children: [
          Text(
            '${DateTime.now().dateOnly == log.date ? 'Today' : Jiffy.parse(log.date.toString()).MMMMEEEEd}',
          ),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: EdgeInsets.all(Sizing.s),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  _LogWidgetSectionHeader(
                    title: 'Meals',
                    onAdd: () => {},
                  ),
                  _LogWidgetItemList(
                    items: log.meals
                        .map((e) => (
                              title: e.name,
                              subtitle: e.note,
                              isChecked: e.complete,
                              onChecked: (_) {},
                            ))
                        .toList(),
                  ),
                  _LogWidgetSectionHeader(
                    title: 'Snacks',
                    onAdd: () => {},
                  ),
                  _LogWidgetItemList(
                    items: log.snacks
                        .map((e) => (
                              title: e.name,
                              subtitle: e.note,
                              isChecked: e.complete,
                              onChecked: (_) {},
                            ))
                        .toList(),
                  ),
                  _LogWidgetSectionHeader(
                    title: 'Plans',
                    onAdd: () => {},
                  ),
                  _LogWidgetItemList(
                    items: log.todos
                        .map((e) => (
                              title: e.name,
                              subtitle: null,
                              isChecked: e.complete,
                              onChecked: (_) {},
                            ))
                        .toList(),
                  ),
                  _LogWidgetSectionHeader(
                    title: 'Thoughts',
                    onAdd: null,
                  ),
                  Placeholder(
                    fallbackHeight: 400,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogWidgetSectionHeader extends StatelessWidget {
  const _LogWidgetSectionHeader({
    required this.title,
    required this.onAdd,
  });

  final VoidCallback? onAdd;
  final String title;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
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
    );
  }
}

class _LogWidgetItemList<T> extends StatelessWidget {
  const _LogWidgetItemList({
    required this.items,
  });

  final List<({String title, String? subtitle, bool isChecked, Function(bool?) onChecked})> items;

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
          (index) => _LogWidgetListTile(
            onChecked: items[index].onChecked,
            isDark: index % 2 == 0,
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

class _LogWidgetListTile extends StatelessWidget {
  const _LogWidgetListTile({
    required this.isDark,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.onChecked,
    required this.image,
  });

  final bool isDark;
  final String title;
  final String? subtitle;
  final bool isChecked;
  final String? image;
  final Function(bool?)? onChecked;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: isDark ? Theme.of(context).cardColor.withOpacity(0.7) : null,
      child: Row(
        children: [
          SizedBox(width: 8),
          Checkbox(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(2.0),
            ),
            side: MaterialStateBorderSide.resolveWith(
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
                    color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.4),
                  ),
                ),
            ],
          ),
          Spacer(),
          if (image != null)
            Align(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 110),
                // TODO image decoding.
                // child: Image(
                //   width: 110,
                //   fit: BoxFit.cover,
                //   errorBuilder: (context, _, __) => Container(
                //     color: Colors.purpleAccent,
                //     width: 200,
                //     height: 200,
                //   ),
                //   image: NetworkImage('https://picsum.photos/id/${Random().nextInt(100)}/200/200'),
                // ),
              ),
            ),
        ],
      ),
    );
  }
}
