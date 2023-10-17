import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/widgets/logs/log_content.dart';

class LogWidget extends ConsumerWidget {
  const LogWidget({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getLogProvider(date)).when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          // TODO fade-in when loaded :)
          data: (log) => LogContent(
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
