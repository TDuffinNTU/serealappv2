import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/providers/home_screen_logs.dart';
import 'package:serealappv2/models/providers/logs_collection.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/models/types/note.dart';

class HomeScreenTodayTab extends ConsumerWidget {
  const HomeScreenTodayTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getHomeScreenLogsProvider).when(
          skipError: false,
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          loading: () => SpinKitCircle(
            color: Theme.of(context).secondaryHeaderColor,
          ),
          error: (_, __) => Card(
            child: Center(
              child: Text('Failed to load logs.'),
            ),
          ),
          data: (logs) => FlutterCarousel(
            items: List.generate(
              logs.length,
              (i) => CarouselLog(
                log: logs[i],
              ),
            ),
            options: CarouselOptions(
              initialPage: 1,
              enlargeCenterPage: true,
              floatingIndicator: true,
              height: 800,
              slideIndicator: CircularSlideIndicator(
                // TODO pick better colours?
                currentIndicatorColor: Theme.of(context).primaryColorDark,
                indicatorBackgroundColor: Theme.of(context).primaryColorLight,
              ),
            ),
          ),
        );
  }
}

class CarouselLog extends ConsumerWidget {
  const CarouselLog({super.key, required this.log});

  final DailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          Text('${Jiffy.parse(log.date.toString()).MMMMEEEEd}'),
          SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Flex(
                direction: Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Meals'),
                  ...List.generate(
                    log.meals.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: Text(log.meals[index].name),
                          ),
                          Flex(
                            direction: Axis.horizontal,
                            children: [
                              Checkbox(value: true, onChanged: null),
                              SizedBox(width: 8),
                              Expanded(
                                child: TextField(
                                  controller: TextEditingController(
                                    text: log.meals[index].note,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Note'),
                  TextField(
                    controller: TextEditingController(text: log.note.content),
                    onSubmitted: (value) => saveLog(
                      ref,
                      log.copyWith(
                        note: Note(content: value),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> saveLog(WidgetRef ref, DailyLog log) {
    return ref.read(logsCollectionProvider.notifier).saveLog(log);
  }
}
