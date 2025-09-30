import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/presentation/common/widgets/tonal_button_danger.dart';
import 'package:serealappv2/presentation/notes_tab/notes_tab_controller.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log_filter.dart';
import 'package:serealappv2/services/daily_logs/service/daily_logs_service.dart';

class NotesTab extends ConsumerWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(notesTabControllerProvider);
    final dailyLogs = ref.watch(dailyLogsServiceProvider(controller.filter));

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Center(
            child: TonalButtonDanger(
              icon: const Icon(Icons.filter_alt),
              onPressed: () =>
                  ref.read(notesTabControllerProvider.notifier).mutate(
                (_) {
                  return NotesTabControllerState(
                    filter: BetweenDatesFilter(
                      start: DateTime.now().subtract(const Duration(hours: 1)),
                      end: DateTime.now(),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        dailyLogs.when(
          data: (data) => SliverList.builder(
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Card(
                child: Text(
                  Jiffy.parseFromDateTime(data[index].date)
                      .format(pattern: 'ddo MMM yyyy @ HH:mm:s'),
                ),
              ),
            ),
          ),
          error: (error, stackTrace) =>
              SliverToBoxAdapter(child: ErrorWidget(error)),
          loading: () => const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}
