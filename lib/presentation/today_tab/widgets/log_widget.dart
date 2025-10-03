import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:serealappv2/presentation/edit_note_dialog/widgets/edit_note_dialog.dart';
import 'package:serealappv2/presentation/today_tab/widgets/log_note_container.dart';
import 'package:serealappv2/presentation/today_tab/widgets/log_section_header.dart';
import 'package:serealappv2/services/daily_logs/models/daily_log.dart';
import 'package:serealappv2/utils/constants/sizing_constants.dart' as sizing;
import 'package:serealappv2/utils/extensions/datetime_extensions.dart';

class LogWidget extends ConsumerWidget {
  const LogWidget({required this.dailyLog, super.key});

  final DailyLog dailyLog;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        top: sizing.screenPadding,
        right: sizing.xs,
        left: sizing.xs,
      ),
      child: Column(
        children: [
          Text(
            today == dailyLog.date
                ? 'Today'
                : Jiffy.parse(dailyLog.date.toString()).MMMMEEEEd,
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(sizing.s),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  const LogSectionHeader(
                    title: 'Thoughts',
                    onAdd: null,
                  ),
                  Hero(
                    tag: dailyLog.guid,
                    child: LogNoteContainer(
                      text: '',
                      onNoteTapped: () => Navigator.of(context).push(
                        PageRouteBuilder<String>(
                          barrierDismissible: true,
                          opaque: false,
                          barrierColor: Colors.black.withValues(alpha: 0.5),
                          pageBuilder: (_, __, ___) => EditNoteDialog(
                            heroTag: dailyLog.guid,
                            text: '',
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
    );
  }
}
