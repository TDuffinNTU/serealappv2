import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/utils/datetime_extensions.dart';
import 'package:serealappv2/widgets/logs/log_widget.dart';

/// Displays the daily logs. The dashboard of Sereal.
class HomeScreenTodayTab extends ConsumerWidget {
  const HomeScreenTodayTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FlutterCarousel(
      items: [
        LogWidget(date: DateTimeExtensions.yesterday()),
        LogWidget(date: DateTimeExtensions.today()),
        LogWidget(date: DateTimeExtensions.tomorrow()),
      ],
      options: FlutterCarouselOptions(
        initialPage: 1,
        height: double.infinity,
        showIndicator: false,
      ),
    );
  }
}
