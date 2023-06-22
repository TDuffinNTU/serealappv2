import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  List<Widget> homeScreenTabs = [
    HomeScreenNotesTab(),
    HomeScreenTodayTab(),
    HomeScreenHistoryTab(),
  ];

  late Widget selectedTab;

  void selectTab(int tab) {
    setState(() {
      selectedTab = homeScreenTabs[tab];
    });
  }

  @override
  void initState() {
    super.initState();
    selectedTab = homeScreenTabs[1];
  }

  @override
  Widget build(BuildContext context) {
    return SerealScaffold(
      appBarAction: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
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
