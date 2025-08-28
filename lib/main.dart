import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/services/theme/theme_service.dart';
import 'package:serealappv2/services/theme/sereal_theme_model_extensions.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_navigation_bar.dart';
import 'package:serealappv2/presentation/common/widgets/sereal_scaffold.dart';
import 'presentation/history_tab/widgets/history_tab.dart';
import 'presentation/notes_tab/widgets/notes_tab.dart';
import 'presentation/today_tab/widgets/today_tab.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

    final Color col = ref.watch(themeControllerProvider).whenData((col) => col).value?.seedColor ??
        SerealTheme.defaultColor;

    return MaterialApp(
      title: 'Sereal',
      theme: SerealTheme.lightTheme(col),
      darkTheme: SerealTheme.darkTheme(col),
      themeMode: ref.watch(appBrightnessProvider),
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
    NotesTab(),
    TodayTab(),
    HistoryTab(),
  ];

  late Widget selectedTab = homeScreenTabs[1];

  void selectTab(int tab) {
    setState(() => selectedTab = homeScreenTabs[tab]);
  }

  @override
  Widget build(BuildContext context) {
    return SerealScaffold(
      appBarActions: [
        IconButton(
          icon: Icon(
            ref.watch(appBrightnessProvider) == ThemeMode.light
                ? Icons.light_mode
                : Icons.dark_mode,
          ),
          onPressed: ref.read(appBrightnessProvider.notifier).toggle,
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
