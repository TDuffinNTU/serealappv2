import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_navigation_bar.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_scaffold.dart';
import 'package:serealappv2/presentation/notes_tab/widgets/notes_tab.dart';
import 'package:serealappv2/presentation/theme/widgets/brightness_toggle_button.dart';
import 'package:serealappv2/presentation/theme/widgets/color_picker_dialog_button.dart';
import 'package:serealappv2/services/theme/service/sereal_theme_service.dart';
import 'package:serealappv2/utils/constants/theme_constants.dart';
import 'package:serealappv2/utils/logging/sereal_logger.dart';
// import 'presentation/notes_tab/widgets/notes_tab.dart';
// import 'presentation/today_tab/widgets/today_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ProviderScope(child: MyApp()));
}

/// Eagerly load providers by watching their state before loading [MaterialApp].
///
/// Read more: https://riverpod.dev/docs/how_to/eager_initialization
class _EagerProviders extends ConsumerWidget {
  const _EagerProviders({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Load theme to avoid flash of "default" theme.
    ref.watch(themeServiceProvider);
    return child;
  }
}

class MyApp extends ConsumerWidget with SerealLoggerMixin {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    unawaited(SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge));

    final theme = ref.watch(themeServiceProvider);

    return _EagerProviders(
      child: MaterialApp(
        title: 'Sereal',
        theme: lightTheme(theme.color),
        darkTheme: darkTheme(theme.color),
        themeMode: theme.mode,
        home: const HomeScreen(),
      ),
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
