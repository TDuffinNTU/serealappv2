import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/models/providers/database_providers.dart';
import 'package:serealappv2/models/types/daily_log.dart';
import 'package:serealappv2/models/types/meal.dart';
import 'package:serealappv2/models/types/todo.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/utils/sizing.dart';
import 'package:serealappv2/widgets/logs/log_item_list.dart';
import 'package:serealappv2/widgets/logs/log_note_container.dart';
import 'package:serealappv2/widgets/logs/log_section_header.dart';

class LogContent extends ConsumerWidget {
  const LogContent({required this.log});

  final DailyLog log;

  /// Updates the log with new data. Triggers a rebuild.
  void _updateLog(WidgetRef ref, DailyLog updatedLog) {
    ref.read(databaseAddRecordProvider(log: updatedLog));
    ref.invalidate(getDatabaseProvider);
  }

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
                  LogWidgetItemList(
                    items: List.generate(
                      log.meals.length,
                      (index) => (
                        title: log.meals[index].name,
                        subtitle: log.meals[index].note,
                        isChecked: log.meals[index].complete,
                        onChecked: (checked) => _updateLog(
                              ref,
                              log.updateMeal(
                                index: index,
                                newMeal: log.meals[index].copyWith(complete: checked ?? false),
                              ),
                            ),
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
                  LogWidgetItemList(
                    items: List.generate(
                      log.snacks.length,
                      (index) => (
                        title: log.snacks[index].name,
                        subtitle: log.snacks[index].note,
                        isChecked: log.snacks[index].complete,
                        onChecked: (checked) => _updateLog(
                              ref,
                              log.updateSnack(
                                index: index,
                                newSnack: log.snacks[index].copyWith(complete: checked ?? false),
                              ),
                            ),
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
                  LogWidgetItemList(
                    items: List.generate(
                      log.todos.length,
                      (index) => (
                        title: log.todos[index].name,
                        subtitle: null,
                        isChecked: log.todos[index].complete,
                        onChecked: (checked) => _updateLog(
                              ref,
                              log.updateTodo(
                                index: index,
                                newTodo: log.todos[index].copyWith(complete: checked ?? false),
                              ),
                            ),
                      ),
                    ),
                  ),
                  // NOTES
                  LogSectionHeader(
                    title: 'Thoughts',
                    onAdd: null,
                  ),
                  LogNoteContainer(text: log.note.content),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
