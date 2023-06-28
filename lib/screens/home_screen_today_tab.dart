import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/log_providers.dart';
import 'package:serealappv2/widgets/log_widget.dart';

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
          currentIndicatorColor: Theme.of(context).colorScheme.primary,
          indicatorBackgroundColor: Theme.of(context).colorScheme.primaryContainer,
        ),
      ),
    );
  }
}
