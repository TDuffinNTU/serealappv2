import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/database_providers.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/utils/sizing.dart';
import 'package:serealappv2/widgets/common/tonal_button_danger.dart';

class HomeScreenHistoryTab extends ConsumerWidget {
  const HomeScreenHistoryTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Sizing.screenPadding),
      child: Center(
        child: ref.watch(filteredLogsProvider(filter: null)).when(
              data: (data) => ListView(
                  padding: EdgeInsets.symmetric(vertical: Sizing.screenPadding),
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: TonalButtonDanger(
                        onPressed: () => ref.read(databaseClearRecordsProvider),
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: Sizing.s,
                          children: [
                            Icon(Icons.delete_forever_outlined),
                            Text('Delete all'),
                          ],
                        ),
                      ),
                    ),
                    ...data.map(
                      (log) => Card(
                        child: Padding(
                          padding: EdgeInsets.all(Sizing.s),
                          child: Column(
                            spacing: Sizing.s,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: TonalButtonDanger(
                                  onPressed: () => ref.read(databaseDeleteRecordProvider(log: log)),
                                  icon: Icon(Icons.delete_outline),
                                ),
                              ),
                              Text(log.id),
                              Text(log.date.toString()),
                              Text(log.meals.toString()),
                              Text(log.snacks.toString()),
                              Text(log.todos.toString()),
                              Text(log.note.toString()),
                            ],
                          ),
                        ),
                      ),
                    )
                  ]),
              error: (Object error, StackTrace stackTrace) => null,
              loading: () => CircularProgressIndicator(),
            ),
      ),
    );
  }
}
