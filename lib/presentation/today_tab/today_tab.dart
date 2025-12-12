import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/presentation/today_tab/controllers/today_tab_controller.dart';
import 'package:serealappv2/presentation/today_tab/widgets/log_widget.dart';

/// Displays the daily logs. The dashboard of Sereal.
class TodayTab extends ConsumerWidget {
  const TodayTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dailyLogs = ref.watch(todayTabControllerProvider);

    final loadingContainer = List.generate(
      3,
      (_) => const Card.filled(
        child: SizedBox(
          height: 600,
          width: 300,
        ),
      ),
    );

    return FlutterCarousel(
      items: dailyLogs.when(
        data: (data) => data.map((e) => LogWidget(dailyLog: e)).toList(),
        error: (error, stackTrace) => loadingContainer,
        loading: () => loadingContainer,
      ),
      options: FlutterCarouselOptions(
        initialPage: 1,
        height: double.infinity,
        showIndicator: false,
      ),
    );
  }
}
