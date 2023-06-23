import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/services/tabs/home_tab_service.dart';
import 'package:serealappv2/models/types/note.dart';

class HomeScreenTodayTab extends ConsumerWidget {
  const HomeScreenTodayTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: ref.watch(homeTabServiceProvider).when(
            loading: () => null,
            error: (_, __) => null,
            data: (logs) => FlutterCarousel(
              items: List.generate(
                logs.length,
                (i) => Column(
                  children: [
                    Text('${Jiffy.parse(logs[i].date.toString()).MMMMEEEEd}'),
                    SizedBox(height: 8),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              Text('Note: ${logs[i].note}\n'),
                              Text('Meals: ${logs[i].meals.toString()}\n'),
                              Text('Snacks: ${logs[i].snacks}\n'),
                              Text('Todos: ${logs[i].todos}'),
                              OutlinedButton(
                                  onPressed: () => ref
                                      .read(homeTabServiceProvider.notifier)
                                      .saveLog(logs[i].copyWith(
                                          note: Note(
                                              content:
                                                  '${logs[i].note.content}, hello world!'))),
                                  child: Text('add to db with note')),
                              FilledButton(
                                  onPressed: () => ref
                                      .read(homeTabServiceProvider.notifier)
                                      .deleteLog(logs[i]),
                                  child: Text('delete record')),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              options: CarouselOptions(
                initialPage: 1,
                enlargeCenterPage: true,
                floatingIndicator: false,
                slideIndicator: CircularSlideIndicator(
                  // TODO pick better colours?
                  currentIndicatorColor: Theme.of(context).primaryColorDark,
                  indicatorBackgroundColor: Theme.of(context).primaryColorLight,
                ),
              ),
            ),
          ),
    );
  }
}
