import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serealappv2/models/providers/theme_providers.dart';
import 'package:serealappv2/screens/home_screen.dart';
import 'package:serealappv2/theme/sereal_theme.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Sereal',
      theme: SerealTheme().getTheme(),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ref.watch(appBrightnessProvider),
      home: const HomeScreen(),
    );
  }
}
