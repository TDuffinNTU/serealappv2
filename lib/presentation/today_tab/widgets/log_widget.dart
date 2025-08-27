import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/domain/services/log_providers.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/domain/services/database_providers.dart';
import 'package:serealappv2/domain/data/daily_log.dart';
import 'package:serealappv2/domain/entities/meal.dart';
import 'package:serealappv2/domain/entities/todo.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/utils/sizing.dart';
import 'package:serealappv2/presentation/today_tab/widgets/checkable_list_tile.dart';
import 'package:serealappv2/presentation/today_tab/widgets/log_note_container.dart';
import 'package:serealappv2/presentation/today_tab/widgets/log_section_header.dart';
import 'package:serealappv2/presentation/edit_note_dialog/widgets/edit_note_dialog.dart';
import 'package:serealappv2/presentation/today_tab/widgets/list_container.dart';

class LogWidget extends ConsumerWidget {
  const LogWidget({super.key, required this.date});

  final DateTime date;

  /// Updates the log with new data. Triggers a rebuild.
  void _updateLog(WidgetRef ref, DailyLog updatedLog) {
    ref.read(databaseAddRecordProvider(
      id: updatedLog.id,
      data: updatedLog.toJson(),
      table: 'logs',
    ));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getLogProvider(date)).when(
          skipLoadingOnRefresh: true,
          skipLoadingOnReload: true,
          data: (log) => SingleChildScrollView(
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
                        // MEALS
                        LogSectionHeader(
                          title: 'Meals',
                          onAdd: () => _updateLog(
                            ref,
                            log.copyWith(
                              meals: log.meals.toList()
                                ..add(
                                  Meal.defaults('New Meal'),
                                ),
                            ),
                          ),
                        ),
                        ListContainer(
                          children: List.generate(
                            log.meals.length,
                            (index) => CheckableLogTile(
                              isLight: index % 2 == 0,
                              title: log.meals[index].name,
                              subtitle: log.meals[index].note,
                              isChecked: log.meals[index].complete,
                              onChecked: (checked) => _updateLog(
                                ref,
                                log.updateMeal(
                                  index: index,
                                  newMeal: log.meals[index].copyWith(complete: checked!),
                                ),
                              ),
                              image: null,
                            ),
                          ),
                        ),
                        // SNACKS
                        LogSectionHeader(
                          title: 'Snacks',
                          onAdd: () => _updateLog(
                            ref,
                            log.copyWith(
                              snacks: log.snacks.toList()
                                ..add(
                                  Meal.defaults('New Snack'),
                                ),
                            ),
                          ),
                        ),
                        ListContainer(
                          children: List.generate(
                            log.snacks.length,
                            (index) => CheckableLogTile(
                              isLight: index % 2 == 0,
                              title: log.snacks[index].name,
                              subtitle: log.snacks[index].note,
                              isChecked: log.snacks[index].complete,
                              onChecked: (checked) => _updateLog(
                                ref,
                                log.updateSnack(
                                  index: index,
                                  newSnack: log.snacks[index].copyWith(complete: checked!),
                                ),
                              ),
                              image: null,
                            ),
                          ),
                        ),
                        // TODOS
                        LogSectionHeader(
                          title: 'Plans',
                          onAdd: () => _updateLog(
                            ref,
                            log.copyWith(
                              todos: log.todos.toList()
                                ..add(
                                  Todo.defaults('New Plan'),
                                ),
                            ),
                          ),
                        ),
                        ListContainer(
                          children: List.generate(
                            log.todos.length,
                            (index) => CheckableLogTile(
                              isLight: index % 2 == 0,
                              title: log.todos[index].name,
                              subtitle: null,
                              isChecked: log.todos[index].complete,
                              onChecked: (checked) => _updateLog(
                                ref,
                                log.updateTodo(
                                  index: index,
                                  newTodo: log.todos[index].copyWith(complete: checked!),
                                ),
                              ),
                              image: null,
                            ),
                          ),
                        ),
                        // NOTES
                        LogSectionHeader(
                          title: 'Thoughts',
                          onAdd: null,
                        ),

                        Hero(
                          tag: log.id,
                          child: LogNoteContainer(
                            text: log.note.content,
                            onNoteTapped: () => Navigator.of(context).push(
                              PageRouteBuilder(
                                barrierDismissible: true,
                                opaque: false,
                                barrierColor: Colors.black.withValues(alpha: 0.5),
                                pageBuilder: (_, __, ___) => EditNoteDialog(
                                  heroTag: log.id,
                                  text: log.note.content ?? '',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
