import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';

class HomeScreenHistoryTab extends ConsumerWidget {
  const HomeScreenHistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(filteredLogsProvider(filter: null)).when(
            data: (data) => ListView(
              children: List.generate(
                data.length,
                (index) {
                  final DailyLog log = data[index];
                  return Card(
                    child: Column(
                      children: [
                        Text(log.id),
                        Text(log.date.toString()),
                        Text(log.meals.toString()),
                        Text(log.snacks.toString()),
                        Text(log.todos.toString()),
                        Text(log.note.toString()),
                      ],
                    ),
                  );
                },
              ),
            ),
            error: (Object error, StackTrace stackTrace) => null,
            loading: () => CircularProgressIndicator(),
          ),
    );
  }
}
