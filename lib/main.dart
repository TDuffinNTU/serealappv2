import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_navigation_bar.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_scaffold.dart';
import 'package:serealappv2/presentation/notes_tab/widgets/notes_tab.dart';
import 'package:serealappv2/presentation/theme/widgets/brightness_toggle_button.dart';
import 'package:serealappv2/presentation/theme/widgets/color_picker_dialog_button.dart';
import 'package:serealappv2/services/theme/sereal_flex_theme.dart';
import 'package:serealappv2/services/theme/sereal_theme_service.dart';
import 'package:serealappv2/utils/sereal_logger.dart';
// import 'presentation/notes_tab/widgets/notes_tab.dart';
// import 'presentation/today_tab/widgets/today_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget with SerealLoggerMixin {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));

    final theme = ref.watch(themeServiceProvider);
    logInfo(theme.toString());

    return MaterialApp(
      title: 'Sereal',
      theme: SerealFlexTheme.lightTheme(theme.color),
      darkTheme: SerealFlexTheme.darkTheme(theme.color),
      themeMode: theme.mode,
      home: const HomeScreen(),
    );
  }
}

/// Common navigator bar and tab selection for homescreen tabs.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<Widget> homeScreenTabs = [
    const NotesTab(),
    // TodayTab(),
    // HistoryTab(),
  ];

  late Widget selectedTab = homeScreenTabs[1];

  void selectTab(int tab) {
    return;
    // setState(() => selectedTab = homeScreenTabs[tab]);
  }

  @override
  Widget build(BuildContext context) {
    return SerealScaffold(
      appBarActions: const [
        BrighnessToggleButton(),
        ColorPickerDialogButton(),
      ],
      title: 'Hello world!',
      body: const NotesTab(),
      bottomNavigationBar: SerealNavigationBar(
        onTabSelected: selectTab,
        initialTab: 0,
      ),
    );
  }
}
