import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/utils/sizing.dart';

class LogWidget extends ConsumerWidget {
  const LogWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getLogProvider(date)).when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
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
                  Placeholder(
                    fallbackHeight: 200,
                  ),
                  _LogWidgetSectionHeader(
                    title: 'Snacks',
                    onAdd: () => {},
                  ),
                  Placeholder(
                    fallbackHeight: 100,
                  ),
                  _LogWidgetSectionHeader(
                    title: 'Plans',
                    onAdd: () => {},
                  ),
                  Placeholder(
                    fallbackHeight: 200,
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

class _LogWidgetSectionHeader extends ConsumerWidget {
  const _LogWidgetSectionHeader({
    required this.title,
    required this.onAdd,
  });

  final VoidCallback? onAdd;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
