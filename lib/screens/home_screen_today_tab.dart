import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';

class HomeScreenTodayTab extends ConsumerWidget {
  const HomeScreenTodayTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterCarousel(
      items: [
        LogWidget(provider: yesterdayLogProvider),
        LogWidget(provider: todayLogProvider),
        LogWidget(provider: tomorrowLogProvider),
      ],
      options: CarouselOptions(
        initialPage: 1,
        enlargeCenterPage: true,
        floatingIndicator: true,
        height: 800,
        slideIndicator: CircularSlideIndicator(
          // TODO pick better colours?
          currentIndicatorColor: Theme.of(context).colorScheme.primary,
          indicatorBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}

class LogWidget extends ConsumerWidget {
  const LogWidget({super.key, required this.provider});
  final AutoDisposeFutureProvider<DailyLog> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          data: (log) => CarouselLog3(
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

class CarouselLog3 extends ConsumerWidget {
  const CarouselLog3({super.key, required this.log});

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
