import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/database_providers.dart';
import 'package:serealappv2/models/providers/theme_providers.dart';
import 'package:serealappv2/widgets/sereal_navigation_bar.dart';
import 'package:serealappv2/widgets/sereal_scaffold.dart';

import 'home_screen_history_tab.dart';
import 'home_screen_notes_tab.dart';
import 'home_screen_today_tab.dart';

/// Common navigator bar and tab selection for homescreen tabs.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> homeScreenTabs = [
    HomeScreenNotesTab(),
    HomeScreenTodayTab(),
    HomeScreenHistoryTab(),
  ];

  late Widget selectedTab = homeScreenTabs[1];

  void selectTab(int tab) {
    setState(() {
      selectedTab = homeScreenTabs[tab];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SerealScaffold(
      appBarActions: [
        IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: () {
            ref.read(databaseClearRecordsProvider);
          },
        ),
        IconButton(
          icon: Icon(
            ref.watch(appBrightnessProvider) == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          onPressed: () {
            ref.read(appBrightnessProvider.notifier).toggle();
          },
        ),
      ],
      title: 'Welcome!',
      body: selectedTab,
      bottomNavigationBar: SerealNavigationBar(
        initialTab: 1,
        onTabSelected: selectTab,
      ),
    );
  }
}
