import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/presentation/common/widgets/tonal_button_danger.dart';
import 'package:serealappv2/presentation/notes_tab/controllers/notes_tab_controller.dart';

class NotesTab extends ConsumerWidget {
  const NotesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyLogs = ref.watch(notesTabControllerProvider);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TonalButtonDanger(
                icon: const Icon(Icons.delete_forever),
                onPressed: () =>
                    ref.read(notesTabControllerProvider.notifier).deleteAll,
              ),
            ],
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
