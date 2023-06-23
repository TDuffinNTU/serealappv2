import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/services/data/database_service.dart';
import 'package:serealappv2/models/services/tabs/home_tab_service.dart';
import 'package:serealappv2/widgets/sereal_navigation_bar.dart';
import 'package:serealappv2/widgets/sereal_scaffold.dart';

import 'home_screen_history_tab.dart';
import 'home_screen_notes_tab.dart';
import 'home_screen_today_tab.dart';

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
      appBarAction: IconButton(
        icon: Icon(Icons.delete_forever),
        onPressed: () async {
          (await ref.read(getDatabaseProvider.future)).deleteAllDocuments();
        },
      ),
      title: 'Welcome!',
      body: selectedTab,
      bottomNavigationBar: SerealNavigationBar(
        initialTab: 1,
        onTabSelected: selectTab,
      ),
    );
  }
}